//
//  XApp.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRouter.h"

NS_ASSUME_NONNULL_BEGIN

/** 通用应用（同时是个通用代理） */
@interface XApp : NSObject
/** 应用全局对象 */
+(instancetype)global;
/** 启动应用（全局只启动一个） */
+(instancetype)start:(id<XRouter>)router;

/** 注册路由 */
-(void)reg:(NSObject*) obj expr:(NSString*)expr handler:(XHandler)handler;
/** 注销路由 */
-(void)unreg:(NSObject*) obj expr:(NSString*)expr;

/** 路由执行 */
-(void)execute:(XContext *)context isMultiple:(BOOL)isMultiple;

@end

NS_ASSUME_NONNULL_END
