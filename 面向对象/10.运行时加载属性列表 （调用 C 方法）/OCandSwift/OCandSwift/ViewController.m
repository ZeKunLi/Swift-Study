//
//  ViewController.m
//  OCandSwift
//
//  Created by 李泽昆 on 17/3/24.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

#import "ViewController.h"
#import "OCandSwift-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 调用类方法
    [Test testClass];
    
    // 调用 Swift方法
    Test *text = [[Test alloc] init];
    [text test];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
