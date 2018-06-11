//
//  CKHttpCommunicate.h
//  MumMum
//
//  Created by shlity on 16/6/16.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommunicateDefine.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger , HTTPRequestMethod)
{
    POST = 0,
    GET,
    PUT,
    DELETE
};

@interface CKHttpCommunicate : NSObject

+ (id)sharedInstance;


/**
 *  HTTP请求
 *
 *  @param urlStr   服务器提供的接口，用一个枚举来管理
 *  @param param    传的参数
 *  @param method   GET,POST,DELETE,PUT方法
 *  @param success  请求完成
 *  @param failure  请求失败
 *  @param showView 界面上显示的网络加载进度状态(nil为不显示)
 */
+ (void)createRequest:(NSString *)urlStr
            WithParam:(NSDictionary *)param
           withMethod:(HTTPRequestMethod)method
              success:(void(^)(id result))success
              failure:(void(^)(NSError *erro))failure
              showHUD:(UIView *)showView;


/**
 *  上传文件功能，如图片等
 *
 *  @param urlStr             服务器提供的接口，用一个枚举来管理
 *  @param param              传的参数
 *  @param Exparam            文件流，将要上传的文件转成NSData中，然后一起传给服务器
 *  @param method             GET,POST,DELETE,PUT方法
 *  @param success            请求完成
 *  @param uploadFileProgress 请求图片的进度条，百分比
 *  @param failure            请求失败
 */
+ (void)createRequest:(NSString *)urlStr
            WithParam:(NSDictionary*)param
          withExParam:(NSDictionary*)Exparam
           withMethod:(HTTPRequestMethod)method
              success:(void (^)(id result))success
              uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress
              failure:(void (^)(NSError* erro))failure;

/**
 *  下载文件功能
 *
 *  @param URLString                 要下载文件的URL
 *  @param downloadFileProgress      下载的进度条，百分比
 *  @param setupFilePath             设置下载的路径
 *  @param downloadCompletionHandler 下载完成后（下载完成后可拿到存储的路径）
 */
+ (void)createDownloadFileWithURLString:(NSString *)URLString
             downloadFileProgress:(void(^)(NSProgress *downloadProgress))downloadFileProgress
                    setupFilePath:(NSURL*(^)(NSURLResponse *response))setupFilePath
        downloadCompletionHandler:(void (^)(NSURL *filePath, NSError *error))downloadCompletionHandler;
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
+(void)uploadImageMethod:(NSString *)urlStr WithParam:(NSDictionary*)param  name:(NSString *)name imagesArray:(NSMutableArray *)images fileNames:(NSMutableArray *)fileNames imageType:(NSString *)imageType withMethod:(HTTPRequestMethod)method success:(void (^)(id result))success uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress failure:(void (^)(NSError* erro))failure showHUD:(UIView *)showView;

@end
