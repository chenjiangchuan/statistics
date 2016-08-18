//
//  JCHook.m
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import "JCHook.h"

@implementation JCHook

+ (void)methodSwizzlingInClass:(Class)cls
              originalSelector:(SEL)originalSel
             swizzlingSelector:(SEL)swizzlingSel {

    Class class = cls;

    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSel);

    if (class_addMethod(class, originalSel, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod))) {

        class_replaceMethod(class, swizzlingSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));

    } else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}

@end
