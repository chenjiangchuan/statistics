//
//  JCStatisticsToServer.h
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCStatisticsToServer : NSObject

/** 进入View的时间 */
@property (strong, nonatomic) NSDate *enterDate;
/** 离开View的时间 */
@property (strong, nonatomic) NSDate *leaveDate;

+ (instancetype)sharedStatistics;

/**
 *  进入View的时间
 *
 *  @param viewID 进入了哪个View
 */
- (void)enterViewWithViewID:(NSString *)viewID;

/**
 *  离开View的时间
 *
 *  @param viewID 离开哪个View
 */
- (void)leaveView:(NSString *)viewName viewID:(NSString *)viewID;

/**
 *  点击按钮
 *
 *  @param clickID 点击了哪个按钮
 */
- (void)clickEventWithID:(NSString *)clickID;

/**
 *  把统计数据发送给服务器
 *
 *  @param viewID
 */
- (void)sendStatisticsToServer:(NSString *)viewID;

@end
