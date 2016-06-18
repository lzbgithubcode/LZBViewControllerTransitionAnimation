//
//  onePageViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "onePageViewController.h"
#import "twoPageViewController.h"
#import "LZBPageTransition.h"

@interface onePageViewController ()

@property (nonatomic, strong) UIButton *presentButton;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) LZBPageTransition *pageTransition;

@end

@implementation onePageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAddBackImageView];
    [self setupAddpresentButton];
}

- (void)setupAddBackImageView
{
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"QQ_main"];
    self.imageView.frame =CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupAddpresentButton
{
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.presentButton];
    self.presentButton.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height*0.5);
    self.presentButton.bounds = CGRectMake(0, 0, 200, 50);
    self.presentButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [self.presentButton setTitle:@"点我是下一张哦" forState:UIControlStateNormal];
    self.presentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.presentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.presentButton addTarget:self action:@selector(presentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)presentButtonClick
{
 
    twoPageViewController *two = [[twoPageViewController alloc]init];
    self.pageTransition = [[LZBPageTransition alloc]initWithPush:^(UIViewController *fromVC, UIViewController *toVC, LZBBaseTransition *transition) {
        LZBPageTransition *page = (LZBPageTransition*)transition;
        page.screenShotIsIncludeNavigatebar = YES;
        
    } Pop:^(UIViewController *fromVC, UIViewController *toVC, LZBBaseTransition *transition) {
        
    }];
    self.navigationController.delegate = self.pageTransition;
    [self.navigationController pushViewController:two animated:YES];
    
}
@end
