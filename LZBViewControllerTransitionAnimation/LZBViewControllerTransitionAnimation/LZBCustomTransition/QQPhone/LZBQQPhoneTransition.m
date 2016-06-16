//
//  LZBQQPhoneTransition.m
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBQQPhoneTransition.h"

@interface LZBQQPhoneTransition ()

/**
 *  保存全局的转场的上下文
 */
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;


@end

@implementation LZBQQPhoneTransition

-(instancetype)initWithPresent:(LZBBaseTransitionPresent)presentCallBack Dismiss:(LZBBaseTransitionDismiss)dismissCallBack
{
  if(self = [super initWithPresent:presentCallBack Dismiss:dismissCallBack])
  {
      self.scale = 3.0;
  }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if(containerView == nil) return;
    self.transitionContext = transitionContext;
    
    if(self.transitionType == kLZBBaseTransitionStyle_Present)
    {
        [self animationPresentTrasition:transitionContext WithContainerView:containerView];
    }
    else
    {
        [self animationDismissTrasition:transitionContext WithContainerView:containerView];
    }
}

//监听动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.transitionType == kLZBBaseTransitionStyle_Present)
    {
         //有两段动画,监听到第一段动画路径 + 放大的动画结束
        [self animationPresentTrasitionDidStop:anim finished:flag];
    }
    else
    {   //有两段动画,监听到第一缩小到圆 + 回到放大的动画结束
        [self animationDismissTrasitionDidStop:anim finished:flag];
    }
}

#pragma mark - present动画
- (void)animationPresentTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
    UIView *toView = [self toView:transitionContext];
    UIView *fromView = [self fromView:transitionContext];
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    
    toView.alpha = 0.0;
    
    //画移动曲线
    CGPoint startPoint = self.targetView.center;
    CGPoint endPoint = toView.center;
    CGPoint controlPoint = CGPointMake(self.targetView.center.x, [UIScreen mainScreen].bounds.size.height * 0.5);
    UIBezierPath *animationPath = [[UIBezierPath alloc]init];
    [animationPath moveToPoint:startPoint];
    [animationPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    //增加动画
    CAAnimationGroup *group = [self groupAnimationWithBezierPath:animationPath durationTime:1.0 transform:CATransform3DMakeScale(self.scale, self.scale, 1)];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    //用于后面找到这组动画
    [group setValue:@"onePresentGroup" forKey:@"groupAnimation"];
    [self.targetView.layer addAnimation:group forKey:@"keyAniamition"];

}
/**
 *  监听present第一组动画
 */
- (void)animationPresentTrasitionDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
      UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
   if([[anim valueForKey:@"groupAnimation"] isEqualToString:@"onePresentGroup"])
   {
       [self.targetView.layer removeAllAnimations];
       
       UIView *containerView = [self.transitionContext containerView];
       
       //用曲线画两个圆 -开始圆 + 结束圆
       //求出半径
       CGFloat radius = sqrtf(containerView.frame.size.height *containerView.frame.size.height + containerView.frame.size.width *containerView.frame.size.width)*0.5;
       //根据半径画 - 结束圆
       UIBezierPath *endCircle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
       
       //QQPhone动画开始圆
       UIBezierPath *startCicle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(([UIScreen mainScreen].bounds.size.width - self.targetView.frame.size.width * self.scale)*0.5, ([UIScreen mainScreen].bounds.size.height  - self.targetView.frame.size.height * self.scale)*0.5 , self.targetView.frame.size.width*self.scale, self.targetView.frame.size.height*self.scale)];

       
       //创建动画的形状层
       CAShapeLayer *maskLayer = [CAShapeLayer layer];
       maskLayer.path = endCircle.CGPath;
       toVC.view.layer.mask = maskLayer;
       
       
       //创建过度路径动画
       CABasicAnimation *laryerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
       laryerAnimation.fromValue =(__bridge id )startCicle.CGPath;
       laryerAnimation.toValue =(__bridge id )endCircle.CGPath;
       laryerAnimation.duration = 1.0;
       laryerAnimation.delegate = self;
       
       [laryerAnimation setValue:@"twoPrensentAniamation" forKey:@"laryerAnimation"];
       [maskLayer addAnimation:laryerAnimation forKey:@"path"];
       
       
       self.targetView.hidden = YES;
       toVC.view.alpha = 1.0;
   }
  else
    {
       // present第二次动画来到这里 代理回调再次执行到这里结束动画
       [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        toVC.view.layer.mask = nil;
        

    }
}

