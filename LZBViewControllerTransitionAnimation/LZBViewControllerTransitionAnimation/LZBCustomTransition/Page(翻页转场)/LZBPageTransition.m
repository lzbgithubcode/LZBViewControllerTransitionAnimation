//
//  LZBPageTransition.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBPageTransition.h"

@interface LZBPageTransition ()

/**
 *  过度动画View
 */
@property (nonatomic, strong) UIView *transitonView;

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation LZBPageTransition
- (instancetype)initWithPush:(LZBBaseTransitionPush)pushCallBack Pop:(LZBBaseTransitionPop)popCallBack
{
  if(self = [super initWithPush:pushCallBack Pop:popCallBack])
  {
      self.shadowIsEnable = NO;
  }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil)  return;
    
    if(self.transitionType == kLZBBaseTransitionStyle_Push)
    {
        [self animationPushTrasition:transitionContext WithContainerView:containerView];
    }
    else
    {
        [self animationPopTrasition:transitionContext WithContainerView:containerView];
    }
}
#pragma mark - present动画
- (void)animationPushTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
    self.transitionContext = transitionContext;
    UIView *fromView = [self fromView:transitionContext];
    if([self screenShotIsIncludeNavigatebar])
    {
      self.transitonView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
      self.transitonView.frame = [UIScreen mainScreen].bounds;
    }
    else
    {
      self.transitonView = [fromView snapshotViewAfterScreenUpdates:NO];
      self.transitonView.frame = fromView.frame;
    }
    fromView.alpha = 0.0;
    [containerView addSubview:self.transitonView];
    
    
    UIView *toView = [self toView:transitionContext];
     toView.alpha = 0.0;
    [containerView addSubview:toView];
   
   
    [self setAnchorPoint:CGPointMake(0, 0.5) WithView:self.transitonView];
    
    //动画效果  用CATransition不能实现动画效果，个人觉得是同样是转场动画，不能执行
   // [self transitionWithType:kCATransitionReveal WithSubType:kCATransitionFromRight ToView:self.transitonView];
  
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = 0.002; //设置z轴参数
    containerView.layer.sublayerTransform = transfrom3d;
    
    //是否增加阴影
     if([self shadowIsEnable])
     {
         [self addGradientLayerToView:self.transitonView WithAlpha:0.0];
         [self addGradientLayerToView:toView WithAlpha:1.0];
     }
     __weak typeof(self) weakSelf = self;
     [UIView animateWithDuration:3.0 animations:^{
         weakSelf.transitonView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
         toView.alpha = 1.0;
         if([weakSelf shadowIsEnable])
         {
             weakSelf.transitonView.subviews.lastObject.alpha = 1.0;
             toView.subviews.lastObject.alpha = 0.0;
         }
        
     } completion:^(BOOL finished) {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

- (void)animationPopTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
     UIView *toView = [self toView:transitionContext];
    [containerView addSubview:toView];
 
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
     weakSelf.transitonView.layer.transform = CATransform3DIdentity;
       toView.alpha =1.0;
    } completion:^(BOOL finished) {
        
     [weakSelf.transitonView removeFromSuperview];
     weakSelf.transitionContext = nil;
     
     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
       
    }];
}

- (void)setAnchorPoint:(CGPoint)point WithView:(UIView *)view
{
    view.frame =CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
}

/**
 *  增加动画效果到View上面
 */
- (void)transitionWithType:(NSString *)type WithSubType:(NSString *)subType ToView:(UIView*)view
{
    CATransition *animation = [CATransition animation];
    animation.type = (type == nil)?@"push":type;
    animation.subtype = (subType == nil)?@"fromLeft":subType;
    animation.duration =3.0;
    animation.delegate = self;
    //设置动画速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    [view.layer addAnimation:animation forKey:@"animation"];
    
}

/**
 *  增加阴影效果在View上面
 */
- (void)addGradientLayerToView:(UIView *)view WithAlpha:(CGFloat)alpha
{
    //增加阴影
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[UIColor blackColor].CGColor,
                            (id)[UIColor blackColor].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    UIView *shadow = [[UIView alloc]initWithFrame:view.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer insertSublayer:gradient atIndex:1];
    shadow.alpha = alpha;
    [view addSubview:shadow];
}
@end
