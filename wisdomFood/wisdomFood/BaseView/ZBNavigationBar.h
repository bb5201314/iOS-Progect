//
//  LMJNavigationBar.h
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/31.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZBNavigationBar;
// 主要处理导航条
@protocol  ZBNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)lmjNavigationBarTitle:(ZBNavigationBar *)navigationBar;
/** 背景图片 */
- (UIImage *)lmjNavigationBarBackgroundImage:(ZBNavigationBar *)navigationBar;
 /** 背景色 */
- (UIColor *)lmjNavigationBackgroundColor:(ZBNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)lmjNavigationIsHideBottomLine:(ZBNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)lmjNavigationHeight:(ZBNavigationBar *)navigationBar;
/** 导航条的左边的 view */
- (UIView *)lmjNavigationBarLeftView:(ZBNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)lmjNavigationBarRightView:(ZBNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)lmjNavigationBarTitleView:(ZBNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(ZBNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(ZBNavigationBar *)navigationBar;
@end


@protocol ZBNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(ZBNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(ZBNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(ZBNavigationBar *)navigationBar;
@end


@interface ZBNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** 显示title */
@property (weak, nonatomic) UIView *titleView;

/** 显示leftView */
@property (weak, nonatomic) UIView *leftView;

/** 显示rightView */
@property (weak, nonatomic) UIView *rightView;

/** title*/
@property (nonatomic, copy) NSMutableAttributedString *title;

/** 数据源 */
@property (weak, nonatomic) id<ZBNavigationBarDataSource> dataSource;

/**代理*/
@property (weak, nonatomic) id<ZBNavigationBarDelegate> lmjDelegate;

/**背景图片 */
@property (weak, nonatomic) UIImage *backgroundImage;

@end
