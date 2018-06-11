//
//  ToolsUtil.m
//  YiDianQian
//
//  Created by ZXB on 16/8/29.
//  Copyright © 2016年 YiDianQian. All rights reserved.
//

#import "ToolsUtil.h"
#import <sys/utsname.h>

@interface ToolsUtil ()

@end

@implementation ToolsUtil

//01 提供静态变量
static ToolsUtil *_instance;

//02 重写allocWithZone方法,保证只分配一次存储空间
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

//03 提供类方法
+(instancetype)shareTool {
    
    return [[self alloc]init];
}

//04 更严谨的做法
-(id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    
    return _instance;
}
//以下的方法只需要
-(BOOL)isMobileNumber:(NSString *)mobileNum
{
  
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//邮箱
- (BOOL)authValidateEmail:(NSString *)str{
    
    NSString *Regex=@"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$";
    NSPredicate *test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [test evaluateWithObject:str];
}
//验证码
- (BOOL)authValidateAnyNumber:(NSString *)str{
    
    NSString *Regex=@"^[0-9]*$";
    NSPredicate *test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [test evaluateWithObject:str];
}



-(void)setLabel:(UILabel*)label andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor*) beforeColor andAfterCharacterNumber:(NSInteger) afterNumber andAfterColor:(UIColor*) afterColor
{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    if (label.text.length >= beforeNumber) {
        [content addAttribute:NSForegroundColorAttributeName value:beforeColor range:NSMakeRange(0, beforeNumber)];
    }
    
    if (label.text.length >= (afterNumber + beforeNumber)) {
        [content addAttribute:NSForegroundColorAttributeName value:afterColor range:NSMakeRange(beforeNumber, afterNumber)];
    }
    
    label.attributedText=content;
}

//自适应高度
-(CGSize)setLabHeightWithStr:(NSString *)text withFont:(UIFont *)font withMaxHeight:(CGSize)maxSize
{
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    //    CGSize size =CGSizeMake(KSCREENWIDTH ,height);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize;
}
//设置3段字体的区分
-(void)setLabel:(UILabel *)label andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor *)beforeColor andMiddleCharacterNumber:(NSInteger)middleNumber andMiddleColor:(UIColor *)middleColor andLastCharacterNumber:(NSInteger)lastNumber andLastColor:(UIColor *)lastColor
{


    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:label.text];
    //前面数字代表的是坐标 下面代表的是个数
    [content addAttribute:NSForegroundColorAttributeName value:beforeColor range:NSMakeRange(0, beforeNumber)];
    [content addAttribute:NSForegroundColorAttributeName value:middleColor range:NSMakeRange(beforeNumber,middleNumber)];
    [content addAttribute:NSForegroundColorAttributeName value:lastColor range:NSMakeRange(beforeNumber+middleNumber,lastNumber)];
     [content addAttribute:NSForegroundColorAttributeName value:middleColor range:NSMakeRange(beforeNumber+middleNumber+lastNumber,content.length-beforeNumber-middleNumber-lastNumber)];

    label.attributedText=content;
    
}
//设置alertTool message左对齐
-(void)setAlertToolParagraph:(UILabel*)label
{
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10.0f];
    //[paragraphStyle1 setParagraphSpacing:5];
    
    long number = 0.5f;//间距
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberFloat64Type,&number);
    [attributedString1  addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[label.text length])];
    CFRelease(num);
    
    
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString1];
    
    
}

-(void)addShakeWithView:(UIView*)view withAngle:(CGFloat)angle{
    if (!view) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.1 animations:^{
             view.transform = CGAffineTransformMakeRotation(-angle);
         } completion:^(BOOL finished) {
             [UIView animateWithDuration:0.1 animations:^{
                 view.transform = CGAffineTransformIdentity;
             } completion:^(BOOL finished) {

             }];
         }];
    }];
    
    
    
}

-(BOOL)isName:(NSString *)string
{
    NSString *regex = @"^[a-zA-Z_\u4e00-\u9fa5]+$";
    NSPredicate *authCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [authCodeTest evaluateWithObject:string];
}

