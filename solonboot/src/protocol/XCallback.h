//
//  XCallback.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XContext;

NS_ASSUME_NONNULL_BEGIN
/** 通用回调 */
typedef void(^XCallback)(XContext* context,id data);

NS_ASSUME_NONNULL_END
