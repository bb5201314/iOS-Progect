//
//  YDQRefreshFooter.m
//  YiDianQian
//
//  Created by Mojy on 2016/10/17.
//  Copyright © 2016年 YiDianQian. All rights reserved.
//

#import "CDARefreshFooter.h"

@interface CDARefreshFooter ()

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation CDARefreshFooter

- (void)prepare
{
    [super prepare];
    
//    // 隐藏状态
    self.stateLabel.hidden = YES;
    //设置文字颜色
//    self.stateLabel.textColor = DefaultFirstTextBlackColor;
    self.refreshingTitleHidden = YES;
    
    [self addSubview:self.logoView];
    self.logoView.center = self.center;
}

- (void)placeSubviews
{
    [super placeSubviews];
//    self.logoView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

#pragma mark - Getter
- (UIImageView *)logoView
{
    //新版不需要显示底部的logo图标
    return nil;
//    if (!_logoView) {
//        _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ydq"]];
//    }
//    return _logoView;
}

@end
