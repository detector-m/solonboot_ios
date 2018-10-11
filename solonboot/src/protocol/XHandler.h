//
//  XHandler.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XContext;

NS_ASSUME_NONNULL_BEGIN
/** 通用代理 */
typedef void(^XHandler)(XContext* context);

NS_ASSUME_NONNULL_END
