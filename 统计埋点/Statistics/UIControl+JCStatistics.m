//
//  UIControl+JCStatistics.m
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import "UIControl+JCStatistics.h"
#import "JCStatisticsToServer.h"
#import "JCHook.h"

@implementation UIControl (JCStatistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        SEL originalSEL = @selector(sendAction:to:forEvent:);
        SEL swizzledSEL = @selector(swizzled_sendAction:to:forEvent:);

        [JCHook methodSwizzlingInClass:[self class] originalSelector:originalSEL swizzlingSelector:swizzledSEL];

    });
}

- (void)swizzled_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {

    // 插入埋点代码
    [self performStastisticsAction:action to:target forEvent:event];
    [self swizzled_sendAction:action to:target forEvent:event];
}

- (void)performStastisticsAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {

    NSString *clickID = nil;

    // 当event为抬起事件，发送给服务器
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        // 从target获取哪个控制器
        NSString *classString = NSStringFromClass([target class]);

        // 从action获取控制器中哪个按钮事件
        NSString *selString = NSStringFromSelector(action);

        // 从plist中取出对应的ID
        NSDictionary *dic = [self setupDictionaryFromPlist];
        clickID = dic[classString][@"ClickEvent"][selString];

        // 发送给服务器
        [[JCStatisticsToServer sharedStatistics] clickEventWithID:clickID];
    }
}

/**
 *  读取statistics.plist文件
 */
- (NSDictionary *)setupDictionaryFromPlist {

    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"statistics.plist" ofType:nil];

    return [NSDictionary dictionaryWithContentsOfFile:pathStr];
}

@end
