//
//  CKHttpCommunicate.m
//  MumMum
//
//  Created by shlity on 16/6/16.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import "CKHttpCommunicate.h"
#import "HttpCommunicateDefine.h"
#import "AFHTTPSessionManager.h"
//#import "MBProgressHUD+Add.h"
#import "MBProgressHUD+LMJ.h"
#import "CQHUD.h"
#define TIME_NETOUT     8.0f
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation CKHttpCommunicate
{
    AFHTTPSessionManager *_HTTPManager;
}

- (id)init
{
    if (self = [super init])
    {
        _HTTPManager = [AFHTTPSessionManager manager];
        _HTTPManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
        _HTTPManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _HTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [_HTTPManager.requestSerializer setTimeoutInterval:TIME_NETOUT];
        
        //添加https证书验证
       //  [_HTTPManager setSecurityPolicy:[CKHttpCommunicate customSecurityPolicy]];

        //把版本号信息传导请求头中
        [_HTTPManager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
        
        [_HTTPManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
        _HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
        
        
    }
    return self;
}

+ (id)sharedInstance
{
    static CKHttpCommunicate * HTTPCommunicate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPCommunicate = [[CKHttpCommunicate alloc] init];
    });
    return HTTPCommunicate;
}

+(void)createRequest:(NSString *)urlStr WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void (^)(id))success failure:(void (^)(NSError *))failure showHUD:(UIView *)showView
{
    
     [[CKHttpCommunicate sharedInstance] createUnloginedRequest:urlStr WithParam:param withMethod:method success:success failure:failure showHUD:showView];
    
}

- (void)createUnloginedRequest:(NSString *)urlStr WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(UIView *)showView
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    /**
     *  请求的时候给一个转圈的状态
     */
    if (showView) {
        
       [MBProgressHUD showProgressToView:showView Text:@"加载中..."];
        
    }
    /***
     看看系统baseurl是不是进行区分
      NSString * url = [NSString stringWithUTF8String:cHttpMethod[taskID]];
     NSString *URLString = [NSString stringWithFormat:@"%@%@",bas,url];
    **/

    NSString *URLString = [NSString stringWithFormat:@"%@",urlStr];

    /******************************************************************/
    /**
     *  将cookie通过请求头的形式传到服务器，比较是否和服务器一致
     */
    
    NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    
    if([cookiesData length]) {
        /**
         *  拿到所有的cookies
         */
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        
        for (NSHTTPCookie *cookie in cookies) {
            /**
             *  判断cookie是否等于服务器约定的ECM_ID
             */
            if ([cookie.name isEqualToString:@"ECM_ID"]) {
                //实现了一个管理cookie的单例对象,每个cookie都是NSHTTPCookie类的实例,将cookies传给服务器
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }
    }
    
    /******************************************************************/
    
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer requestWithMethod:[self getStringForRequestType:method] URLString:[[NSURL URLWithString:URLString relativeToURL:_HTTPManager.baseURL] absoluteString] parameters:param error:nil];

    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            //后台返回的status不是200的时候走这里处理
            if (showView) {
                [MBProgressHUD hideHUDForView:showView];
            }
//            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            if (error.code == -1009) {
               [CQHUD showToastWithMessage:@"网络已断开"];
            }else if (error.code == -1005){
                [CQHUD showToastWithMessage:@"网络连接已中断"];
            }else if(error.code == -1001){
                
                 [CQHUD showToastWithMessage:@"请求超时"];
                [MBProgressHUD showProgressToView:showView Text:@"加载中..."];

            }else if (error.code == -1003){
                
                  [CQHUD showToastWithMessage:@"未能找到使用指定主机名的服务器"];
            }else{
                [CQHUD showToastWithMessage:[NSString stringWithFormat:@"code:%ld %@",error.code,error.localizedDescription]];
            }
            
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
            
            //跟服务器交互成功
            if (success != nil)
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                if (showView) {
                    [MBProgressHUD hideHUDForView:showView];
                }
                /**
                 *  获取服务器传的请求头cookie信息，并保存
                 */
                
//                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:BaseSibuUrl]];
//
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
                
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Cookie"];
                
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if (result) {
                    
                     NSString *resposeCode=[result objectForKey:@"responseCode"];
                    
                    
                    if ([resposeCode isEqualToString:@"200"]) {
                        
                        success(result);
                        
                        NSLog(@"%@****",result);
                        
                    }else{
                        
                        
                         failure(result);
                         [CQHUD showToastWithMessage:[result objectForKey:@"operateMsg"]];
                       
                        
                    }
                    
                }
          
               
            }
        }
    }];
    
    [dataTask resume];
}
+(void)createRequest:(NSString *)urlStr WithParam:(NSDictionary *)param withExParam:(NSDictionary *)Exparam withMethod:(HTTPRequestMethod)method success:(void (^)(id))success uploadFileProgress:(void (^)(NSProgress *))uploadFileProgress failure:(void (^)(NSError *))failure
{
    
    
    [[CKHttpCommunicate sharedInstance] createUnloginedRequest:urlStr WithParam:param withExParam:Exparam withMethod:method success:success failure:failure uploadFileProgress:uploadFileProgress];
}

