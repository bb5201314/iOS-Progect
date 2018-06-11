//
//  ZBRefreshTableViewController.h
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBTableViewController.h"
#import "CDARefreshFooter.h"
#import "CDARefreshHeader.h"

@interface ZBRefreshTableViewController : ZBTableViewController

/*
 加载更多
 */
- (void)loadMore:(BOOL)isMore;


/*
 结束刷新, 子类请求报文完毕调用
 */
- (void)endHeaderFooterRefreshing;
@end
