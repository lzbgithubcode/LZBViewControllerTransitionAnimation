//
//  twoPageViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "twoPageViewController.h"

@interface twoPageViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation twoPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAddBackImageView];
}
- (void)setupAddBackImageView
{
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"meinv2"];
    self.imageView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)]];
    
}
- (void)imageViewClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"销毁---twoPageViewController");
}

@end
