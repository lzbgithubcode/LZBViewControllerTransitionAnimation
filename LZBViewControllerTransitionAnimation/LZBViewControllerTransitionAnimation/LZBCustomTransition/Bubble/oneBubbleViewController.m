//
//  oneBubbleViewController.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "oneBubbleViewController.h"
#import "twoBubbleViewController.h"
#import "LZBBubbleTransition.h"

@interface oneBubbleViewController ()

@property (nonatomic,strong) LZBBubbleTransition *bubbleTransition;
@property (nonatomic, strong) UIButton *presentButton;
@end


@implementation oneBubbleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAddpresentButton];
}
- (void)setupAddpresentButton
{
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.presentButton];
    self.presentButton.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 50);
    self.presentButton.bounds = CGRectMake(0, 0, 50, 50);
    self.presentButton.layer.cornerRadius = 25;
    self.presentButton.layer.masksToBounds = YES;
    self.presentButton.backgroundColor = [UIColor redColor];
    self.presentButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [self.presentButton setTitle:@"+" forState:UIControlStateNormal];
    [self.presentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.presentButton addTarget:self action:@selector(presentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)presentButtonClick
{
    twoBubbleViewController *two = [[twoBubbleViewController alloc]init];
    two.modalPresentationStyle = UIModalPresentationCustom;
    self.bubbleTransition = [[LZBBubbleTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        LZBBubbleTransition  *bubble = (LZBBubbleTransition *)transition;
        bubble.targetView = self.presentButton;
        
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    two.transitioningDelegate = self.bubbleTransition;
    [self presentViewController:two animated:YES completion:nil];
}
@end
