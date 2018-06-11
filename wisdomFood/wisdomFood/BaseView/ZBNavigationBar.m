//
//  LMJNavigationBar.m
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/31.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "ZBNavigationBar.h"


#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation ZBNavigationBar


#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupLMJNavigationBarUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupLMJNavigationBarUIOnce];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.frame.size.width, self.leftView.frame.size.height);
    
    self.rightView.frame = CGRectMake(self.frame.size.width - self.rightView.frame.size.width, kStatusBarHeight, self.rightView.frame.size.width, self.rightView.frame.size.height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.get_height) * 0.5, MIN(self.get_width - MAX(self.leftView.get_width, self.rightView.frame.size.width) * 2 - kViewMargin * 2, self.titleView.get_width), self.titleView.get_height);
    self.titleView.get_x = (self.frame.size.width * 0.5 - self.titleView.frame.size.width * 0.5);
    self.bottomBlackLineView.frame = CGRectMake(0, self.get_height, self.get_width, 0.5);

}



#pragma mark - Setter
- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHaveTapGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            
            isHaveTapGes = YES;
            
            *stop = YES;
        }
    }];
    
    if (!isHaveTapGes) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        
        [titleView addGestureRecognizer:tap];
    }
    
    
    [self layoutIfNeeded];
}




- (void)setTitle:(NSMutableAttributedString *)title
{
    // bug fix
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarTitleView:)] && [self.dataSource lmjNavigationBarTitleView:self]) {
        return;
    }
    
    /**头部标题*/
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.get_width * 0.4, 44)];
    
    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.lineBreakMode = NSLineBreakByClipping;
    
    self.titleView = navTitleLabel;
}


- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    
    [self addSubview:leftView];
    
    _leftView = leftView;
    
    
    if ([leftView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)leftView;
        
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
    
}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    self.layer.contents = (id)backgroundImage.CGImage;
}



- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    
    [self addSubview:rightView];
    
    _rightView = rightView;
    
    if ([rightView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)rightView;
        
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
}



- (void)setDataSource:(id<ZBNavigationBarDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self setupDataSourceUI];
}


#pragma mark - getter

- (UIView *)bottomBlackLineView
{
    if(!_bottomBlackLineView)
    {
        CGFloat height = 0.5;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn
{
    if ([self.lmjDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        
        [self.lmjDelegate leftButtonEvent:btn navigationBar:self];
        
    }
    
}


- (void)rightBtnClick:(UIButton *)btn
{
    if ([self.lmjDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        
        [self.lmjDelegate rightButtonEvent:btn navigationBar:self];
        
    }
    
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    UILabel *view = (UILabel *)Tap.view;
    if ([self.lmjDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
        
        [self.lmjDelegate titleClickEvent:view navigationBar:self];
        
    }
}



#pragma mark - custom

- (void)setupDataSourceUI
{
    
    /** 导航条的高度 */
    
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationHeight:)]) {
        
        self.get_size = CGSizeMake(kScreen_Width, [self.dataSource lmjNavigationHeight:self]);
        
    }else
    {
        self.get_size = CGSizeMake(kScreen_Height, kDefaultNavBarHeight);
    }
    
    /** 是否显示底部黑线 */
        if ([self.dataSource respondsToSelector:@selector(lmjNavigationIsHideBottomLine:)]) {
    
            if ([self.dataSource lmjNavigationIsHideBottomLine:self]) {
                self.bottomBlackLineView.hidden = YES;
            }
    
        }
    
    /** 背景图片 */
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarBackgroundImage:)]) {
        
        self.backgroundImage = [self.dataSource lmjNavigationBarBackgroundImage:self];
    }
    
    /** 背景色 */
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBackgroundColor:)]) {
        self.backgroundColor = [self.dataSource lmjNavigationBackgroundColor:self];
    }
    
    
    /** 导航条中间的 View */
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarTitleView:)]) {
        
        self.titleView = [self.dataSource lmjNavigationBarTitleView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarTitle:)])
    {
        /**头部标题*/
        self.title = [self.dataSource lmjNavigationBarTitle:self];
    }
    
    
    /** 导航条的左边的 view */
    /** 导航条左边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarLeftView:)]) {
        
        self.leftView = [self.dataSource lmjNavigationBarLeftView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarLeftButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.dataSource lmjNavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.leftView = btn;
    }
    
    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarRightView:)]) {
        
        self.rightView = [self.dataSource lmjNavigationBarRightView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(lmjNavigationBarRightButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.dataSource lmjNavigationBarRightButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.rightView = btn;
    }
    
}


- (void)setupLMJNavigationBarUIOnce
{
    self.backgroundColor = [UIColor whiteColor];
}


@end











