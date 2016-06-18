# LZBViewControllerTransitionAnimation(各种自定义转场动画组件)
模仿系统的push/pop动画和modal模态控制器动画，以及自定义各种转场动画

#整体结构
封装一个基本转场动画的公共父LZBBaseTransition.h,用于实现一些基本共同的操作
以及封装block回调,子类继承LZBBaseTransition，重写- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext实现动画效果
 LZBPageTransition.h   翻页效果
 LZBBubbleTransition.h   气泡效果
 LZBQQPhoneTransition.h   模拟QQ电话
 LZBCustomModalTransition.h   自定义模态动画
 LZBPresentDismissTransition.h  模拟系统的模态动画
 LZBPushPopTransition.h  模拟系统的导航切换动画

#使用方法
需要使用什么动画可以直接导入头文件并创建转场动画
比如:要使用QQ电话的转场，使用步骤
1.#import "LZBQQPhoneTransition.h"

2.创建转场动画对象
self.QQPhoneTransition = [[LZBQQPhoneTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
LZBQQPhoneTransition *modalQQ = (LZBQQPhoneTransition*)transition;
modalQQ.targetView = weakSelf.presentButton; //设置点击View
//可以设置参数，改变present动画
} Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
   //可以设置dismiss动画
}];

3.设置需要modal控制的目的控制器的转场delegate 为 我们自定义的转场代理
twoVC.transitioningDelegate = self.QQPhoneTransition;

4.开始动画
[self presentViewController:twoVC animated:YES completion:nil];

其他动画使用大体相同，如需详情可以直接下载代码查看

#基本参数设置
duration ： 设置转场动画的时间,默认是0.5s

transitionType ： 设置转场样式
typedef NS_ENUM(NSInteger,LZBBaseTransitionStyle){
kLZBBaseTransitionStyle_Present,  //present
kLZBBaseTransitionStyle_Dismiss,  //dismiss
kLZBBaseTransitionStyle_Push,     //push
kLZBBaseTransitionStyle_Pop,      //pop

};

bounceIsEnable：设置是否具有弹簧效果,默认是NO

#基本方法
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

#备注
本demo适合本人自己的项目，如果您你和我有同样的需求您可以下载代码，并随心更改。本demo也支持自定义转场动画，方法非常简单，可参照本demo

