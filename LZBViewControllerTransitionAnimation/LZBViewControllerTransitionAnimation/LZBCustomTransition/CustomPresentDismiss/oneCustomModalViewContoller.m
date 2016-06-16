//
//  oneCustomModalViewContoller.m
//  转场动画
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "oneCustomModalViewContoller.h"
#import "twoCustomModalViewContoller.h"
#import "LZBCustomModalTransition.h"

@interface oneCustomModalViewContoller ()

@property (nonatomic, strong) LZBCustomModalTransition *customModalTransition;

@property (nonatomic, strong) UIButton *presentButton;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation oneCustomModalViewContoller


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"tupain1"];
    self.imageView.frame =CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.presentButton];
    self.presentButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 50);
    self.presentButton.bounds = CGRectMake(0, 0, 100, 100);
    self.presentButton.backgroundColor = [UIColor grayColor];
    self.presentButton.layer.cornerRadius = 50;
    self.presentButton.layer.masksToBounds = YES;
    [self.presentButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor blueColor];
    [self.presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.presentButton addTarget:self action:@selector(presentButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)presentButtonClick
{
    twoCustomModalViewContoller *twoVC = [[twoCustomModalViewContoller alloc]init];
    self.customModalTransition = [[LZBCustomModalTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    twoVC.transitioningDelegate = self.customModalTransition;
    [self presentViewController:twoVC animated:YES completion:nil];
}
@end
