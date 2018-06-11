//
//  HomeViewController.m
//  wisdomFood
//
//  Created by ZXB on 2018/6/10.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 需要加载上下拉刷新的页面继承ZBRefreshTableViewController 重写这个方法就可以了
 @param isMore YES 就是上拉加载 否则就是加载首页
 */
-(void)loadMore:(BOOL)isMore{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