- (void)createUnloginedRequest:(NSString *)urlStr WithParam:(NSDictionary *)param withExParam:(NSDictionary*)Exparam withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    /******************************************************************/
    
    /*
     如果到时候要区分 多种分类接口 就添加taskID
     */
    
    /***
     看看系统baseurl是不是进行区分
     NSString * url = [NSString stringWithUTF8String:cHttpMethod[taskID]];
     NSString *URLString = [NSString stringWithFormat:@"%@%@",bas,url];
     **/
    NSString *URLString = [NSString stringWithFormat:@"%@",urlStr];
    
    /**
     *  将cookie通过请求头的形式传到服务器，比较是否和服务器一致
     */
    
    NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    
    if([cookiesData length]) {
        /**
         *  拿到所有的cookies
         */
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        
        for (NSHTTPCookie *cookie in cookies) {
            /**
             *  判断cookie是否等于服务器约定的ECM_ID
             */
            if ([cookie.name isEqualToString:@"ECM_ID"]) {
                //实现了一个管理cookie的单例对象,每个cookie都是NSHTTPCookie类的实例,将cookies传给服务器
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }
    }
    
    /******************************************************************/
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer multipartFormRequestWithMethod:[self getStringForRequestType:method] URLString:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //图片上传
        if (Exparam) {
            for (NSString *key in [Exparam allKeys]) {
                [formData appendPartWithFileData:[Exparam objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/jpeg"];
            }
        }
        
    } error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
 

        if (uploadProgress) { //上传进度
            uploadFileProgress (uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        /*
         errorCode=0;就是成功
         **/
        NSLog(@"%@****",responseObject);

        
        if (error) {
            
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            
            if (error.code == -1009) {
               
                [MBProgressHUD showError:@"网络已断开" ToView:window];
                
            }else if (error.code == -1005){
                
                [MBProgressHUD showError:@"网络连接已中断" ToView:window];
             
            }else if(error.code == -1001){
                [MBProgressHUD showError:@"请求超时" ToView:window];

            }else if (error.code == -1003){
               
                  [MBProgressHUD showError:@"未能找到使用指定主机名的服务器" ToView:window];
            }else{
               
                 [MBProgressHUD showError:[NSString stringWithFormat:@"code:%ld %@",error.code,error.localizedDescription] ToView:window];
            }
            
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
            
            if (success != nil)
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                /**
                 *  获取服务器传的请求头cookie信息，并保存
                 */
                
//                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:BaseSibuUrl]];
//
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Cookie"];
                
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                success(result);
            }
        }

    }];
    
    [dataTask resume];
}

+ (void)createDownloadFileWithURLString:(NSString *)URLString
             downloadFileProgress:(void(^)(NSProgress *downloadProgress))downloadFileProgress
                    setupFilePath:(NSURL*(^)(NSURLResponse *response))setupFilePath
        downloadCompletionHandler:(void (^)(NSURL *filePath, NSError *error))downloadCompletionHandler
{
    if (URLString) {
        [[CKHttpCommunicate sharedInstance]createUnloginedDownloadFileWithURLString:URLString downloadFileProgress:downloadFileProgress setupFilePath:setupFilePath downloadCompletionHandler:downloadCompletionHandler];
    }
}

- (void)createUnloginedDownloadFileWithURLString:(NSString *)URLString
                            downloadFileProgress:(void(^)(NSProgress *downloadProgress))downloadFileProgress
                                   setupFilePath:(NSURL*(^)(NSURLResponse *response))setupFilePath
                       downloadCompletionHandler:(void (^)(NSURL *filePath, NSError *error))downloadCompletionHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:1 timeoutInterval:15];
    
    NSURLSessionDownloadTask *dataTask = [_HTTPManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        /**
         *  下载进度
         */
        downloadFileProgress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        /**
         *  设置保存目录
         */
        
        return setupFilePath(response);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        /**
         *  下载完成
         */
        downloadCompletionHandler(filePath,error);
    
    }];
    
    [dataTask resume];
}

#pragma mark - GET Request type as string

