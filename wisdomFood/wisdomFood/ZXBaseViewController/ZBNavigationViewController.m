//
//  ZBNavigationViewController.m
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBNavigationViewController.h"

@interface ZBNavigationViewController ()

@end

@implementation ZBNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden=YES;
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled=NO;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count!=0) {
        
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:YES];
    
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
