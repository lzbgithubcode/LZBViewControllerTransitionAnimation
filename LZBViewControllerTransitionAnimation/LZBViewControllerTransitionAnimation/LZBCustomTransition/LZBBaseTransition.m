//
//  LZBBaseTransition.m
//  转场动画
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseTransition.h"
//默认动画时间
#define default_Duration  0.5

@interface LZBBaseTransition ()

/**
 *  present回调block
 */
@property (nonatomic, copy) LZBBaseTransitionPresent animationPresentCallBack;

/**
 *  dismiss回调block
 */
@property (nonatomic, copy) LZBBaseTransitionDismiss animationDismissCallBack;

/**
 *  push回调block
 */
@property (nonatomic, copy) LZBBaseTransitionPush animationPushCallBack;

/**
 *  pop回调block
 */
@property (nonatomic, copy) LZBBaseTransitionPop animationPopCallBack;

@end

@implementation LZBBaseTransition

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
#ifdef DEBUG
    NSLog(@"实现动画必须重写这个方法");
#endif
}

- (void)animationEnded:(BOOL)transitionCompleted
{
  
}

#pragma mark -UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transitionType = kLZBBaseTransitionStyle_Present;
    if(self.animationPresentCallBack)
        self.animationPresentCallBack(presented,presenting,source,self);
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transitionType = kLZBBaseTransitionStyle_Dismiss;
    if(self.animationDismissCallBack)
        self.animationDismissCallBack(dismissed,self);
    return self;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:
                                (UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
  if(operation == UINavigationControllerOperationPush)
  {
      self.transitionType = kLZBBaseTransitionStyle_Push;
      if(self.animationPushCallBack)
          self.animationPushCallBack(fromVC,toVC,self);
  }
   else if(operation == UINavigationControllerOperationPop)
   {
       //回来的代理一定要清空
        toVC.navigationController.delegate = nil;
       self.transitionType = kLZBBaseTransitionStyle_Pop;
       if(self.animationPopCallBack)
           self.animationPopCallBack(fromVC,toVC,self);
   }
    
    return self;
}



#pragma mark -实例化方法

-(instancetype)init
{
  if(self = [super init])
  {
      self.transitionType = kLZBBaseTransitionStyle_Push;
      self.duration = default_Duration;
      self.bounceIsEnable = NO;
      
  }
    return self;
}
- (instancetype)initWithPush:(LZBBaseTransitionPush)pushCallBack Pop:(LZBBaseTransitionPop)popCallBack
{
  if (self = [self init])
  {
      self.animationPushCallBack = pushCallBack;
      self.animationPopCallBack = popCallBack;
  }
    return self;
}

- (instancetype)initWithPresent:(LZBBaseTransitionPresent)presentCallBack Dismiss:(LZBBaseTransitionDismiss)dismissCallBack
{
  if(self =[self init])
  {
      self.animationPresentCallBack = presentCallBack;
      self.animationDismissCallBack = dismissCallBack;
  }
    return self;
}

#pragma mark - View的操作
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = nil;
    //源控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if([transitionContext respondsToSelector:@selector(viewForKey:)])
    {
        fromView =  [transitionContext viewForKey:UITransitionContextFromViewKey];
    }
    else
        fromView = fromVC.view;
    //初始位置的frame
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    return fromView;
}

- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = nil;
    //目的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if([transitionContext respondsToSelector:@selector(viewForKey:)])
    {
        toView =  [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else
        toView = toVC.view;
    //动画结束位置的frame
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    return toView;
}
@end

