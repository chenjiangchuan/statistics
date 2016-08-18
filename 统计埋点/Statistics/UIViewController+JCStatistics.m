//
//  UIViewController+JCStatistics.m
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import "UIViewController+JCStatistics.h"
#import "JCHook.h"
#import "JCStatisticsToServer.h"

@implementation UIViewController (JCStatistics)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 替换viewWillAppear:方法
        SEL originalSel = @selector(viewWillAppear:);
        SEL swizzledSel = @selector(swizzled_viewWillAppear:);

        [JCHook methodSwizzlingInClass:[self class] originalSelector:originalSel swizzlingSelector:swizzledSel];

        // 替换方法
        SEL originalSel2 = @selector(viewWillDisappear:);
        SEL swizzledSel2 = @selector(swizzled_viewWillDisappear:);

        [JCHook methodSwizzlingInClass:[self class] originalSelector:originalSel2 swizzlingSelector:swizzledSel2];
    });
}

#pragma mark - 交换后的方法

- (void)swizzled_viewWillAppear:(BOOL)animated {

    //插入埋点代码
    [self inject_viewWillAppear];
    [self swizzled_viewWillAppear:animated];
}

- (void)swizzled_viewWillDisappear:(BOOL)animated {

    //插入埋点代码
    [self inject_viewWillDisappear];
    [self swizzled_viewWillDisappear:animated];
}

#pragma mark -

- (void)inject_viewWillAppear {
    // 获取plist文件中对应的ViewID
    NSString *viewID = [self viewEventID:YES];
    // 把ViewID传出去，计算进入离开时间
    if (viewID) {
        [[JCStatisticsToServer sharedStatistics] enterViewWithViewID:viewID];
    }
}

- (void)inject_viewWillDisappear {
    NSString *viewID = [self viewEventID:NO];
    if (viewID) {
        [[JCStatisticsToServer sharedStatistics] leaveView:NSStringFromClass([self class]) viewID:viewID];
    }
}

- (NSString *)viewEventID:(BOOL)enterView {

    NSDictionary *configPlist = [self setupDictionaryFromPlist];
    NSString *className = NSStringFromClass([self class]);
    return configPlist[className][@"ViewEvent"][enterView ? @"Enter" : @"Leave"];
}

/**
 *  读取statistics.plist文件
 */
- (NSDictionary *)setupDictionaryFromPlist {

    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"statistics.plist" ofType:nil];

    return [NSDictionary dictionaryWithContentsOfFile:pathStr];
}

@end
