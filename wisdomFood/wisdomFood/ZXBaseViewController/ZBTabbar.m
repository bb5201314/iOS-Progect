//
//  ZBTabbar.m
//  wisdomFood
//
//  Created by ZXB on 2018/6/10.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "ZBTabbar.h"
#import "UIButton+LMJ.h"

@interface ZBTabbar ()

@property(nonatomic,strong)UIButton *publishBtn;

@end

@implementation ZBTabbar
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat itemWidth=self.get_width/(self.items.count+1);
    __block CGFloat itemHeight=0;
    __block CGFloat  itemY=0;
    
    NSMutableArray<UIView *> *tabBarButtonMutableArray = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonMutableArray addObject:obj];
            obj.get_width = itemWidth;
            itemHeight = obj.get_height;
            itemY = obj.get_y;
        }
    }];
    
    [tabBarButtonMutableArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.get_x = idx * itemWidth;
        if (idx > 1) {
            obj.get_x = (idx + 1) * itemWidth;
        }
        if (idx == 2) {
            self.publishBtn.get_size = CGSizeMake(itemWidth, itemHeight);
            self.publishBtn.get_centerX = self.get_width * 0.5;
            self.publishBtn.get_y = itemY;
        }
    }];
    
    [self bringSubviewToFront:self.publishBtn];
    
}
-(UIButton *)publishBtn{
    
    if (_publishBtn==nil) {
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        _publishBtn = btn;
        /**
         图片换成自己的
         **/
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        btn.imageView.contentMode = UIViewContentModeCenter;
        ZBWeakSelf(self);
        ZBWeakSelf(btn);
        [btn addActionHandler:^(NSInteger tag) {
            !weakself.publishBtnClick ?: weakself.publishBtnClick(weakself,weakbtn);
        }];
    }
    
    return _publishBtn;
}
@end
