//
//  XModule.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XApp;

NS_ASSUME_NONNULL_BEGIN
/** 通用模块 */
@protocol XModule
/** 启动模块 */
-(void)start:(XApp*) app;
@end

NS_ASSUME_NONNULL_END
