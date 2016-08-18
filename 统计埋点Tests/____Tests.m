//
//  ____Tests.m
//  统计埋点Tests
//
//  Created by chenjiangchuan on 16/8/18.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ____Tests : XCTestCase

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testConfigurePlist {

    // 获取Plist文件
    NSDictionary *dic = [self setupDictionaryFromPlist];

    // 如果dic为nil，报错
    XCTAssertNotNil(dic, @"statistics.plist文件为nil");

    // 循环遍历字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        // 获取控制器的名字
        NSString *vcString = key;
        Class VCClass = NSClassFromString(vcString);
        // 创建对应的控制器类
        id viewController = [[VCClass alloc] init];

        // 获取key对应的value
        NSDictionary *viewValueDic = (NSDictionary *)obj;

        // 获取ClickEvent中的内容
        NSDictionary *clickEventDic = viewValueDic[@"ClickEvent"];

        [clickEventDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

            // key为对应的事件响应方法
            // 如果对应的控制不存在该方法，报错
            XCTAssert([viewController respondsToSelector:NSSelectorFromString(key)], @"代码与plist文件不符合，plist文件：[%@]-[%@]", vcString, key);

        }];

        // 获取ViewEvent中的内容
        NSDictionary *viewEventDic = viewValueDic[@"ViewEvent"];

        [viewEventDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        }];
    }];
}

/**
 *  读取statistics.plist文件
 */
- (NSDictionary *)setupDictionaryFromPlist {

    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"statistics.plist" ofType:nil];

    return [NSDictionary dictionaryWithContentsOfFile:pathStr];
}

@end
