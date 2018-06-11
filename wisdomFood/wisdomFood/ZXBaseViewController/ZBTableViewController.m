//
//  ZBTableViewController.m
//  wisdomFood
//
//  Created by 赵小波 on 2018/6/8.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBTableViewController.h"
#import "CDARefreshFooter.h"
@interface ZBTableViewController ()

/**
 tableView的样式  有需要用tabeview刷新加载数据的页面就继承 ZBRefreshTableViewController
 因为ZBRefreshTableViewController是继承自 ZBTableViewController
 不需要处理这个的页面就直接继承基础类 ZBBaseViewController
 **/
@property(nonatomic,assign)UITableViewStyle tableViewStyle;

@end

@implementation ZBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseTableViewUI];

}
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        [self.view addSubview:tableView];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView = tableView;
    }
    return _tableView;
}
- (void)setupBaseTableViewUI
{
    self.tableView.backgroundColor = self.view.backgroundColor;
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top += self.zxb_navgationBar.get_height;
        self.tableView.contentInset = contentInset;
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 适配 ios 11
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}
#pragma mark - scrollDeleggate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom -= self.tableView.mj_footer.get_height;
    self.tableView.scrollIndicatorInsets = contentInset;
    [self.view endEditing:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableViewStyle = style;
    }
    return self;
}

- (void)dealloc {
    
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
