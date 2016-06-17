//
//  LZBPageTransition.h
//  LZBViewControllerTransitionAnimation
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseTransition.h"

@interface LZBPageTransition : LZBBaseTransition

/**
 *  截图是否包括导航条,默认是Yes
 */
@property (nonatomic, assign) BOOL screenShotIsIncludeNavigatebar;

/**
 *  翻页是否增加阴影效果,默认是NO
 */
@property (nonatomic, assign) BOOL shadowIsEnable;

@end
