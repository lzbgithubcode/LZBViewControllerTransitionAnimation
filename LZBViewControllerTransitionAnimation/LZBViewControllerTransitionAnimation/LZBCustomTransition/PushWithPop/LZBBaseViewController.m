//
//  LZBBaseViewController.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseViewController.h"

@interface LZBBaseViewController ()

@end

@implementation LZBBaseViewController
- (instancetype)initWithTitle:(NSString *)title
{
   if(self =[super init])
   {
       self.title =  title;
   }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}



@end
