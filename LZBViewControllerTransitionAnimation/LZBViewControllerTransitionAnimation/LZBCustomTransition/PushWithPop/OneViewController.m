//
//  OneViewController.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
#import "LZBPushPopTransition.h"

@interface OneViewController ()

@property (nonatomic, strong) UIButton *oneButton;

@property (nonatomic, strong) LZBPushPopTransition *pushPopTransition;

@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentLab = [UILabel new];
    [self.view addSubview:self.contentLab];
    self.contentLab.text = @"为了区别系统的push和pop功能，所以我故意把动画时间设置为3.0s,您也可以自行设置时间";
    self.contentLab.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    self.contentLab.numberOfLines = 0;
    self.contentLab.textColor = [UIColor redColor];
    
    
    self.oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.oneButton];
    self.oneButton.center =self.view.center;
    self.oneButton.bounds = CGRectMake(0, 0, 100, 40);
    self.oneButton.backgroundColor = [UIColor grayColor];
    [self.oneButton setTitle:@"点击动画" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.oneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.oneButton addTarget:self action:@selector(onnButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onnButtonClick
{
    TwoViewController *two = [[TwoViewController alloc]init];
    
    self.pushPopTransition = [[LZBPushPopTransition alloc]initWithPush:^(UIViewController *fromVC, UIViewController *toVC, LZBBaseTransition *transition) {
       
        
    } Pop:^(UIViewController *fromVC, UIViewController *toVC, LZBBaseTransition *transition) {

    }];
    
    self.navigationController.delegate = self.pushPopTransition;
    [self.navigationController pushViewController:two animated:YES];
     NSLog(@"---OneViewController:%@",self.navigationController.delegate);
}



@end
