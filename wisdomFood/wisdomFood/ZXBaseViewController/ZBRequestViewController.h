//
//  ZBRequestViewController.h
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBNaveBaseViewController.h"
#import <Reachability.h>

@class ZBRequestViewController;

@protocol ZBRequestViewControllerDelegate <NSObject>

@optional

/**
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 @param netWorkStatus 网络状态查询
 @param inViewController 用户当前所在的页面管理器
 */
-(void)netWorkStatus:(NetworkStatus)netWorkStatus  inViewController:(ZBRequestViewController  *)inViewController;

@end
@interface ZBRequestViewController : ZBNaveBaseViewController<ZBRequestViewControllerDelegate>
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end