-(CGRect)converToWindowPositionWithView:(UIView*)view position:(CGRect)rect{
    CGRect newRect = rect;
    if (!view) {
        return newRect;
    }
    
    UIView *superView = nil;
    view = [view superview];
    while ((superView = [view superview])) {
        //已经转化到了window 到底了
        newRect = [view convertRect:newRect toView:superView];
        if ([superView isKindOfClass:[UIWindow class]]) {
            break;
        }
        view =  superView;
    }
    return newRect;
}
//+(void)showMBProgressHUD:(UIView *)view andTitle:(NSString*) title
//{
//    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    //显示的文字
//    HUD.labelText=title;
//    HUD.dimBackground = NO;//使背景成黑灰色，让MBProgressHUD成高亮显示
//    //HUD.square = YES;//设置显示框的高度和宽度一样
//}
//+(void)hideMBProgressHUD:(UIView*)view
//{
//    [MBProgressHUD hideAllHUDsForView:view animated:YES];
//
//}
-(NSString *)exchangeDataToPercent:(NSString *)dataStr{
    
    
    NSString *str2 = [NSString stringWithFormat:@"%.2f",[dataStr floatValue]];
    
    return str2;

}
-(NSString *)isMonthOrDayToBackMoney:(NSInteger)isDay numberStr:(NSString *)numberStr
{

    if (isDay==0) {
        
        return  [NSString stringWithFormat:@"%@天",numberStr];
    }else{
    
        return  [NSString stringWithFormat:@"%@个月",numberStr];
    }
}
-(NSString *)isallAmount:(NSString *)amount remainAmount:(NSString *)remainAmount
{
//[NSString stringWithFormat:@"%.1f%%",[dataStr floatValue]*100]
    CGFloat allAmount=[amount floatValue];
    CGFloat hasRemianAmount=[remainAmount  floatValue];
    CGFloat showAmount=(allAmount-hasRemianAmount)/allAmount;
    return  [NSString stringWithFormat:@"%.0f%%",showAmount*100];
}
-(CGFloat)forpercentisallAmount:(NSString *)amount remainAmount:(NSString *)remainAmount{

    CGFloat allAmount=[amount floatValue];
    CGFloat hasRemianAmount=[remainAmount  floatValue];
    CGFloat showAmount=(allAmount-hasRemianAmount)/allAmount;
    
    return showAmount;
}
//判断字符串是否是整型
-(BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL||[string isEqual:@"(null)"]||[string isEqual:@""]||[string isEqual:@"<null>"]) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}
//添加加载风火轮
-(UIActivityIndicatorView *)indicatorViewAddTo:(UIView *)view
{
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.color = [UIColor grayColor];
    indicatorView.frame = CGRectMake(kScreen_Width/2-30,(kScreen_Height -49-64)/2, 60, 60);
    indicatorView.hidesWhenStopped = YES;
    
    [view addSubview:indicatorView];
    return indicatorView;
}

//获取当前视图控制器前面的第n个视图控制器
-(UIViewController *)getCurrentVcToNlastVc:(UIViewController *)viewController  vcIndex:(NSInteger)vcIndex{
    
    NSArray *viewCtrls=viewController.navigationController.viewControllers;
    for (int i=0; i<viewCtrls.count; i++)
    {
        if ([viewController isEqual:viewCtrls[i]] && i>vcIndex)
        {
            UIViewController *VC=viewCtrls[i-vcIndex];
            return VC;
        }
        
    }
    return nil;
    
}

