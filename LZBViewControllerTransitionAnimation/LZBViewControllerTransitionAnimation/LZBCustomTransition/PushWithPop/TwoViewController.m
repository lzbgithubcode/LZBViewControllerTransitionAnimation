//
//  TwoViewController.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TwoViewController.h"
#import "LZBPushPopTransition.h"

@interface TwoViewController ()

@property (nonatomic, strong) UILabel *centerLab;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二个控制器";
     self.view.backgroundColor = [UIColor whiteColor];
    self.centerLab = [UILabel new];
    [self.view addSubview:self.centerLab];
    self.centerLab.center = self.view.center;
    self.centerLab.bounds = CGRectMake(0, 0, 200, 40);
    self.centerLab.text = @"第二个控制器";
    self.centerLab.textColor = [UIColor blueColor];
    self.centerLab.textAlignment = NSTextAlignmentCenter;
}



@end
