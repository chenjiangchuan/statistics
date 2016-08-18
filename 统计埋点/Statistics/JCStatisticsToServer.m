//
//  JCStatisticsToServer.m
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import "JCStatisticsToServer.h"
#import "JCSQLiteManager.h"

static JCStatisticsToServer *statistics = nil;

@implementation JCStatisticsToServer

+ (instancetype)sharedStatistics {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (statistics == nil) {
            statistics = [[JCStatisticsToServer alloc] init];
        }
    });
    return statistics;
}

/**
 *  进入View的时间
 *
 *  @param viewID 进入了哪个View
 */
- (void)enterViewWithViewID:(NSString *)viewID {
    NSLog(@"%@", viewID);
    self.enterDate  = [NSDate date];

    [self.enterDate timeIntervalSinceNow];

}

/**
 *  离开View的时间
 *
 *  @param viewID 离开哪个View
 */
- (void)leaveView:(NSString *)viewName viewID:(NSString *)viewID {

    NSLog(@"%@", viewID);
    self.leaveDate = [NSDate date];
    [self.leaveDate timeIntervalSinceNow];

    long sec = [self timeDifference];
    NSLog(@"%ld秒", sec);
}

/**
 *  点击按钮
 *
 *  @param clickID 点击了哪个按钮
 */
- (void)clickEventWithID:(NSString *)clickID {
    NSLog(@"%@", clickID);
}

/**
 *  把统计数据发送给服务器
 *
 *  @param viewID
 */
- (void)sendStatisticsToServer:(NSString *)viewID {
    NSLog(@"%@", viewID);
}

/**
 *  计算进入View和离开View的时间差
 */
- (long)timeDifference {
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDateComponents *d = [cal components:unitFlags fromDate:self.enterDate toDate:self.leaveDate options:0];

    return [d hour]*3600+[d minute]*60+[d second];
}

@end
