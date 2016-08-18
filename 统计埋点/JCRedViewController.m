//
//  JCRedViewController.m
//  统计埋点
//
//  Created by chenjiangchuan on 16/8/18.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "JCRedViewController.h"

@interface JCRedViewController ()

/**  */
@property (strong, nonatomic) UIButton *privBtn;
/**  */
@property (strong, nonatomic) UIButton *numBtn;

@end

@implementation JCRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.privBtn];
    [self.view addSubview:self.numBtn];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.privBtn.frame = (CGRect){{50, 50}, {100, 100}};
    self.numBtn.frame = (CGRect){{50, 150}, {100, 100}};
}

- (void)privBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)numBtnClick {
    NSLog(@"numBtnClick");
}

- (UIButton *)privBtn {
    if (_privBtn == nil) {
        _privBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_privBtn setTitle:@"上一页" forState:UIControlStateNormal];
        [_privBtn addTarget:self action:@selector(privBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _privBtn;
}

- (UIButton *)numBtn {
    if (_numBtn == nil) {
        _numBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_numBtn setTitle:@"测试点击次数" forState:UIControlStateNormal];
        [_numBtn addTarget:self action:@selector(numBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _numBtn;
}

@end
