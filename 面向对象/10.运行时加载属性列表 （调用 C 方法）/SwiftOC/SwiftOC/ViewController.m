//
//  ViewController.m
//  SwiftOC
//
//  Created by 李泽昆 on 17/3/23.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

#import "ViewController.h"
#import "SwiftOC-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Test *text = [[Test alloc] init];
    [text show];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
