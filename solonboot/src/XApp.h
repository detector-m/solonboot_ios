//
//  XApp.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XRouter.h"
#import "XModule.h"

NS_ASSUME_NONNULL_BEGIN

/** 通用应用（同时是个通用代理） */
@interface XApp : NSObject
/** 应用全局对象 */
+(instancetype)global;
/** 启动应用（全局只启动一个） */
+(instancetype)start:(UIApplication*)application router:(id<XRouter>)router;

-(UIApplication*)application;
    
/** 手动添加模块 */
-(void)addModule:(id<XModule>)module;
    
/** 注册路由 */
-(void)reg:(NSObject*) obj expr:(NSString*)expr handler:(XHandler)handler;
/** 注销路由 */
-(void)unreg:(NSObject*) obj expr:(NSString*)expr;

/** 路由执行 */
-(BOOL)execute:(XContext *)context isMultiple:(BOOL)isMultiple;

@end

NS_ASSUME_NONNULL_END
