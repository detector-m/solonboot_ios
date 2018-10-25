//
//  XContext.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCallback.h"

NS_ASSUME_NONNULL_BEGIN

/** 通用上下文 */
@interface XContext : NSObject

-(instancetype)initWith:(id)requester url:(NSString*)url params:(NSDictionary*)params callback:(XCallback)callback;

/** 是否已处理 */
-(void)setHandled:(BOOL)handled;
-(BOOL)getHandled;

/** 获取请求对象 */
-(id)requester;

/** 获取请求的URL源码字符串 */
-(NSString*)originalUrl;
/** 获取请求的URL */
-(NSURL*)url;

/** 获取请求协议 */
-(NSString*)protocol;
/** 获取请求的host */
-(NSString*)host;
/** 获取请求的path */
-(NSString*)path;
 /** 获取请求的path分段 */
-(NSArray*)pathSegments;
   
/** 获取请求的fullpath */
-(NSString*)fullpath;

/** 获取参数 */
-(id)param:(NSString*)key;
-(id)param:(NSString*)key def:(id)def;
/** 获取所有参数 */
-(NSDictionary*)paramMap;

/** 设置附加特性 */
-(void)attrSet:(NSString*)key val:(id)val;
/** 获取附加特性 */
-(id)attrGet:(NSString*)key;

/** 输出内容 */
-(void)output:(id)data;

/** 销毁上下文(仅限内部操作) */
-(void)destroy;

@end

NS_ASSUME_NONNULL_END
