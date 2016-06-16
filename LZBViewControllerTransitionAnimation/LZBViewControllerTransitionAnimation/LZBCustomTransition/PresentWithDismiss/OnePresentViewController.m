//
//  OnePresentViewController.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OnePresentViewController.h"
#import "LZBPresentDismissTransition.h"
#import "TwoPresentViewController.h"

@interface OnePresentViewController ()

@property (nonatomic, strong)  UILabel *contentLab;

@property (nonatomic, strong) UIButton *presentButton;

@property (nonatomic, strong) LZBPresentDismissTransition *presentTransition;

@end

@implementation OnePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentLab = [UILabel new];
    [self.view addSubview:self.contentLab];
    self.contentLab.text = @"模拟系统的modal---from";
    self.contentLab.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    self.contentLab.numberOfLines = 0;
    self.contentLab.textColor = [UIColor purpleColor];
    
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.presentButton];
    self.presentButton.center =self.view.center;
    self.presentButton.bounds = CGRectMake(0, 0, 200, 40);
    self.presentButton.backgroundColor = [UIColor grayColor];
    [self.presentButton setTitle:@"点击present动画" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor blueColor];
    [self.presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.presentButton addTarget:self action:@selector(presentButtonClick) forControlEvents:UIControlEventTouchUpInside];
 
}

- (void)presentButtonClick
{
    TwoPresentViewController *two = [[TwoPresentViewController alloc]init];
    self.presentTransition = [[LZBPresentDismissTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        
        
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    two.transitioningDelegate =self.presentTransition;
    [self presentViewController:two animated:YES completion:nil];
}




@end
