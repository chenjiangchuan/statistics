//
//  JCHook.h
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface JCHook : NSObject

/**
 *  替换cls类中的方法
 *
 *  @param cls               类名
 *  @param originalSelector  原方法
 *  @param swizzlingSelector 替换后的方法
 */
+ (void)methodSwizzlingInClass:(Class)cls
              originalSelector:(SEL)originalSel
             swizzlingSelector:(SEL)swizzlingSel;

@end
