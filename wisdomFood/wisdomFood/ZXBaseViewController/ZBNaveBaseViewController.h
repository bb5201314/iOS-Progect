//
//  ZBBaseViewController.h
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNavigationBar.h"
#import "ZBNavigationViewController.h"

@class  ZBNaveBaseViewController;

@protocol ZBNaveBaseViewControllerDataSource <NSObject>


/**
 判断当前页面是不是需要导航栏
 @param navUIBaseViewController 当前对象 当前VC
 @return 布尔值
 */

- (BOOL)navUIBaseViewControllerIsNeedNavBar:(ZBNavigationViewController *)navUIBaseViewController;
@end
@interface ZBNaveBaseViewController : UIViewController<ZBNavigationBarDelegate,ZBNavigationBarDataSource,ZBNaveBaseViewControllerDataSource>

/**
 设置导航栏的字体

 @param curTitle 设置字体内容
 @return  返回字符创
 */
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@property (weak, nonatomic)ZBNavigationBar *zxb_navgationBar;

@end
