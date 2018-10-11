//
//  XRouter.h
//  solonboot
//
//  Created by noear on 2018/10/9.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHandler.h"

@class XContext;

NS_ASSUME_NONNULL_BEGIN

/** 通用路由 */
@protocol XRouter
//添加路由
-(void)add:(NSObject*) obj expr:(NSString*) expr target:(XHandler) target;
//移除路由
-(void)remove:(NSObject*)obj expr:(NSString*)expr;

//匹配目标（第一项目）
-(id)match:(NSString*) source;
//匹配目标（所有项目）
-(NSArray*)matches:(NSString*) source;

@end

NS_ASSUME_NONNULL_END
