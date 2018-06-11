//
//  ZBBaseViewController.m
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBNaveBaseViewController.h"
#import "ZBNavigationBar.h"
#import "UIBarButtonItem+YYAdd.h"
#import "NSObject+YYAddForKVO.h"

@interface ZBNaveBaseViewController ()

@end

@implementation ZBNaveBaseViewController
#pragma mark-生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    [self.navigationItem addObserverBlockForKeyPath:LMJKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakSelf.title = newVal;
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.zxb_navgationBar.get_width=self.view.get_width;
    [self.view bringSubviewToFront:self.zxb_navgationBar];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:LMJKeyPath(self.navigationItem, title)];
}
#pragma mark  DataSource
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(ZBNaveBaseViewController *)navUIBaseViewController{
    
    return YES;
}

/**
 设置导航栏title
 @param navigationBar 当前bar
 @return 文字
 */
-(NSMutableAttributedString *)lmjNavigationBarTitle:(ZBNavigationBar *)navigationBar{
    
    return [self changeTitle:self.title ?: self.navigationItem.title];

}
#pragma mark 自定义代码
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}
/** 背景色 */
- (UIColor *)lmjNavigationBackgroundColor:(ZBNavigationBar *)navigationBar {
    return [UIColor whiteColor];
}
/** 导航条的高度 */
- (CGFloat)lmjNavigationHeight:(ZBNavigationBar *)navigationBar {
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}
#pragma mark - Delegate  每个页面导航栏需要特别定制 在对应的控制器实现代理方法
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(ZBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(ZBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(ZBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
#pragma mark - BarDataSource  每个页面导航栏需要特别定制 在对应的控制器实现代理方法

/** 导航条的左边的 view */
//- (UIView *)lmjNavigationBarLeftView:(LMJNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)lmjNavigationBarRightView:(LMJNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)lmjNavigationBarTitleView:(LMJNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LMJNavigationBar *)navigationBar
//{
//
//}
-(ZBNavigationBar *)lmj_navgationBar{
    
    /*
     父类控制器必须是导航控制器 需要判断类型
     */
    if (!_zxb_navgationBar&&[self.presentationController isKindOfClass:[UINavigationController class]]) {
        
        ZBNavigationBar *navigationBar = [[ZBNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _zxb_navgationBar = navigationBar;
        navigationBar.dataSource = self;
        navigationBar.lmjDelegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }
    
    return  _zxb_navgationBar;
}
/*
 设置标题
 */
-(void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    
    self.zxb_navgationBar.title=[self  changeTitle:title];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
