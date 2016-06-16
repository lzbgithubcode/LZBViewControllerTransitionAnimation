//
//  twoQQPhoneViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "twoQQPhoneViewController.h"

@interface twoQQPhoneViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation twoQQPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAddBackImageView];
}
- (void)setupAddBackImageView
{
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"wechat_main"];
    self.imageView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)]];

}
- (void)imageViewClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
