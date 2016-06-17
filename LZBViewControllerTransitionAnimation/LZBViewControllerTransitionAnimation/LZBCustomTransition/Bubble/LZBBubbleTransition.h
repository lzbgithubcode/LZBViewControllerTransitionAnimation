//
//  LZBBubbleTransition.h
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseTransition.h"

@interface LZBBubbleTransition : LZBBaseTransition

/**
 *  设置触发事件的View
 */
@property (nonatomic, strong) UIView *targetView;

/**
 *  是否使能弹簧效果
 */
@property (nonatomic, assign) BOOL bounceIsEnable;


@end
