/*
 ࿐工程名称：移动监控
 ࿐文件名称：decodeSDK.h
 ࿐创作作者：Created by 刘琦
 ࿐创建时间：on 16/7/7.
 ࿐版权所有：  Copyright © 2016年 🌴刘琦࿐. All rights reserved.
 ࿐个性签名：    Eyes not to tears.
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "utils.h"
#import "cmsNetDemuxFilter.h"
#import "cmsDemux.h"
#import "swscale.h"
#define DEV_CHAN_NUM
@interface decodeSDK : NSObject<AsyncSocketDelegate>
{
    //定义命令接口和数据
    AsyncSocket* cmdAsyncSocket,* dataAsyncSocket;
    cmsNetDemuxFilter* _cmsNetDemuxFilter;
    BOOL isSendHeartPacket;
    BOOL isDecode,isreadNetData,isLogin;
    int readCount;
    // ip和 密码
    NSString* ipAddress;
    NSInteger passward;
    AVCodecContext* pcodeContext;
    AVFrame* pframe;
    AVPacket apk;
    //输出的大小
    int outputWidth,outputheight;
    //内存句柄
    int demuxOpen;
    //准备
    NSCondition * myCondition;
    NSThread* avplayThread;
    AVPicture picture;
    struct SwsContext *img_convert_ctx;
    UIImageView* imageView;
    int Tmp_Recv_Buf_Size;
}
//初始化装置
-(void)initDevice;
//释放
-(void)clearnDevice;
//登录
-(AsyncSocket*)login:(NSString *)ip :(int)port :(int)passWord;
//申请网络数据流
-(BOOL)realPlayChannle:(int)ChanNo :(uint)linkMode :(UIWindow*)ownWin :(UIImageView*)playImgCtr;
-(void)stopRealPlay:(int)ChanNo;
-(BOOL)CMS_Device_Logout:(AsyncSocket*)obSocket;
@end
