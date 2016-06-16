//
//  LZBCustomModalTransition.m
//  转场动画
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCustomModalTransition.h"

#define default_scale  0.8

@interface LZBCustomModalTransition()

@property (nonatomic, weak) UIViewController *fromViewController;

@end

@implementation LZBCustomModalTransition

-(instancetype)initWithPresent:(LZBBaseTransitionPresent)presentCallBack Dismiss:(LZBBaseTransitionDismiss)dismissCallBack
{
    if(self = [super initWithPresent:presentCallBack Dismiss:dismissCallBack])
    {
        self.scale = default_scale;
        self.screenShotIsIncludeNavigatebar = YES;
        
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil) return;
    if(self.transitionType == kLZBBaseTransitionStyle_Present)
    {
        UIView *toView = [self toView:transitionContext];
        UIView *fromView =[self fromView:transitionContext];
        
    
        //如果有临时的View,那么FromView就没有什么用
        UIView *fromTempView = nil;
        if([self screenShotIsIncludeNavigatebar])
            fromTempView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
        else
            fromTempView = [fromView snapshotViewAfterScreenUpdates:NO];
        
        fromTempView.frame = fromView.frame;
        [containerView addSubview:fromTempView];
        fromView.alpha = 0.0;
        
        //设置目的控制器的View
        CGFloat height = self.toViewRequireHeight;
        if(self.toViewRequireHeight > 0)
        {
            height = self.toViewRequireHeight;
        }
        else
            height =  toView.frame.size.height * 0.5;
        
        toView.frame = CGRectMake(toView.frame.origin.x, fromView.frame.size.height, toView.frame.size.width, height);
        [containerView addSubview:toView];
        
        

        //增加手势在后面的View上面
         self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [fromTempView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fromTempViewClick)]];
        
        
        
        //增加动画效果
         if(self.bounceIsEnable ==NO)
         {
             [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                 
                 fromTempView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
                 
                 toView.transform = CGAffineTransformMakeTranslation(0, -height);
                 
             } completion:^(BOOL finished) {
                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
             }];
         }
        else
        {
            // damp是弹簧系数，velecity:弹簧速度
            [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               
                fromTempView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
                
                toView.transform = CGAffineTransformMakeTranslation(0, -height);
                
            } completion:^(BOOL finished) {
                
                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
        }
        
      
        
        
    }
    else
    {
        UIView *toView = [self toView:transitionContext];       //目的View
        UIView *fromView = [self fromView:transitionContext];   //源View
        UIView *toTempView = [containerView.subviews firstObject];  //目的的过度View
         //注意： [containerView.subviews lastObject]就是fromView，也就是外面这个View
        // [containerView.subviews firstObject] 就是保存的上一个动画的toView，但是也不是这个直接的toView
        if(self.bounceIsEnable == NO)
        {
            [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toTempView.transform = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                toView.alpha =1.0;
                [toTempView removeFromSuperview];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];

        }
        else
        {
            // damp是弹簧系数，velecity:弹簧速度
            [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                toTempView.transform = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                toView.alpha =1.0;
                [toTempView removeFromSuperview];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];

        }
        
        
        
    }
    
}

- (void)fromTempViewClick
{
   
    [self.fromViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
