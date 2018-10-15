//
//  XClient.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XClient.h"
#import "XContext.h"
#import "XApp.h"


@implementation XClient

+(void)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params{
    [self do_handle:requester url:url params:params callback:nil isMultiple:FALSE];
}
+(void)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params callback:(nullable XCallback)callback{
    [self do_handle:requester url:url params:params callback:callback isMultiple:FALSE];
}
+(void)send:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params{
    [self do_handle:requester url:url params:params callback:nil isMultiple:TRUE];
}

+(void)do_handle:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params callback:(nullable XCallback)callback isMultiple:(BOOL)isMultiple{
    XContext* ctx = [[XContext alloc] initWith:requester url:url params:params callback:callback];
    
    @try {
        //2.尝试执行
        [XApp.global execute:ctx isMultiple:isMultiple];
    } @catch (NSException* ex) {
        NSLog(@"%@", ex);
    }
}

@end
