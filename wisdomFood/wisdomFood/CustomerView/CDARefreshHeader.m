//
//  CDARefreshHeader.m
//  chidean
//
//  Created by 赵小波 on 2017/7/6.
//  Copyright © 2017年 chideankeji. All rights reserved.
//

#import "CDARefreshHeader.h"
@interface  CDARefreshHeader ()

@end

@implementation CDARefreshHeader


#pragma mark - 构造方法
+ (instancetype)headerWithType:(MJRefreshOperationType)type withRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock withContinuePullingCompletionBlock:(MJRefreshComponentContinuePullingCompletionBlock)continuePullingCompletionBlock
{
    CDARefreshHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    header.operationType = type;
    header.endContinuePullingBlock = continuePullingCompletionBlock;
    
    
    return header;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationType = MJRefreshOperationTypeNormal;
    }
    return self;
}

- (void)setOperationType:(MJRefreshOperationType)operationType
{
    _operationType = operationType;
    if (operationType == MJRefreshOperationTypeMorePulling) {
        [self setTitle:@"100%检测,让您吃的更放心!" forState:MJRefreshStatePulling];
        [self setTitle:@"100%检测,让您吃的更放心!" forState:(MJRefreshState)MJRefreshStateContinuePulling];
    }
}

#pragma mark - 父类方法
- (void)prepare
{
    [super prepare];
    
}

/**
 摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    

}


@end
