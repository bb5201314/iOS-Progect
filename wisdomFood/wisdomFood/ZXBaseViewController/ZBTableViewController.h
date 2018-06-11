//
//  ZBTableViewController.h
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBBaseViewController.h"

@interface ZBTableViewController : ZBBaseViewController <UITableViewDelegate,UITableViewDataSource>


/*
 这个代理方法如果子类实现了, 必须调用super
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

@property(nonatomic,strong)UITableView *tableView;

/*
 tableview的样式, 默认plain
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
