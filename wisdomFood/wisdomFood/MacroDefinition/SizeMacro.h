//
//  SizeMacro.h
//  wisdomFood
//
//  Created by 赵小波 on 2018/5/30.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#ifndef SizeMacro_h
#define SizeMacro_h

/*
 定义导航栏的高度
 */
#define  NavigationbarHeight ([[ToolsUtil shareTool] iPhoneXDevice]==YES ? 88 :64)
/*
 适配iphoneX 状态栏的高度变成了44
 */
#define  StatusBarHeight ([[ToolsUtil shareTool] iPhoneXDevice]==YES ? 44 :20)
/*
 tabbar适配iphoneX
 */
#define  TabbarHeight ([[ToolsUtil shareTool] iPhoneXDevice]==YES ? 83 :49)
/*
 屏幕尺寸
 */
#define kScreen_Size      [[UIScreen mainScreen] bounds].size
#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)

/**
 *  属性转字符串
 */
#define LMJKeyPath(obj, key) @(((void)obj.key, #key))
/**
 判断手机是不是iPhoneX
 **/

#define ZS_ISIphoneX    (kScreen_Width == 375.f && kScreen_Height == 812.f ? YES : NO)

/*
 是否是空对象
 */
#define LMJIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
/*
 不同屏幕尺寸字体适配
 */
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]

/**
 弱引用
 **/
#define ZBWeakSelf(type)  __weak typeof(type) weak##type = type;
/**
 强引用
 **/
#define ZBStrongSelf(type)  __strong typeof(type) type = weak##type;
/**
 单独只能取当前对象弱引用
 **/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* SizeMacro_h */
