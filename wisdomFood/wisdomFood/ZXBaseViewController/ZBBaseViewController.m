//
//  ZBBaseViewController.m
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBBaseViewController.h"

@interface ZBBaseViewController ()

@end

@implementation ZBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    /**
     如果后期要做友盟数据统计这块 都在这个类里面实现
     **/
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}
-(instancetype)initWithTitle:(NSString *)title{
    
    if (self=[super init]) {
        
        self.title=title.copy;
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
