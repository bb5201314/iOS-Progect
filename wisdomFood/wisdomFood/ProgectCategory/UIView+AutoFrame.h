//
//  UIView+AutoFrame.h
//  wisdomfood
//
//  Created by 赵小波 on 2018/5/30.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 分类可以添加属性 但是不会自动生成set get 所以要在.m自己实现  直接调用属性会崩溃
 **/

@interface UIView (AutoFrame)

@property(nonatomic,assign)CGFloat get_x;

@property(nonatomic,assign)CGFloat get_y;

@property(nonatomic,assign)CGFloat get_right;

@property(nonatomic,assign)CGFloat get_bottom;

@property(nonatomic,assign)CGFloat get_width;

@property(nonatomic,assign)CGFloat get_height;

@property(nonatomic,assign)CGFloat get_centerX;

@property(nonatomic,assign)CGFloat get_centerY;

@property(nonatomic,assign)CGPoint get_origin;

@property(nonatomic,assign)CGSize  get_size;


@end
