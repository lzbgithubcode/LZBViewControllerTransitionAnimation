//
//  LZBCustomModalTransition.h
//  转场动画
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseTransition.h"

@interface LZBCustomModalTransition : LZBBaseTransition

/**
 *  设置源控制器的放大比例,默认是scale=0.8
 */
@property (nonatomic, assign) CGFloat scale;

/**
 *  截图是否包括导航条,默认是Yes
 */
@property (nonatomic, assign) BOOL screenShotIsIncludeNavigatebar;

/**
 *  设置目的View的高度，默认是toView高度的0.5
 */
@property (nonatomic, assign) CGFloat toViewRequireHeight;
@end