-(NSString *)getStringForRequestType:(HTTPRequestMethod)type {
    
    NSString *requestTypeString;
    
    switch (type) {
        case POST:
            requestTypeString = @"POST";
            break;
            
        case GET:
            requestTypeString = @"GET";
            break;
            
        case PUT:
            requestTypeString = @"PUT";
            break;
            
        case DELETE:
            requestTypeString = @"DELETE";
            break;
            
        default:
            requestTypeString = @"POST";
            break;
    }

    return requestTypeString;
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/**
 判断是不是开启了https安全访问
 
 当我们的工程中有SDWebImage框架的请求HTTPS的图片时,大家可以绕过证书验证去加载图片
 
 [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:self.placeholder options:SDWebImageAllowInvalidSSLCertificates];
 **/
+ (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"chidean" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}
/**
 *  上传单/多张图片
 *
 *  @param urlStr        请求地址
 *  @param param 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 
 @param method   上传类型
 *  @param success   上传进度信息
 *  @param uploadFileProgress    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *
 */
+(void)uploadImageMethod:(NSString *)urlStr WithParam:(NSDictionary*)param  name:(NSString *)name imagesArray:(NSMutableArray *)images fileNames:(NSMutableArray *)fileNames imageType:(NSString *)imageType withMethod:(HTTPRequestMethod)method success:(void (^)(id result))success uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress failure:(void (^)(NSError* erro))failure showHUD:(UIView *)showView
{
    
    [[CKHttpCommunicate sharedInstance] uploadImageRequestUrl:urlStr WithParam:param name:name imagesArray:images fileNames:fileNames imageType:imageType withMethod:method success:success failure:failure uploadFileProgress:uploadFileProgress showHUD:showView];
    
}
-(void)uploadImageRequestUrl:(NSString *)urlStr WithParam:(NSDictionary*)param  name:(NSString *)name imagesArray:(NSMutableArray *)images fileNames:(NSMutableArray *)fileNames imageType:(NSString *)imageType withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress showHUD:(UIView *)showView{
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    /**
     *  请求的时候给一个转圈的状态
     */
    if (showView) {
        [MBProgressHUD showProgressToView:showView Text:@"正在上传..."];


    }
    /******************************************************************/
    
    /*
     如果到时候要区分 多种分类接口 就添加taskID
     */
    
    /***
     看看系统baseurl是不是进行区分
     NSString * url = [NSString stringWithUTF8String:cHttpMethod[taskID]];
     NSString *URLString = [NSString stringWithFormat:@"%@%@",bas,url];
     **/
    NSString *URLString = [NSString stringWithFormat:@"%@",urlStr];
    
    /**
     *  将cookie通过请求头的形式传到服务器，比较是否和服务器一致
     */
    
    NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    
    if([cookiesData length]) {
        /**
         *  拿到所有的cookies
         */
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        
        for (NSHTTPCookie *cookie in cookies) {
            /**
             *  判断cookie是否等于服务器约定的ECM_ID
             */
            if ([cookie.name isEqualToString:@"ECM_ID"]) {
                //实现了一个管理cookie的单例对象,每个cookie都是NSHTTPCookie类的实例,将cookies传给服务器
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }
    }
    
    /******************************************************************/
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer multipartFormRequestWithMethod:[self getStringForRequestType:method] URLString:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传图片数组
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            
            NSData *imageData = UIImageJPEGRepresentation(images[i],1);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        if (uploadProgress) { //上传进度
            uploadFileProgress (uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        /*
         errorCode=0;就是成功
         **/
        NSLog(@"%@****",responseObject);
        
        
        if (error) {
            
            if (showView) {
                [MBProgressHUD hideHUDForView:showView];
            }
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            
            if (error.code == -1009) {
               
                [MBProgressHUD showError:@"网络已断开" ToView:window];
            }else if (error.code == -1005){
                [MBProgressHUD showError:@"网络连接已中断" ToView:window];

            }else if(error.code == -1001){
                [MBProgressHUD showError:@"请求超时" ToView:window];

            }else if (error.code == -1003){
              
                [MBProgressHUD showError:@"未能找到使用指定主机名的服务器" ToView:window];

            }else{
               
                  [MBProgressHUD showError:[NSString stringWithFormat:@"code:%ld %@",error.code,error.localizedDescription] ToView:window];
            }
            
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
            
            if (success != nil)
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                /**
                 *  获取服务器传的请求头cookie信息，并保存
                 */
                
//                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:BaseSibuUrl]];
//                
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//                
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Cookie"];
//                
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if (showView) {
                    [MBProgressHUD hideHUDForView:showView];
                }
                
                success(result);
            }
        }
        
    }];
    
    [dataTask resume];
    
    
}
@end
