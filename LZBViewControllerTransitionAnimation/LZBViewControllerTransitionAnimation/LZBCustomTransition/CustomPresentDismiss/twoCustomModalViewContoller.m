//
//  twoCustomModalViewContoller.m
//  转场动画
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "twoCustomModalViewContoller.h"

@interface twoCustomModalViewContoller ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation twoCustomModalViewContoller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"tupain2"];
    self.imageView.frame = self.view.bounds;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)]];
}
- (void)imageViewClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"销毁---twoCustomModalViewContoller");
}

@end