-(void)saveCookieSession:(NSString *)url{

    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    NSLog(@"%@*****%lu",cookies,(unsigned long)cookies.count);
}
-(CGFloat)receiveAllAmount:(NSString *)allAmount  alreadyAlmount:(NSString *)alreadyAmount{

    CGFloat all=[allAmount floatValue];
    CGFloat already=[alreadyAmount  floatValue];
    CGFloat showAmount=already/all;
    return  showAmount;

}
-(void)loginCookieSessionSave:(NSString *)url{

    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    //把登录cookie保存在NSUserDefaults
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
   
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserDefaultCookie"];
    
}
-(void)clearLoginCookieSession{

    NSUserDefaults *defaults=[NSUserDefaults  standardUserDefaults];
    [defaults removeObjectForKey:@"UserDefaultCookie"];
    [defaults synchronize];
#pragma mark清除系统自动保存的cookie  因为有些页面需要登录才能拿数据
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}
//获取登录的cookie判断是不是登录状态
//-(BOOL)isLoginStatus
//{
//
//    NSUserDefaults *defaults=[NSUserDefaults  standardUserDefaults];
//    NSData* data=[defaults objectForKey:@"UserDefaultCookie"];
//    if(data){
//
//        return YES;
//    }
//    else{
//
//        return NO;
//    }
//}
//程序启动时候设置cookie 因为iOS退出程序会清除数据
-(void)setCookie{

    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultCookie"];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
/*压缩图片**/
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSizex
{
    float scaleSize = kScreen_Height/image.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize, image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(NSString *)countNumAndChangeformat:(NSString *)num
{
    //需要处理小数点
    NSRange rang = [num rangeOfString:@"."];
    NSString *integerString;
    NSString *pointString;
    if (rang.location != NSNotFound) {
        integerString = [num substringToIndex:rang.location];
        pointString = [num substringFromIndex:rang.location];
    }
    else {
        integerString = num;
    }
    
    //整数位
    int count = 0;
    long long int a = integerString.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:integerString];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    if (pointString) {
        [newstring appendString:pointString];
    }
    
    return newstring;
    
}
//金额转换成整形显示
-(NSString *)returnAmountStr:(NSString *)moneyStr{

    NSInteger amount=[moneyStr  integerValue];
    
    return  [NSString stringWithFormat:@"%ld",(long)amount];
    
}
//+ (BOOL)authValidatePassword:(NSString *)str{
//    
//    NSString *Regex=@"^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\()])+$)([^(0-9a-zA-Z)]|[\()]|[a-zA-Z]|[0-9]){8,20}$";
//    NSPredicate *test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
//    return [test evaluateWithObject:str];
//}
/**
 * 开始到结束的时间差
 */
- (NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSLog(@"%@*****%@",startTime,endTime);
    NSDateComponents *d = [cal components:unitFlags fromDate:[date dateFromString:startTime] toDate:[date dateFromString:endTime] options:0];
    NSLog(@"%ld天%ld小时%ld分钟%ld秒",(long)[d day],(long)[d hour],(long)[d minute],(long)[d second]);
    NSInteger allSecond=[d hour]*3600+[d minute]*60+[d second];
    NSLog(@"%ld",allSecond);
    return allSecond;
}
-(void)setButton:(UIButton *)button andBeforeCharacterNumber:(NSInteger)beforeNumber andBeforeColor:(UIColor*) beforeColor  andbeforeFont:(NSInteger)beforeFont andAfterCharacterNumber:(NSInteger) afterNumber andAfterColor:(UIColor*) afterColor   andAfterFont:(NSInteger)afterFont{

    
    
    if (button.titleLabel.text.length == 0) {
        return;
    }
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
    
    if (button.titleLabel.text.length >= beforeNumber) {
        /**区分前后段字体颜色***/
        [content addAttribute:NSForegroundColorAttributeName value:beforeColor range:NSMakeRange(0, beforeNumber)];
        [content addAttribute:NSForegroundColorAttributeName value:afterColor range:NSMakeRange(beforeNumber, afterNumber)];
        
        /**区分前后段字体大小**/
        [content addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:beforeFont] range:NSMakeRange(0,beforeNumber)];
        [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:afterFont] range:NSMakeRange(beforeNumber, afterNumber)];
         [button setAttributedTitle:content forState:(UIControlStateNormal)];
    }

    
}

//推送提醒开关
-(void)setPushNotificationStatus:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:@"PushNotification"];
}

