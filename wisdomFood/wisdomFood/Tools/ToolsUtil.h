//
//  ToolsUtil.h
//  YiDianQian
//
//  Created by ZXB on 16/8/29.
//  Copyright © 2016年 YiDianQian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**单利类 所有的公共方法都写在这里***/
@interface ToolsUtil : NSObject <NSCopying,NSMutableCopying>
//提供类方法
/*
 1)方便访问
 2)身份标识
 3)规范:share | share + 类名 |default |default + 类名 |类名
 */
+(instancetype)shareTool;

-(BOOL)isMobileNumber:(NSString *)mobileNum;//判断电话号码是否有效
- (BOOL)authValidateEmail:(NSString *)str;//电子邮箱
- (BOOL)authValidateAnyNumber:(NSString *)str;//任意数字



-(void)setLabel:(UILabel*)label andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor*) beforeColor andAfterCharacterNumber:(NSInteger) afterNumber andAfterColor:(UIColor*) afterColor;
//lab自适应高度
-(CGSize)setLabHeightWithStr:(NSString *)text withFont:(UIFont *)font withMaxHeight:(CGSize)maxSize;
//设置 前 中 后  3段字体的颜色
-(void)setLabel:(UILabel*)label andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor*) beforeColor andMiddleCharacterNumber:(NSInteger) middleNumber andMiddleColor:(UIColor*) middleColor    andLastCharacterNumber:(NSInteger)lastNumber   andLastColor:(UIColor *)lastColor;
-(void)setAlertToolParagraph:(UILabel*)label;
-(void)addShakeWithView:(UIView*)view withAngle:(CGFloat)angle;
-(BOOL) isName:(NSString *)string;
-(CGRect)converToWindowPositionWithView:(UIView*)view position:(CGRect)rect;
////显示加载的菊花
//+(void)hideMBProgressHUD:(UIView*)view;
//+(void)showMBProgressHUD:(UIView *)view andTitle:(NSString*)title;
//对数据进行处理
-(NSString *)exchangeDataToPercent:(NSString *)dataStr;
//判断标的周期是月还是天
-(NSString *)isMonthOrDayToBackMoney:(NSInteger)isDay numberStr:(NSString *)numberStr;
//对投资百分比的 转换  第一个参数 总共贷款金额 第二个参数 已经筹的金额
-(NSString *)isallAmount:(NSString *)amount  remainAmount:(NSString *)remainAmount;
//返回cgfloat
-(CGFloat)forpercentisallAmount:(NSString *)amount  remainAmount:(NSString *)remainAmount;
//判断字符串是否是整型
-(BOOL)isPureInt:(NSString*)string;
//字符串是不是为空
-(BOOL)isBlankString:(NSString *)string ;
- (UIActivityIndicatorView *)indicatorViewAddTo:(UIView *)view;

//注册和修改密码 cookie保存方法
-(void)saveCookieSession:(NSString *)url;
//由总金额和已经投资金额 计算已经投资比例
-(CGFloat)receiveAllAmount:(NSString *)allAmount  alreadyAlmount:(NSString *)alreadyAmount;
//登录cookie存储
-(void)loginCookieSessionSave:(NSString *)url;
//退出时清除cookie
-(void)clearLoginCookieSession;
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSizex;
//+(BOOL)isLoginStatus;
// iOS 数字 千分位显示 每三位逗号隔开
-(NSString *)countNumAndChangeformat:(NSString *)num;
//设置cookie
-(void)setCookie;
//金额转换成整形显示
-(NSString *)returnAmountStr:(NSString *)moneyStr;
//验证密码是不是合理 8-20 字母 数字 字符两两结合
//- (BOOL)authValidatePassword:(NSString *)str;//密码 任意数字，字母
/**
 * 开始到结束的时间差
 */
-(NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/***
 区分按钮的文字颜色和 大小
 **/
-(void)setButton:(UIButton *)button andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor*) beforeColor  andbeforeFont:(NSInteger)beforeFont andAfterCharacterNumber:(NSInteger) afterNumber andAfterColor:(UIColor*) afterColor   andAfterFont:(NSInteger)afterFont;
-(CGSize)sizeWithString:(NSString* )string font:(UIFont* )font constraintSize:(CGSize)constraintSize;

//推送提醒开关
-(void)setPushNotificationStatus:(BOOL)on;
- (BOOL)getPushNotificationStatus;
- (NSInteger)getDifferenceByDate:(NSString *)date;
-(NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
//计算已经投资量
-(NSString *)needRealPercent:(CGFloat)needRealPercent;
//搜索拼音转换
-(NSString *)transformToPinyin:(NSString *)aString;
//加入购物车的动画
- (void)showAddCartAnmationSview:(UIView *)sview
                       imageView:(UIImageView *)imageView
                        starPoin:(CGPoint)startPoint
                        endPoint:(CGPoint)endpoint
                     dismissTime:(float)dismissTime;
//验证密码是不是合格
-(BOOL)checkPassWordStr:(NSString *)passWordStr;
//判断用户名是不是合格
-(BOOL)checkUserNameStr:(NSString *)userNameStr;
//根据每个接口 key组成的NSArray  来进行ascii码值从低到高的排序 然后返回一个字符串数组
-(NSMutableArray *)requestParameterNSArray:(NSMutableArray *)parameterNSArray;
//获取当前时间戳
-(NSString *)returnCurrentTimeStr;

//判断是不是iphoneX
//- (BOOL)iPhoneXDevice;

//判断服务器是不是请求成功
-(BOOL)judgeLogicIsCorrect:(NSString *)errorCode;

//获取当前的视图控制器
-(UIViewController *)getCurrentVC;


/**
 商品详情加入购物车动画
 **/
-(void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion;


/**
 获取当前视图控制器前面的第n个视图控制器
 **/
-(UIViewController *)getCurrentVcToNlastVc:(UIViewController *)viewController  vcIndex:(NSInteger)vcIndex;

/**
 系统版本号对比
 **/
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion;
/**
 验证身份证表达式
 **/
-(BOOL)vertifyIdentityCode:(NSString *)identityCode;
/**
 判断是不是含有表情符号
 **/
- (BOOL)stringContainsEmoji:(NSString *)string;
/**
 判断认证用户名是不是符合规则
 **/
-(BOOL)judgeUserNameIsCorrect:(NSString *)username;

@end
