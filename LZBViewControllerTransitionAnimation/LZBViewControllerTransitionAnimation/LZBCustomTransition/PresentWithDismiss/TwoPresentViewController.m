//
//  TwoPresentViewController.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TwoPresentViewController.h"

@interface TwoPresentViewController ()

@property (nonatomic, strong) UILabel *centerLab;

@end

@implementation TwoPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"modal控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    self.centerLab = [UILabel new];
    [self.view addSubview:self.centerLab];
    self.centerLab.center = self.view.center;
    self.centerLab.bounds = CGRectMake(0, 0, 200, 40);
    self.centerLab.text = @"modal出来的控制器---to";
    self.centerLab.textColor = [UIColor blueColor];
    self.centerLab.textAlignment = NSTextAlignmentCenter;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