- (BOOL)getPushNotificationStatus
{
    //默认为打开状态
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PushNotification"]) {
        BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"PushNotification"];
        return isOn;
    }
    
    return YES;
}
-(CGSize)sizeWithString:(NSString* )string font:(UIFont* )font constraintSize:(CGSize)constraintSize{

    CGSize stringSize = CGSizeZero;
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    CGRect stringRect = [string boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    stringSize = stringRect.size;
    
    return stringSize;
}
//计算日期 和当前日期时间差
- (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

//    unsigned int unitFlags = NSDayCalendarUnit;
    unsigned int unitFlags = NSCalendarUnitDay;

    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}
//计算两个日期之间的天数
- (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}
-(NSString *)needRealPercent:(CGFloat)needRealPercent{
    
    NSString *percentSring = [NSString stringWithFormat:@"%.2f",needRealPercent];
    NSRange rang = [percentSring rangeOfString:@"."];
    //截取小数点后两位 rang.location=1  0.01
    NSString *subPercentString = [percentSring substringToIndex:rang.location + 3];
    NSString *rateStr = [NSString stringWithFormat:@"%.f", [subPercentString doubleValue]*100];

    return rateStr;
}

//把搜索的内容都转换成拼音对比
#pragma mark--获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
-(NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}


#pragma mark-首页加入购物车动画
- (void)showAddCartAnmationSview:(UIView *)sview
                       imageView:(UIImageView *)imageView
                        starPoin:(CGPoint)startPoint
                        endPoint:(CGPoint)endpoint
                     dismissTime:(float)dismissTime
{
    __block CALayer *layer;
    layer                               = [[CALayer alloc]init];
    layer.contents                      = imageView.layer.contents;
    layer.frame                         = imageView.frame;
    layer.opacity                       = 1;
    [sview.layer addSublayer:layer];
    UIBezierPath *path                  = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    //贝塞尔曲线控制点
    float sx                            = startPoint.x;
    float sy                            = startPoint.y;
    float ex                            = endpoint.x;
    float ey                            = endpoint.y;
    float x                             = sx + (ex - sx) / 3;
    float y                             = sy + (ey - sy) * 0.5 - 400;
    CGPoint centerPoint                 = CGPointMake(x, y);
    [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
    //设置位置动画
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path                      = path.CGPath;
    animation.removedOnCompletion       = NO;
    //设置大小动画
    CGSize finalSize                    = CGSizeMake(imageView.image.size.height*0.1, imageView.image.size.width*0.1);
    CABasicAnimation *resizeAnimation   = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    resizeAnimation.removedOnCompletion = NO;
    [resizeAnimation setToValue:[NSValue valueWithCGSize:finalSize]];
//    //旋转
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation                   = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue           = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.cumulative        = YES;
//    rotationAnimation.duration          = 0.3;
//    rotationAnimation.repeatCount       = 1000;
    //动画组
    CAAnimationGroup * animationGroup   = [[CAAnimationGroup alloc] init];
    animationGroup.animations           = @[animation,resizeAnimation];
    //    animationGroup.delegate             = self;
    animationGroup.duration             = 1.2;
    animationGroup.removedOnCompletion  = NO;
    animationGroup.fillMode             = kCAFillModeForwards;
    animationGroup.autoreverses         = NO;
    animationGroup.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animationGroup forKey:@"buy"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dismissTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer removeFromSuperlayer];
        layer = nil;
    });
}


/**
 商品详情加入购物车的动画效果
 
 @param goodsImage 商品图片
 @param startPoint 动画起点
 @param endPoint   动画终点
 @param completion 动画执行完成后的回调
 */
