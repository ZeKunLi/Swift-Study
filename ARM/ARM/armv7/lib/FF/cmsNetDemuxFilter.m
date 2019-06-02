//
//  cmsNetDemuxFilter.m
//  CmsMocClient
//
//  Created by 李兰平 on 16-3-14.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "cmsNetDemuxFilter.h"

@interface cmsNetDemuxFilter(private)


@end

@implementation cmsNetDemuxFilter
int gCRC32Table[256];
BOOL gInitFlag;


-(void)InitCMSDemuxFilter{
    
    
    
}


////////////////////////////////////////////////////////////////
-(int)Reflect:(int)ref :(Byte)ch{
    int intch = ch & 0xFF;
    int value = 0;
    for (int i = 1; i <= intch; i++) {
        if ((ref & 0x1) == 1) {
            value |= (1 << (intch - i));
        }
        ref >>= 1;
    }
    return value;
}

-(NSData*)BigEdition:(int)i{
    NSData * nsdata;
    Byte trans[4];
    trans[3] = (Byte) (i & 0xFF);
    trans[2] = (Byte) ((0xFF00 & i) >> 8);
    trans[1] = (Byte) ((0xFF0000 & i) >> 16);
    trans[0] = (Byte) ((0xFF000000 & i) >> 24);
    Byte bytes[4];
    bytes[0] = trans[3];
    bytes[1] = trans[2];
    bytes[2] = trans[1];
    bytes[3] = trans[0];
    
    nsdata=[[NSData alloc]initWithBytes:bytes length:4];
    return nsdata;
}

-(NSData*)sBigEdition:(short)i{
    NSData *nsdata;
    Byte trans[2];
    trans[1] = (Byte) (i & 0xFF);
    trans[0] = (Byte) ((0xFF00 & i) >> 8);
    Byte bytes[2];
    bytes[0] = trans[1];
    bytes[1] = trans[0];
    nsdata=[[NSData alloc]initWithBytes:bytes length:2];
    return nsdata;
}


-(int)cmsCrcInit{
    int ulPolynomial = 0x4c11db7;
    for (int i = 255; i >= 0; i--) {
        gCRC32Table[i] = [self Reflect:i :(Byte)8]<<24;
        for (int k = 8; k > 0; k--) {
            int j;
            if ((0x80000000 & gCRC32Table[i]) == 0)
                j = 0;
            else
                j = ulPolynomial;
            gCRC32Table[i] = (j ^ (gCRC32Table[i] << 1));
        }
        gCRC32Table[i] =[self Reflect:gCRC32Table[i] :(Byte)32];
    }
    return 0;
}


-(int)cmsCrcGet:(Byte[])p :(int) length{
    int crc = -0x1;
    int len = length;
    Byte  buffer[len];
    memcpy(buffer, p, length);
    
    if (gInitFlag == 0) {
        gInitFlag = 1;
        [self cmsCrcInit];
    }
    for (int i = 0; i <len; i++) {
        crc = (0xFFFFFF & crc >> 8) ^ gCRC32Table[0xff & ((crc & 0xff) ^ buffer[i])];
    }
    return crc ^ 0xFFFFFFFF;
}

//整形数组转换为字节数组
-(NSData *)intArrayTobyteArray:(int[])intArray :(int)ilen{
    
    NSData * nsdata;
    Byte byteArray[4 * ilen];
    
    int intArraylen = ilen;
    int byteArraylen = 4*ilen;
    
    if ((intArraylen != 0) && (byteArraylen != 0) && (intArraylen * 4 == byteArraylen)) {
        for (int j = 0; j < intArraylen; j++) {
            byteArray[(j * 4)] = (Byte) (0xFF & intArray[j]);
            byteArray[(1 + j * 4)] = (Byte) (0xFF & intArray[j] >> 8);
            byteArray[(2 + j * 4)] = (Byte) (0xFF & intArray[j] >> 16);
            byteArray[(3 + j * 4)] = (Byte) (0xFF & intArray[j] >> 24);
        }
    }
    
    nsdata=[[NSData alloc]initWithBytes:byteArray length:4*ilen];
    return nsdata;
}

-(int)Int2inthtonl:(int)i{
    Byte tran[4];
    int net = 0x0;
    tran[0] = (Byte) (i & 0xFF);
    tran[1] = (Byte) ((0xFF00 & i) >> 8);
    tran[2] = (Byte) ((0xFF0000 & i) >> 16);
    tran[3] = (Byte) ((0xFF000000 & i) >> 24);
    net = ((0xFF & tran[0]) << 24) + ((0xFF & tran[1]) << 16) + ((0xFF & tran[2]) << 8) + tran[3];
    return net;
}

//字节数组到整数
-(int)ByteArrayToint:(Byte []) b {
    int j = 0;
    for (int i = 3; i >= 0; i--)
        j = j << 8 | (0xFF & b[i]); //source code: j = j << 8 | 0xFF & b[i];
    return j;
}

