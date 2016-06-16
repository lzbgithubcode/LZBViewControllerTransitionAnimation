//
//  LZBPushPopTransition.m
//  转场动画
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBPushPopTransition.h"

@implementation LZBPushPopTransition
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
   //1.获得容器的View
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil)  return;
  
    //PUSH的情况
    if(self.transitionType == kLZBBaseTransitionStyle_Push)
    {
       //2.获得源View 和toView
        UIView *toView = [self toView:transitionContext];
        UIView *fromView = [self fromView:transitionContext];
       
       //3.设置View的frame 并增加到容器中
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        //4.设置基本参数，设置目的控制器在源控制器的左边
        toView.frame = CGRectMake(fromView.frame.size.width, 0, toView.frame.size.width, toView.frame.size.height);
        //5.动画效果
        [UIView animateWithDuration:3.0 animations:^{
            //源控制器推出窗口
            fromView.frame = CGRectMake(-fromView.frame.size.width, 0, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
        } completion:^(BOOL finished) {
            toView.alpha =1.0;
            fromView.alpha = 0.0;
            //结束动画
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    else if(self.transitionType == kLZBBaseTransitionStyle_Pop)
    {
        UIView *toView = [self toView:transitionContext];
        UIView *fromView = [self fromView:transitionContext];
        
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        toView.alpha = 1.0;
        fromView.alpha = 1.0;
        
         toView.frame = CGRectMake(-toView.frame.size.width, 0, toView.frame.size.width, toView.frame.size.height);
        //实现动画 - 动画时间可以设置
        [UIView animateWithDuration:3.0 animations:^{
            
            fromView.frame =CGRectMake(toView.frame.size.width, 0, fromView.frame.size.width, fromView.frame.size.height);
           toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
            
        } completion:^(BOOL finished) {
           
            toView.alpha = 1.0;
            fromView.alpha = 0.0;
            [fromView removeFromSuperview];
            //结束动画
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}


@end