#pragma mark - dismiss动画
- (void)animationDismissTrasition:(id<UIViewControllerContextTransitioning>)transitionContext WithContainerView:(UIView *)containerView
{
//    UIView *toView = [self toView:transitionContext];
//     toView.alpha = 0.0;
    
    
   //先画两个动画圆
    //求出半径
    CGFloat radius = sqrtf(containerView.frame.size.height *containerView.frame.size.height + containerView.frame.size.width *containerView.frame.size.width)*0.5;
    //根据半径画 - 开始圆
    UIBezierPath *startCicle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //QQPhone动画-结束圆
    UIBezierPath *endCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(([UIScreen mainScreen].bounds.size.width - self.targetView.frame.size.width * self.scale)*0.5, ([UIScreen mainScreen].bounds.size.height  - self.targetView.frame.size.height * self.scale)*0.5 , self.targetView.frame.size.width*self.scale, self.targetView.frame.size.height*self.scale)];
    
    UIView *fromView = [self fromView:transitionContext];
    //UIView *toView = [self toView:transitionContext];
    //创建变化的形状层
    CAShapeLayer *shapeMaskLayer = [CAShapeLayer layer];
    shapeMaskLayer.path = endCircle.CGPath;
    fromView.layer.mask = shapeMaskLayer;
    
    //创建路径动画
    CABasicAnimation *keyPathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    keyPathAnimation.fromValue = (__bridge id) startCicle.CGPath;
    keyPathAnimation.toValue = (__bridge id ) endCircle.CGPath;
    keyPathAnimation.duration = 1.0;
    keyPathAnimation.delegate =self;
    
    [keyPathAnimation setValue:@"dismissOneAnimation" forKey:@"animation"];
    [shapeMaskLayer addAnimation:keyPathAnimation forKey:@"pathAnimation"];
  
    
}
- (void)animationDismissTrasitionDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
     if([[anim valueForKey:@"animation"] isEqualToString:@"dismissOneAnimation"])
     {
         //取消fromView的形状层动画
         [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
         UIView *fromView = [self fromView:self.transitionContext];
         fromView.layer.mask = nil;
        
         //增加动画路径
         UIView *toView = [self toView:self.transitionContext];
         CGPoint startPoint = toView.center;
         CGPoint endPoint = self.targetView.center;
         CGPoint controlPoint = CGPointMake(self.targetView.center.x, [UIScreen mainScreen].bounds.size.height * 0.5);
         UIBezierPath *animationPath = [[UIBezierPath alloc]init];
         [animationPath moveToPoint:startPoint];
         [animationPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
         
          self.targetView.layer.transform = CATransform3DMakeScale(3, 3, 1);
         CAAnimationGroup *group = [self groupAnimationWithBezierPath:animationPath durationTime:1.0 transform:CATransform3DMakeScale(1.0, 1.0, 1)];
         group.removedOnCompletion = NO;
         group.fillMode = kCAFillModeForwards;
         //用于后面找到这组动画
         [group setValue:@"twoDismissGroup" forKey:@"groupAnimation"];
         [self.targetView.layer addAnimation:group forKey:@"keyAniamition"];
         self.targetView.hidden = NO;
         toView.alpha = 1.0;
     }
     else
     {
         [self.targetView.layer removeAllAnimations];
         self.targetView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1);
         
     }
  
}


#pragma mark - 动画组
- (CAAnimationGroup *)groupAnimationWithBezierPath:(UIBezierPath *)bezierPath durationTime:(NSTimeInterval)duration transform:(CATransform3D)transform3D
{
    //路径动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = bezierPath.CGPath;
    
    //尺寸变化
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    baseAnimation.toValue = [NSValue valueWithCATransform3D:transform3D];
    
     //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyAnimation,baseAnimation];
    group.duration = duration;
    group.delegate = self;
    
    return group;
}

@end
