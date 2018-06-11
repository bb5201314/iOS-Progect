//
//  CDARefreshHeader.h
//  chidean
//
//  Created by 赵小波 on 2017/7/6.
//  Copyright © 2017年 chideankeji. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
typedef NS_ENUM(NSInteger, MJRefreshStateEX) {
    /** 松开可以刷新，继续下拉 */
    MJRefreshStateContinuePulling = 6,
};
//MJRefreshGifHeader->继承->MJRefreshStateHeader->MJRefreshHeader 同时修改图片和文字
/**
 刷新操作方式
 
 - MJRefreshOperationTypeNormal: 普通
 - MJRefreshOperationTypeMorePulling: 继续刷新
 */
typedef NS_ENUM(NSInteger,  MJRefreshOperationType) {
    MJRefreshOperationTypeNormal,
    MJRefreshOperationTypeMorePulling,
};

/** 继续下拉 */
typedef void (^MJRefreshComponentContinuePullingCompletionBlock)();

@interface CDARefreshHeader : MJRefreshGifHeader


@property (nonatomic, assign) MJRefreshOperationType operationType;

@property (nonatomic, copy) MJRefreshComponentContinuePullingCompletionBlock endContinuePullingBlock;

+ (instancetype)headerWithType:(MJRefreshOperationType)type withRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock withContinuePullingCompletionBlock:(MJRefreshComponentContinuePullingCompletionBlock)continuePullingCompletionBlock;
@end
