//
//  CallOCMethod.m
//  0.Switf 桥接 OC
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

#import "CallOCMethod.h"

@interface CallOCMethod ()

@end

@implementation CallOCMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)text {
    NSLog(@"我是 OC");
}

- (void)texta {
    NSLog(@"我是 OC");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
