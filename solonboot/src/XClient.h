//
//  XClient.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCallback.h"

NS_ASSUME_NONNULL_BEGIN

/** 通用客户端 */
@interface XClient : NSObject
/** 调用（用于功能调用）*/
+(void)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params;
+(void)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params callback:(nullable XCallback)callback;
/** 发送（用于消息广播）*/
+(void)send:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params;

@end

NS_ASSUME_NONNULL_END
