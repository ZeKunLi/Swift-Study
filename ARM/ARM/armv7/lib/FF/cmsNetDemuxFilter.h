//
//  cmsNetDemuxFilter.h
//  CmsMocClient
//
//  Created by 李兰平 on 16-3-14.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cmsNetDemuxFilter : NSObject{
    
    
    
}
-(NSData *)GetDeviceloginCommand:(int)password;
-(NSData*)GetDeviceInformationCommand;
//get qeust mono channel video command string  
-(NSData *)GetDeviceVideoChannelCommand:(int)password :(int)ChannelID;

-(int)ByteArrayToint:(Byte []) b;


@end
