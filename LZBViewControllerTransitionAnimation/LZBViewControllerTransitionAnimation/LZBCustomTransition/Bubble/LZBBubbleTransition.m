//
//  LZBBubbleTransition.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBubbleTransition.h"

@interface LZBBubbleTransition ()

@property (nonatomic, strong) UIView *transitionView;

@end

@implementation LZBBubbleTransition
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil)  return;
    
    if(self.transitionType == kLZBBaseTransitionStyle_Present)
    {
        [self animationPresentTrasition:transitionContext WithContainerView:containerView];
    }
    else
    {
        [self animationDismissTrasition:transitionContext WithContainerView:containerView];
    }
}

#pragma mark - present动画
- (void)animationPresentTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
  
    UIView *toView = [self toView:transitionContext];
    
    //中间过度动画View
    CGPoint startPoint = self.targetView.center;
    CGPoint  toViewCenter = toView.center;
    CGSize toViewSize = toView.frame.size;
    
    //两个View一起动的 - 动画的View（圆形动画）
    self.transitionView.backgroundColor = self.targetView.backgroundColor;
    self.transitionView.frame = [self computeChangeViewFrame:toViewSize];
    self.transitionView.layer.cornerRadius = self.transitionView.frame.size.height * 0.5;
    self.transitionView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.transitionView.center = startPoint;
    [containerView addSubview:self.transitionView];

    //最终需要的结果 - 正方形动画（只有这个）
    toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    toView.center = startPoint;
    toView.alpha = 0.0;
    [containerView addSubview:toView];
    
    __weak  typeof(self) weakself = self;
    if([self bounceIsEnable])
    {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          weakself.transitionView.transform = CGAffineTransformIdentity;
          toView.transform = CGAffineTransformIdentity;
          toView.alpha =1.0;
          toView.center = toViewCenter;
      } completion:^(BOOL finished) {
           [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
    else
    {
        [UIView animateWithDuration:self.duration animations:^{
            weakself.transitionView.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformIdentity;
            toView.alpha =1.0;
            toView.center = toViewCenter;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
   
    
    
}
#pragma mark - dismiss动画
- (void)animationDismissTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
    UIView *fromView = [self fromView:transitionContext];
    CGPoint fromViewCenter = fromView.center;
    CGSize fromViewSize = fromView.frame.size;
    
    //动画初始值
    self.transitionView.frame = [self computeChangeViewFrame:fromViewSize];
    self.transitionView.center = self.targetView.center;
    self.transitionView.layer.cornerRadius = self.transitionView.frame.size.height * 0.5;
    __weak typeof(self) weakSelf = self;
    if([self bounceIsEnable])
    {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          weakSelf.transitionView.transform = CGAffineTransformMakeScale(0.001, 0.001);
          fromView.transform =CGAffineTransformMakeScale(0.001, 0.001);
          fromView.alpha = 0.0;
          fromView.center = weakSelf.targetView.center;
      } completion:^(BOOL finished) {
          fromView.center = fromViewCenter;
          [fromView removeFromSuperview];
          [weakSelf.transitionView removeFromSuperview];
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
    else
    {
      [UIView animateWithDuration:self.duration animations:^{
          weakSelf.transitionView.transform = CGAffineTransformMakeScale(0.001, 0.001);
          fromView.transform =CGAffineTransformMakeScale(0.001, 0.001);
          fromView.alpha = 0.0;
          fromView.center = weakSelf.targetView.center;
          
      } completion:^(BOOL finished) {
         
          fromView.center = fromViewCenter;
          [fromView removeFromSuperview];
          [weakSelf.transitionView removeFromSuperview];
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
          
      }];
    }
    
}

- (CGRect)computeChangeViewFrame:(CGSize)toSize
{
    CGFloat x = fmax(self.targetView.center.x, toSize.width - self.targetView.center.x);
    CGFloat y = fmax(self.targetView.center.y, toSize.height - self.targetView.center.y);
    CGFloat radius = sqrt(x * x  + y * y);
    CGFloat diamter = radius * 2;
    return CGRectMake(0, 0, diamter, diamter);
}

- (UIView *)transitionView
{
  if(_transitionView == nil)
  {
      _transitionView = [UIView new];
  }
    return _transitionView;
}
@end
