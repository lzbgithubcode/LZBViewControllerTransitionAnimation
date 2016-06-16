//
//  LZBQQPhoneTransition.h
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseTransition.h"

@interface LZBQQPhoneTransition : LZBBaseTransition

/**
 *  设置点击动画的View
 */
@property (nonatomic, strong) UIView *targetView;

/**
 *  设置targetView动画放大的比例，default scale = 3.0
 */
@property (nonatomic, assign) CGFloat scale;
@end
