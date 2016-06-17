//
//  oneQQPhoneViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "oneQQPhoneViewController.h"
#import "LZBQQPhoneTransition.h"
#import "twoQQPhoneViewController.h"

@interface oneQQPhoneViewController()

@property (nonatomic, strong) LZBQQPhoneTransition *QQPhoneTransition;

@property (nonatomic, strong) UIButton *presentButton;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation oneQQPhoneViewController

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
    self.presentButton.center = CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50);
    self.presentButton.bounds = CGRectMake(0, 0, 50, 50);
    self.presentButton.layer.cornerRadius = 25;
    self.presentButton.layer.masksToBounds = YES;
    [self.presentButton setImage:[UIImage imageNamed:@"QQPhone"] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor blueColor];
    [self.presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.presentButton addTarget:self action:@selector(presentButtonClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)presentButtonClick
{
    twoQQPhoneViewController *twoVC = [[twoQQPhoneViewController alloc]init];
    twoVC.modalPresentationStyle =  UIModalPresentationCustom;
    self.QQPhoneTransition = [[LZBQQPhoneTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        LZBQQPhoneTransition *modalQQ = (LZBQQPhoneTransition*)transition;
        modalQQ.targetView = self.presentButton;
        
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    
    twoVC.transitioningDelegate = self.QQPhoneTransition;
    [self presentViewController:twoVC animated:YES completion:nil];
}
@end
