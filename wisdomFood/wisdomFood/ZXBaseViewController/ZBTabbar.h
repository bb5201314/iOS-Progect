//
//  ZBTabbar.h
//  wisdomFood
//
//  Created by ZXB on 2018/6/10.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBTabbar : UITabBar

@property(nonatomic,copy) void(^publishBtnClick)(ZBTabbar *tabBar,UIButton *publishButton);


@end
