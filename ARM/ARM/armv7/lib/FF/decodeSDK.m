/*
 ࿐工程名称：移动监控
 ࿐文件名称：decodeSDK.m
 ࿐创作作者：Created by 刘琦
 ࿐创建时间：on 16/7/7.
 ࿐版权所有：  Copyright © 2016年 🌴刘琦࿐. All rights reserved.
 ࿐个性签名：    Eyes not to tears.
 */

#import "decodeSDK.h"


#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
NetBufferManager recvBuffer;
#define VIDEO_STREAM 100
#define host_data_port 3356
#define RECV_NET_BUF_SIZE    1024*1024*10   //0xA00000
#define TMP_BUF_SIZE         0x1000
#define DECODE_BUF_SIZE      0x2800
unsigned char *Decodec_Before_Buffer;

@implementation decodeSDK

//程序退出 释放所有参数
-(void)clearnDevice
{
    if (&recvBuffer!=nil) {
        Free_Net_Buffer(&recvBuffer);
    }
    if (pcodeContext!=nil) {
        avcodec_close(pcodeContext);
    }
    if (Decodec_Before_Buffer!=nil) {
        av_free(Decodec_Before_Buffer);
    }
    cmsDemuxClose(demuxOpen);
    if (&apk!=nil) {
        av_free_packet(&apk);
    }
}
//退出登录
-(BOOL)CMS_Device_Logout:(AsyncSocket *)obSocket
{
    if(obSocket!=nil)
        [obSocket disconnect];
    if(dataAsyncSocket!=nil)
        [dataAsyncSocket  disconnect];
    isDecode=NO;
    isreadNetData=NO;
    isLogin=NO;
    isSendHeartPacket=NO;
    readCount=0;
    return YES;
}
#pragma mark - 发送心跳包
//使http保持长连接<这个心跳包可以复制，建议属性自己写>
-(void)sendHeartPacket
{
    if (isSendHeartPacket) {
        Byte cmdbyte[8];
        cmdbyte[0]=0xd;//main comm
        cmdbyte[1]=0;
        cmdbyte[3]=(Byte)(0xFF & 4>>8);//4:data size
        cmdbyte[2]=(Byte)(0xFF & 4);
        cmdbyte[7]=(Byte)(0xFF & 60>>24);
        cmdbyte[6]=(Byte)(0xFF & 60>>16);
        cmdbyte[5]=(Byte)(0xFF & 60>>8);
        cmdbyte[4]=(Byte)(0x3C & 0xFF );
        NSData * beatPack=[[NSData alloc]initWithBytes:cmdbyte length:8];
        //send heartbeat pack
        [cmdAsyncSocket writeData:beatPack withTimeout:(-1) tag:100];
        isSendHeartPacket=NO;
    }
    else
    {
        Byte cmdbyte[4];
        cmdbyte[0]=0xd; //main comm
        cmdbyte[1]=0;
        cmdbyte[3]=0;   //4:data size
        cmdbyte[2]=0;
        NSData * beatPack=[[NSData alloc]initWithBytes:cmdbyte length:4];
        //send heartbeat pack
        [cmdAsyncSocket writeData:beatPack withTimeout:(-1) tag:100];
    }
}

