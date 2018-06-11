//
//  ZBRequestViewController.m
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBRequestViewController.h"
#import "MBProgressHUD+LMJ.h"
@interface ZBRequestViewController ()

@property(nonatomic,strong)Reachability *reachHost;

@end

@implementation ZBRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     要把这个封装在基类这里方法里面的原因在于 滑动翻滚页面 tost只有第一次进去的时候才显示
     然后进去刷新数据的时候不需要显示
     */
    [self  reachHost];
}
#pragma mark - 加载框
- (void)showLoading
{
    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
    [MBProgressHUD hideHUDForView:self.view];
}
#define kURL_Reachability__Address @"www.baidu.com"

#pragma mark-监听网络状态
-(Reachability *)reachHost{
    
    if (!_reachHost) {
        
        _reachHost = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
        WS(weakSelf);
        [_reachHost setUnreachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [weakSelf netWorkStatus:reachability.currentReachabilityStatus inViewController:weakSelf];
            });
        }];
        
        [_reachHost setReachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf netWorkStatus:reachability.currentReachabilityStatus inViewController:weakSelf];
            });
        }];
        [_reachHost startNotifier];
    }
    
    return _reachHost;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