-(void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion{
    
    //------- 创建shapeLayer -------//
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(startPoint.x, startPoint.y, 40, 40);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:animationLayer];
    
    //------- 创建移动轨迹 -------//
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    //两次贝瑟尔曲线
    [movePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((startPoint.x-endPoint.x)/2,30)];
    //三次贝瑟尔曲线
//[movePath addCurveToPoint:endPoint controlPoint1:CGPointMake(220+widthLeft,30) controlPoint2:CGPointMake(70,30)];
    // 轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    
    
    //------- 创建缩小动画 -------//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    
    // 添加轨迹动画
    [animationLayer addAnimation:pathAnimation forKey:nil];
    // 添加缩小动画
    [animationLayer addAnimation:scaleAnimation forKey:nil];
    
    
    //------- 动画结束后执行 -------//
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
        completion(YES);
    });
}
//判断密码是不是符合规则
-(BOOL)checkPassWordStr:(NSString *)passWordStr
{
    //6-16位数字和字母 字符 组成任意两两组合
    NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W_].*)(?=.*[0-9\\W_].*).{6,16}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    if ([pred evaluateWithObject:passWordStr]) {
        return YES ;
    }else
    {
        return NO;
    }
}
//判断用户用户名输入是不是正确
-(BOOL)checkUserNameStr:(NSString *)userNameStr{
    
    //判断用户名是不是符合规则
    NSString *passWordRegex = @"^[a-zA-Z][\\w_]{5,17}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    if ([pred evaluateWithObject:userNameStr]) {
        return YES ;
    }else
    {
        return NO;
    }
    
}
//根据每个接口 key组成的NSArray  来进行ascii码值从低到高的排序 然后返回一个字符串数组  升序排列
-(NSMutableArray  *)requestParameterNSArray:(NSMutableArray *)parameterNSArray{
    
    if (parameterNSArray.count==0||parameterNSArray==nil) {
        
        return nil;
    }

    NSMutableArray *returnArray=parameterNSArray;
    
    
    for (int i = 1; i < returnArray.count; i++) {
        
        for (int j = 0; j < returnArray.count - i; j++) {
            
            if ([returnArray[j] compare:returnArray[j+1]] == NSOrderedDescending) {
                
                [returnArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
            
        }
    }
    

    return  returnArray;
}
-(NSString *)returnCurrentTimeStr{

//    NSDate *currentData = [NSDate date];
//    NSString *currentDateStr = [NSString stringWithFormat:@"%.0f", (long)[currentData timeIntervalSince1970]*1000];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    
    return timeString;
}
//
////判断设备的型号
//- (NSString *)platformString {
//    NSString *platform = [self deviceName];
//    //TODO: https://www.theiphonewiki.com/wiki/Models
//    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([@[@"iPhone3,1", @"iPhone3,2", @"iPhone3,3"] containsObject:platform]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([@[@"iPhone5,1", @"iPhone5,2"] containsObject:platform])    return @"iPhone 5";
//    if ([@[@"iPhone5,3", @"iPhone5,4"] containsObject:platform])    return @"iPhone 5c";
//    if ([@[@"iPhone6,1", @"iPhone6,2"] containsObject:platform])    return @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
//    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
//    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
//    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
//    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
//    if ([@[@"iPhone9,1", @"iPhone9,3"] containsObject:platform])    return @"iPhone 7";
//    if ([@[@"iPhone9,2", @"iPhone9,4"] containsObject:platform])    return @"iPhone 7 Plus";
//    if ([@[@"iPhone10,1", @"iPhone10,4"] containsObject:platform])    return @"iPhone 8";
//    if ([@[@"iPhone10,2", @"iPhone10,5"] containsObject:platform])    return @"iPhone 8 Plus";
//    if ([@[@"iPhone10,3", @"iPhone10,6"] containsObject:platform])    return @"iPhone X";
//    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
//    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
//    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([@[@"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"] containsObject:platform])    return @"iPad 2";
//    if ([@[@"iPad2,5", @"iPad2,6", @"iPad2,7"] containsObject:platform])    return @"iPad mini";
//    if ([@[@"iPad3,1", @"iPad3,2", @"iPad3,3"] containsObject:platform])    return @"iPad 3";
//    if ([@[@"iPad3,4", @"iPad3,5", @"iPad3,6"] containsObject:platform])    return @"iPad 4";
//    if ([@[@"iPad4,1", @"iPad4,2", @"iPad4,3"] containsObject:platform])    return @"iPad Air";
//    if ([@[@"iPad4,4", @"iPad4,5", @"iPad4,6"] containsObject:platform])    return @"iPad mini 2";
//    if ([@[@"iPad4,7", @"iPad4,8", @"iPad4,9"] containsObject:platform])    return @"iPad mini 3";
//    if ([@[@"iPad5,1", @"iPad5,2"] containsObject:platform])    return @"iPad mini 4";
//    if ([@[@"iPad5,3", @"iPad5,4"] containsObject:platform])    return @"iPad Air 2";
//    if ([@[@"iPad6,3", @"iPad6,4"] containsObject:platform])    return @"iPad Pro (9.7-inch)";
//    if ([@[@"iPad6,7", @"iPad6,8"] containsObject:platform])    return @"iPad Pro (12.9-inch)";
//    if ([@[@"iPad6,11", @"iPad6,12"] containsObject:platform])    return @"iPad 5";
//    if ([@[@"iPad7,1", @"iPad7,2"] containsObject:platform])    return @"iPad Pro (12.9-inch, 2nd generation)";
//    if ([@[@"iPad7,3", @"iPad7,4"] containsObject:platform])    return @"iPad Pro (10.5-inch)";
//    if ([@[@"i386", @"x86_64"] containsObject:platform])        return @"Simulator";
//    return platform;
//}
//- (NSString *)deviceName
//{
//    static NSString *deviceName = nil;
//    if (deviceName == nil) {
//        struct utsname systemInfo;
//        uname(&systemInfo);
//        //UI_USER_INTERFACE_IDIOM
//        deviceName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    }
//    return deviceName;
//}
//
//- (BOOL)iPhoneXDevice {
//    NSString *platform = [self platformString];
//    if ([platform isEqualToString:@"iPhone X"] ||
//        //TODO: https://developer.apple.com/ios/human-interface-guidelines/icons-and-images/launch-screen/
//        //iPhone X Portrait size: 1125px x 2436px
//        ([platform isEqualToString:@"Simulator"] && ([UIScreen mainScreen].bounds.size.height == 812))) {
//        return YES;
//    }
//    return NO;
//}



-(BOOL)judgeLogicIsCorrect:(NSString *)errorCode{
    
    
    if([[ToolsUtil  shareTool]isBlankString:errorCode]){
        
        if ([errorCode isEqualToString:@"0000"] || [errorCode isEqualToString:@"999"]) {
            
            return YES;
        }
        else{
            
            return NO;
        }
        
        
    }else{
        
        return NO;
    }
    
   
}

//获取当前的视图控制器
-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



/**
 系统版本号对比
 **/
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}
/**
 验证身份证表达式
 **/
-(BOOL)vertifyIdentityCode:(NSString *)identityCode{
    
    NSString *Regex=@"(^\\d{18}$)|(^\\d{15}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [test evaluateWithObject:identityCode];
}

/**
 判断是不是含有表情符号 含有表情符返回YES
 **/
- (BOOL)stringContainsEmoji:(NSString *)string {

    __block BOOL returnValue =NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string  length]) options:NSStringEnumerationByComposedCharacterSequences  usingBlock:
     
     ^(NSString *substring,NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring  characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring  characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     returnValue =YES;
                     
                 }
                 
             }
             
         }else if (substring.length > 1) {
             
             const unichar ls = [substring  characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 returnValue =YES;
                 
             }
             
         }else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff) {
                 
                 returnValue =YES;
                 
             }else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 returnValue =YES;
                 
             }else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 returnValue =YES;
                 
             }else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 returnValue =YES;
                 
             }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 
                 returnValue =YES;
                 
             }
             
         }
         
     }];
    
    return returnValue;

}
/**
 判断身份认证的时候姓名是不是符合规则
 **/
-(BOOL)judgeUserNameIsCorrect:(NSString *)username{
    
    
    NSString *Regex=@"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,10})*";
    NSPredicate *test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [test evaluateWithObject:username];
    
}

@end















