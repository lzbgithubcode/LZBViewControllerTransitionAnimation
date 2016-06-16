//
//  LZBBaseTransition.h
//  转场动画
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LZBBaseTransition;

/**
 *  present弹出控制器
 *
 *  @param presented  即将弹出的控制器
 *  @param presenting 正在弹出的控制器
 *  @param sourceVC   源控制器
 *  @param transition
 */
typedef void(^LZBBaseTransitionPresent)(UIViewController *presented,
                                        UIViewController *presenting,
                                        UIViewController *sourceVC,
                                        LZBBaseTransition *transition);
/**
 *  dismiss消失
 *
 *  @param dismissVC  dismissVC消失控制器
 *  @param transition 
 */
typedef void(^LZBBaseTransitionDismiss)(UIViewController *dismissVC,
                                        LZBBaseTransition *transition);

/**
 *  push
 *
 *  @param fromVC     源控制器
 *  @param toVC       目的控制器
 *  @param transition 转场类型
 */
typedef void(^LZBBaseTransitionPush)(UIViewController *fromVC,
                                     UIViewController *toVC,
                                     LZBBaseTransition *transition);

/**
 *  pop
 *
 *  @param fromVC     源控制器
 *  @param toVC       目的控制器
 *  @param transition 转场类型
 */
typedef void(^LZBBaseTransitionPop)(UIViewController *fromVC,
                                    UIViewController *toVC,
                                    LZBBaseTransition *transition);

typedef NS_ENUM(NSInteger,LZBBaseTransitionStyle){
    kLZBBaseTransitionStyle_Present,  //present
    kLZBBaseTransitionStyle_Dismiss,  //dismiss
    kLZBBaseTransitionStyle_Push,     //push
    kLZBBaseTransitionStyle_Pop,      //pop

};


//遵守动画控制器的协议
@interface LZBBaseTransition : NSObject<
UIViewControllerAnimatedTransitioning,    //转场动画协议
UIViewControllerTransitioningDelegate,    //转场代理协议- modal
UINavigationControllerDelegate>           //导航代理协议- push/Pop

#pragma mark - 转场动画类型参数

/**
 *  设置转场动画的时间,默认是0.5s
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  设置转场样式
 */
@property (nonatomic, assign) LZBBaseTransitionStyle  transitionType;

/**
 *  设置是否具有弹簧效果,默认是NO
 */
@property (nonatomic, assign) BOOL  bounceIsEnable;

#pragma mark - 方法调用
/**
 *  实例化方法 push - pop
 *
 *  @param pushCallBack push回调
 *  @param popCallBack  pop回调
 *
 *  @return
 */
- (instancetype)initWithPush:(LZBBaseTransitionPush)pushCallBack
                         Pop:(LZBBaseTransitionPop)popCallBack;

/**
 *  实例化 present - dismiss Modal
 *
 *  @param presentCallBack present回调
 *  @param dismissCallBack dismiss回调
 *
 *  @return 
 */
- (instancetype)initWithPresent:(LZBBaseTransitionPresent) presentCallBack
                        Dismiss:(LZBBaseTransitionDismiss) dismissCallBack;

/**
 *  获得源View - fromView
 */
- (UIView *)fromView:(id <UIViewControllerContextTransitioning>)transitionContext;

/**
 *  获得目的View - toView
 */
- (UIView *)toView:(id <UIViewControllerContextTransitioning>)transitionContext;

@end
