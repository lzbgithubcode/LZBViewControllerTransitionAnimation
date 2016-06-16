//
//  LZBPresentDismissTransition.m
//  转场动画
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBPresentDismissTransition.h"

@implementation LZBPresentDismissTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil) return;
    
    if(self.transitionType == kLZBBaseTransitionStyle_Present)
    {
        UIView *toView = [self toView:transitionContext];
        UIView *fromView = [self fromView:transitionContext];
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        toView.alpha = 1.0;
        fromView.alpha = 1.0;
        
        toView.frame = CGRectMake(0,fromView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
        
        [UIView animateWithDuration:2.0 animations:^{
          toView.frame = CGRectMake(0,0, toView.frame.size.width, toView.frame.size.height);
             fromView.alpha = 0.0;
        }  completion:^(BOOL finished) {
        
             toView.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }
    else if(self.transitionType == kLZBBaseTransitionStyle_Dismiss)
    {
        UIView *toView = [self toView:transitionContext];
        UIView *fromView = [self fromView:transitionContext];
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        toView.alpha = 1.0;
        fromView.alpha = 1.0;
        
        fromView.frame = CGRectMake(0,0 , fromView.frame.size.width, fromView.frame.size.height);
        
        [UIView animateWithDuration:2.0 animations:^{
            fromView.frame = CGRectMake(0, toView.frame.size.height, fromView.frame.size.width, fromView.frame.size.height);
            
        } completion:^(BOOL finished) {
            fromView.alpha = 0.0;
             toView.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }
    
    
}
@end
