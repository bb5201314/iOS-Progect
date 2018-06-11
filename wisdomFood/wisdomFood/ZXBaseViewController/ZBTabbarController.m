//
//  ZBTabbarController.m
//  wisdomFood
//
//  Created by ZXB on 2018/6/10.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBTabbarController.h"

#import "HomeViewController.h"
#import "SaleFormViewController.h"
#import "MyViewController.h"
#import "DetectionViewController.h"

#import "ZBNavigationViewController.h"

/**
 自定义tabbar需要使用
 **/
//#import "ZBTabbar.h"

@interface ZBTabbarController ()<UITabBarControllerDelegate>

@end

@implementation ZBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self  setUpTabbar];
    [self  addChildViewControllers];
    [self addTabbarItems];
    self.delegate=self;
}
/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。覆盖父类方法
    把系统的tabBar属性通过setvalue变成自己的的 自定义
 */
//-(void)setUpTabbar{
//
//    ZBTabbar *tabBar=[[ZBTabbar  alloc]init];
//    ZBWeakSelf(self);
//    [tabBar setPublishBtnClick:^(ZBTabbar *tabBar, UIButton *publishButton) {
//
//        [weakself  showPublishVc];
//    }];
//    [self  setValue:tabBar forKey:LMJKeyPath(self,tabBar)];
//}
-(void)addChildViewControllers{
    
    ZBNavigationViewController *one = [[ZBNavigationViewController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    
    ZBNavigationViewController *two = [[ZBNavigationViewController alloc] initWithRootViewController:[[SaleFormViewController alloc] init]];
    
    ZBNavigationViewController *three = [[ZBNavigationViewController alloc] initWithRootViewController:[[DetectionViewController alloc] init]];
    
    ZBNavigationViewController *four = [[ZBNavigationViewController alloc] initWithRootViewController:[[MyViewController alloc] init]];
    self.viewControllers = @[one,two,three,four];
   
}
-(void)addTabbarItems{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"首页",
                                                 @"TabBarItemImage" : @"tabBar_essence_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"生产销售",
                                                  @"TabBarItemImage" : @"tabBar_friendTrends_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"检测追溯",
                                                 @"TabBarItemImage" : @"tabBar_new_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"我的",
                                                  @"TabBarItemImage" : @"tabBar_me_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_me_click_icon"
                                                  };
    
    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                            firstTabBarItemsAttributes,
                                                             secondTabBarItemsAttributes,
                                                            thirdTabBarItemsAttributes,
                                                                fourthTabBarItemsAttributes
                                                            ];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    
    self.tabBar.tintColor = [UIColor greenColor];
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
