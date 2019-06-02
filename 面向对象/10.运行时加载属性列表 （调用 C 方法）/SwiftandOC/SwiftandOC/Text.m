//
//  Text.m
//  SwiftandOC
//
//  Created by 李泽昆 on 17/3/23.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

#import "Text.h"
#import "SwiftandOC-Swift.h"
@implementation Text
- (void)text {
    NSLog(@"我是实列方法");
}
+ (void)classText {
    NSLog(@"我是类方法");
}

+ (void)test {
    
    //调用 Swift 的类方法
    [ViewController testClass];
    
    //调用 Swift 的实列方法
    ViewController *VC = [[ViewController alloc] init];
    [VC test];
    
}
@end