#pragma mark - 1.初始化所有对象
-(void)initDevice
{
    //ffmpeg初始化对象，只初始化一次
    
    //*********************ffmpeg*******************//
//    avcodec_init();
    AVCodec* codecid;
    //所有格式
    avcodec_register_all();
    codecid= avcodec_find_decoder(AV_CODEC_ID_H264);
    pcodeContext=avcodec_alloc_context3(codecid);
    pcodeContext->width = 352;
    pcodeContext->height = 288;
    pcodeContext->pix_fmt = AV_PIX_FMT_YUV420P;
    avcodec_open2(pcodeContext, codecid, NULL);
    pframe=av_frame_alloc();
    av_init_packet(&apk);
    //*********************ffmpeg*******************//
    
    //输出的宽高
    outputWidth=375/2;
    outputheight=575/2;
    //回调
    SEL sel=nil;
    //获取解密的内存句柄
    demuxOpen=cmsDemuxOpen();
    //定义回调函数,调用并注册回调函数，把sel,_hDemux,_fpCBDataOut作为实参传递给解密类中的函数
    //目的是在c语言的代码中，可以通过函数的地址来调用DemuxDataOut_CallBack_A
    fpCBDataOut dataout;
    //并把解密后的视频数据通过DemuxDataOut_CallBack_A送回来。
    dataout=DemuxDataOut_CallBack_A;
    //回调函数
    cmsDemuxDataOut_OC(self, sel, demuxOpen, 0, dataout);
    //创建大视频缓冲区
    Create_Net_Buffer(&recvBuffer, RECV_NET_BUF_SIZE);
    //创建解密需要的缓冲区
    Decodec_Before_Buffer=malloc(DECODE_BUF_SIZE);
    //用‘0’初始化缓冲区
    memset(Decodec_Before_Buffer, 0, DECODE_BUF_SIZE);
    //判断是否正在解码 是否读网络数据 是否登录 是否第一次发心跳包
    isDecode=YES;
    isreadNetData=NO;
    isLogin=NO;
    isSendHeartPacket=NO;
    //每次读网络数据包的大小
    readCount=0;
    //代理在.h中
    cmdAsyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
    dataAsyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
    //实例通讯协议类
    _cmsNetDemuxFilter=[[cmsNetDemuxFilter alloc]init];
    //创建多线程的前提
    myCondition=[[NSCondition alloc]init];
}
#pragma mark - 2.登录服务器 调发送心跳包方法
-(AsyncSocket *)login:(NSString *)ip :(int)port :(int)passW
{
    if (![cmdAsyncSocket connectToHost:ip onPort:port withTimeout:3 error:nil]) {
        return NO;
    }
    ipAddress=ip;
    passward=passW;
    //发送登录
    [cmdAsyncSocket writeData:[_cmsNetDemuxFilter GetDeviceloginCommand:passW] withTimeout:3 tag:100];
    [cmdAsyncSocket readDataWithTimeout:-1 tag:100];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendHeartPacket) userInfo:nil repeats:YES];
    return cmdAsyncSocket;
}
#pragma mark - 3.申请网络视频流数据
-(BOOL)realPlayChannle:(int)ChanNo :(uint)linkMode :(UIWindow *)ownWin :(UIImageView *)playImgCtr
{
    //判断是否登录成功
    if (!isLogin) {
        return NO;
    }
    if (playImgCtr==nil) {
        return NO;
    }
    imageView=playImgCtr;
    isDecode=YES;
    isreadNetData=NO;
    if (![dataAsyncSocket connectToHost:ipAddress onPort:host_data_port withTimeout:3 error:nil]) {
        return NO;
    }
    //申请数据，开启单独线程接受data
    NSData* data=[_cmsNetDemuxFilter GetDeviceVideoChannelCommand:passward :ChanNo];
    [dataAsyncSocket writeData:data withTimeout:-1 tag:ChanNo];
    //读取
    [dataAsyncSocket readDataWithTimeout:-1 tag:ChanNo];
    return YES;
}
//停止播放
-(void)stopRealPlay:(int)ChanNo
{
    if (dataAsyncSocket!=nil) {
        [dataAsyncSocket disconnect];
    }
    isDecode=NO;
    if (recvBuffer.net_buffer_original_ptr!=nil) {
        memset(recvBuffer.net_buffer_original_ptr,0,
               recvBuffer.net_buf_size);
    }
    return ;
}
//缓冲区
-(void)SelectRecvBySocketTag:(long)ChanTag :(Byte*)tBuf :(int)Packet_Byte_Size{
    switch (ChanTag) {
        case 0://1chan
            if(Packet_Byte_Size>0){
                Write_Net_Buffer(&recvBuffer, tBuf, readCount) ;
//                NSLog(@"*********** 接收通道 A  数据 ***********\r\n");
                if(!isreadNetData)
                {
                    [self startPlayThread];
                    isreadNetData=YES;
                }
            }
            //递归调用反复循环执行代理方法
            [dataAsyncSocket readDataWithTimeout:-1 tag:ChanTag];
            break;
        default:
            break;
    }
}
#pragma mark - 4.接收网络视频数据、写缓冲区(这是3个代理方法)
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    Byte * tbuffer=(Byte*)[data bytes];
    int length=data.length;
    unsigned long bytes_data_Size=sizeof(uint8_t)*length;
    Tmp_Recv_Buf_Size=bytes_data_Size;
    readCount=bytes_data_Size;
    [self SelectRecvBySocketTag:tag :tbuffer :readCount];
    [cmdAsyncSocket readDataWithTimeout:-1 tag:100];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    isLogin=NO;
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    //登录成功
    isLogin=YES;
    NSLog(@"登录成功");
}
#pragma mark - 5.创建播放线程、读缓冲区
-(void)startPlayThread
{
    myCondition=[[NSCondition alloc]init];
    avplayThread=[[NSThread alloc]initWithTarget:self selector:@selector(avplay) object:nil];
    [avplayThread start];
}
-(void)avplay
{
    int number=0;
    int temp=64;
    while (isDecode) {
        unsigned char cData[TMP_BUF_SIZE];
        int ref=[self Read_Recv_Queue_Data:number :cData :TMP_BUF_SIZE];
        if (ref==-1) {
            break;
        }
        unsigned char *cBefore=Decodec_Before_Buffer;
        memcpy(cBefore+temp, &cData, TMP_BUF_SIZE);
        cmsDemuxDataWrite(demuxOpen, cBefore+temp, TMP_BUF_SIZE);
    }
}
-(int)Read_Recv_Queue_Data:(int)chan :(uint8_t *)buf :(int)buf_size{
    
    int size = buf_size;
    int ret;
   	do {
        ret =Read_Net_Buffer(&recvBuffer, buf, buf_size);
    } while (ret);
    return size;
}
#pragma mark - 6.解密(解密文件写到了解码中，所以这一步空)

