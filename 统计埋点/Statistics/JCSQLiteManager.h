//
//  JCSQLiteManager.h
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface JCSQLiteManager : NSObject
{
    sqlite3 *db;
}

/**
 *  生成单例
 */
+ (instancetype)shareInstance;

/**
 *  打开数据库
 */
- (void)openDB;

/**
 *  操作数据库
 */
- (void)execSQL:(NSString *)sqlString;

/**
 *  查询数据库
 */
- (NSMutableArray *)queryData:(NSString *)sqlString;

@end
