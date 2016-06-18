//
//  twoBubbleViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "twoBubbleViewController.h"

@interface twoBubbleViewController ()

@property (nonatomic, strong) UIButton *backButton;
@end

@implementation twoBubbleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.center = CGPointMake(self.view.center.x, 100);
    self.backButton.bounds = CGRectMake(0, 0, 100, 40);
    [self.view addSubview:self.backButton];
    [self.backButton setTitle:@"点我返回哦" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)dealloc
{
    NSLog(@"销毁---twoBubbleViewController");
}
@end