#pragma mark - 7.解码 显示
//回调函数，用于c和obj-c之间产生回调的桥梁
int DemuxDataOut_CallBack_A (id _obj,SEL _sel, Int32 pPara,
                             UInt8 *picpData,
                             UInt32 piDataSize,
                             UInt32 piFrameInfo,
                             UInt32 piTime,UInt64 pPts){    
    return [_obj RecvAndProcessDemuxDataOut_A:pPara :picpData :piDataSize :piFrameInfo :piTime :pPts];
}
//回调函数，负责接收解密后的数据（整体复制，其中自己定义的参数要改）
-(int)RecvAndProcessDemuxDataOut_A:(Int32) pPara :(UInt8*) picpData :(UInt32)piDataSize :(UInt32)piFrameInfo :(UInt32)piTime :(UInt64)pPts{
    //把解密后的数据，放入解码缓冲区内
    apk.data=(unsigned char*)picpData;
    apk.size=piDataSize;
    //定义变量用于接收解码后图像大小
    int got_picture_ptr=0;
    //判断如果如果解码参数和待解码数据不为空的话，那么就开始解码
    if((pcodeContext==NULL)||(apk.data==NULL))
        return 0;
    //调用的FFMPEG核心的解码器进行解码
    int nImageSize = avcodec_decode_video2(pcodeContext,/* 存放解码规格参数*/
                                           pframe,   /* 存放解码后的YUV数据，是输出*/
                                           &got_picture_ptr,   /* 解码后的图像大小，＝0，解码失败*/
                                           &apk /* 存放等待解码的数据，是入口 */  );
//    NSLog(@"nImageSize:%d--got_picture_ptr:%d",nImageSize,got_picture_ptr);
    //判断是否解码成功 >0代表成功 ，<=0表示解码的图像为空
    if(nImageSize>0)
    {
//        NSLog(@"*********** 通道 A  解 码 成 功 ***********\r\n");
        //调用标准方法释放空间
        av_free_packet(&apk);
        //上屏显示，在主线程中刷新
        [self performSelectorOnMainThread:@selector(dispalyAV) withObject:self waitUntilDone:YES];
    }
    return 1;
}
#pragma mark - 8.YUV->RGB UI显示
-(void)dispalyAV
{
    int chan=0;
    [self convertFrameToRGB:chan];
    //展示
    imageView.image=[self imageFromAVPicture:picture width:outputWidth height:outputheight];
}
-(void)convertFrameToRGB:(int)Chan{
    [self setupScaler:Chan];
    //converter
//    NSLog(@"start convertFrameToRGB***********");
    sws_scale (img_convert_ctx, pframe->data, pframe->linesize,
               0, pcodeContext->height,
               picture.data, picture.linesize);
}
-(void)setupScaler:(int)Chan{
//    NSLog(@"start setupScaler***********");
    // Release old picture and scaler
    avpicture_free(&picture);
    sws_freeContext(img_convert_ctx);
    // Allocate RGB picture
    avpicture_alloc(&picture, AV_PIX_FMT_RGB24, outputWidth, outputheight);
    // Setup scaler
    static int sws_flags =  SWS_FAST_BILINEAR;
    img_convert_ctx = sws_getContext(pcodeContext->width,
                                     pcodeContext->height,
                                     pcodeContext->pix_fmt,
                                     outputWidth,
                                     outputheight,
                                     AV_PIX_FMT_RGB24,
                                     sws_flags, NULL, NULL, NULL);
}
//这个代码直接复制，不需要知道什么意思
-(UIImage *)imageFromAVPicture:(AVPicture)pict width:(int)width height:(int)height {
//    NSLog(@"start imageFromAVPicture***********");
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CFDataRef data = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, pict.data[0], pict.linesize[0]*height,kCFAllocatorNull);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(width,
                                       height,
                                       8,
                                       24,
                                       pict.linesize[0],
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    CGColorSpaceRelease(colorSpace);
//    NSLog(@"&&&&&&&&  width: %d***********",width);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);
    CFRelease(data);
    return image;
}
@end
