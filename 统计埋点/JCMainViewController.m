//
//  JCMainViewController.m
//  统计埋点
//
//  Created by chenjiangchuan on 16/8/18.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "JCMainViewController.h"
#import "JCRedViewController.h"
#import "UIViewController+JCStatistics.h"

@interface JCMainViewController ()

/** UIButton */
@property (strong, nonatomic) UIButton *nextBtn;

@end

@implementation JCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self.view addSubview:self.nextBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.nextBtn.frame = (CGRect){{50, 50}, {100, 100}};
}

- (void)btnClick {

    JCRedViewController *redVC = [[JCRedViewController alloc] init];

    [self.navigationController pushViewController:redVC animated:YES];
}

- (UIButton *)nextBtn {
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