////////////////////////////////////////////////////////////////
-(NSData *)GetDeviceloginCommand:(int)password{
    
    Byte len[8];
    
    len[0]=0x45;
    len[1]=0x01;
    len[3]=(Byte)(0xFF & 0x04>>8);
    len[2]=(Byte)(0xFF & 0x04);
    
    char tbuf[8];
    *(int *) tbuf= htonl(password);
    
    for(int j=4;j<8;++j){
        
        len[j]=tbuf[j-4];
    }
    return [[NSData alloc]initWithBytes:len length:8];
}
-(NSData*)GetDeviceInformationCommand{
    
    Byte dvrInfor[4];
    
    dvrInfor[0]=0x46;
    dvrInfor[1]=0x03;
    dvrInfor[2]=0;
    dvrInfor[3]=0;
    
  return [[NSData alloc]initWithBytes:dvrInfor length:4];

}
-(NSData *)GetDeviceVideoChannelCommand:(int)password :(int)ChannelID{
    NSData * nsdata;	
    
    int tRequest[16];
    tRequest[0] = -0x240531fd; 
    tRequest[1] = [self Int2inthtonl:password];
    tRequest[2] = [self Int2inthtonl:1 << ChannelID];
    tRequest[3] = [self Int2inthtonl:0x2];
    tRequest[4] = 0x0;
    tRequest[5] = 0x32;
    tRequest[6] = 0x0;
    tRequest[7] = 0x0;
    tRequest[8] = 0x0;
    tRequest[9] = 0x0;
    tRequest[10] = 0x0;
    tRequest[11] = 0x0;
    tRequest[12] = 0x0;
    tRequest[13] = 0x0;
    tRequest[14] = 0x0;
    //NSData->Byte[]
    Byte *tbyte=(Byte*)[[self intArrayTobyteArray:tRequest :16] bytes];
    int tCheckSum = [self cmsCrcGet:tbyte :60];//get bytesarray all length
    //tCheckSum = 0x9658faa5;
    tRequest[15] = tCheckSum;
    //    Log.d("TCP", "tCheckSum is: 0x" + Integer.toHexString(tCheckSum));
    
    Byte acData[64];
    int bytesIndex=0;
    
    for (int i = 0; i < 16; i++) {
        //把整形数组转换到字节数组
        //data_out.write(BigEdition(tRequest[i]));
        Byte *tmpb=(Byte *)[[self BigEdition:tRequest[i]] bytes];
        
        for (int j=0; j<[[self BigEdition:tRequest[i]] length] ; j++) {
            acData[bytesIndex]=tmpb[j];
            bytesIndex++;
        }
    }
    //    NSString * temstr=[NSString stringWithFormat:@"acdata[0]=%x,acData[1]=%x",acData[0]&0xff,acData[1]&0xff];
    
    //    NSLog(temstr);
        
    NSLog(@"Total bytes length===%d",bytesIndex);
    //Byte acData[60];// = byte_out.toByteArray();
    nsdata=[[NSData alloc]initWithBytes:acData length:64];
    return nsdata;
    
}

#if 0 //解析设备信息，从受到的数据
//取设备信息
if ((b[0] == 0x46) && (b[1] == 0x03)) {
    
    for (int j = 1; j < 6; j++) {
        Byte  Int[4] ;
        
        for (int i = j * 4; i < j * 4 + 4; i++) {
            Int[(i - j * 4)] = b[i];  }
        
        int ver,Builddate,HostId,Flag,MenuVersion;
        switch (j) {
            case 1:
                ver=[_cmsNetDemuxFilter ByteArrayToint:Int];
                NSLog(@"Version=== %d",ver);
                break;
            case 2:
                Builddate =[_cmsNetDemuxFilter ByteArrayToint:Int];
                
                
                NSLog(@"Builddate=== %d",Builddate);
                break;
            case 3:
                HostId = [_cmsNetDemuxFilter ByteArrayToint:Int];
                NSLog(@"HostId=== %d",HostId);
                break;
            case 4:
                Flag = [_cmsNetDemuxFilter ByteArrayToint:Int];
                NSLog(@"Flag=== %d",Flag);
                break;
            case 5:
                MenuVersion = [_cmsNetDemuxFilter ByteArrayToint:Int];
                NSLog(@"MenuVersion=== %d",MenuVersion);
                break;
        }
        
        int s=Builddate & 0x3f;
        int min=(Builddate>>6) & 0x3f;
        int h=(Builddate>>12) & 0x1f;
        int Day=(Builddate>>17) & 0x1f;
        int Mon=(Builddate>>22) & 0xf;
        int Year=((Builddate>>26)& 0x3f)+1984;
        
        NSLog(@"建立时间：%d年-%d月-%d日 %d时:%d分:%d秒",Year,Mon,Day,h,min,s);
    }
    short DataPortOld = (short) (b[25] << 8 | (0xFF & b[24]));
    NSLog(@"DataPortOld is===== :%d",DataPortOld);
    //数据端口3356，是从设备端取过来的，也就是连接上命令端口以后
    short DataPort = (short) (b[27] << 8|(0xFF & b[26]));
    
    NSLog(@"dataport is===== %d",DataPort);
    
    short TalkPort=(short) (b[29] << 8 | (0xFF & b[28]));
    NSLog(@"TalkPort is===== %d",TalkPort);
    
    short ChanNum=b[37];
    NSLog(@"ChanNum is=====%d",ChanNum);
    
    pDvrInfo->DvrChannleNumber=b[37];
    pDvrInfo->DvrDiskNumber=1;
    pDvrInfo->AlarmInputPortNumber=4;
    pDvrInfo->AlarmOutputPortNumber=4;
    
    bIsLogined=true;
} 
#endif




@end
