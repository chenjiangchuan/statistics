//
//  JCSQLiteManager.m
//  统计埋点
//
//  Created by chenjiangchuan on 15/7/15.
//  Copyright © 2015年 JC'Chan. All rights reserved.
//

#import "JCSQLiteManager.h"

@implementation JCSQLiteManager

static JCSQLiteManager *shareInstance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
            shareInstance = [[JCSQLiteManager alloc] init];
        }
    });
    return shareInstance;
}

/**
 *  打开数据库
 *
 *  @return 是否能正确打开
 */
- (void)openDB {

    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"statistics.sqlite" ofType:nil];
    NSLog(@"%@", pathString);

    if (sqlite3_open([pathString UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"打开数据库失败!");
    }
    NSLog(@"打开数据库成功");
}

/**
 *  操作数据库
 */
- (void)execSQL:(NSString *)sqlString {

    char *err = NULL;

    if (sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &err) != SQLITE_OK )
    {
        sqlite3_close(db);
        NSLog(@"数据库操作失败");
    }
}

/**
 *  查询数据库
 */
- (NSMutableArray *)queryData:(NSString *)sqlString {

    // 1.定义游标指针
    sqlite3_stmt *statement = NULL;

    // 3.2 定义数组
    NSMutableArray *tempArray = [NSMutableArray array];

    // 2.准备查询,并且给游标赋值
    if (sqlite3_prepare(db, [sqlString UTF8String], -1, &statement, nil) == SQLITE_OK) {

        // 3.开始查询数据
        // 3.1 取出列数
        int count = sqlite3_column_count(statement);

        // 3.3.查询数据
        while (sqlite3_step(statement) == SQLITE_ROW) {

            // 遍历所有的键值对
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];

            for (int i = 0; i < count; i++) {
                const char *cKey = sqlite3_column_name(statement, i);
                NSString *key = [NSString stringWithCString:cKey encoding:NSUTF8StringEncoding];

                const char *cValue = (const char *)(sqlite3_column_text(statement, i));
                NSString *value = [NSString stringWithCString:cValue encoding:NSUTF8StringEncoding];

                dic[key] = value;
            }

            // 将字典放入到数组中
            [tempArray addObject:dic];
        }
    }
    return tempArray;
}

@end
