//
//  XRouterMap.m
//  solonboot
//
//  Created by noear on 2018/10/9.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XRouterMap.h"
#import "XUtil.h"
#import "XContext.h"

/** 通用监听者 */
@interface XCodeListener : NSObject {
    NSUInteger _code;
}
@property(nonatomic) id target;
-(BOOL)matches:(NSUInteger) source_code;

-(instancetype)initWith:(NSUInteger)expr_code target:(id)target;
@end

/** 通用监听者 */
@implementation XCodeListener
//初始化
-(instancetype)initWith:(NSUInteger)expr_code target:(id)target{
    _code = expr_code;
    _target = target;
    
    return self;
}
//匹配
-(BOOL)matches:(NSUInteger) source_code{
    if(source_code == 0){
        return NO;
    }else{
        return _code == source_code;
    }
}

@end


///////////////////////////////////////////////////////
//
//
//

@interface XRouterMap (){
    NSMutableDictionary* _routerList;
}

@end

@implementation XRouterMap

- (instancetype)init
{
    self = [super init];
    if (self) {
        _routerList = [NSMutableDictionary dictionary];
    }
    return self;
}

//添加路由
-(void)add:(NSObject*)obj expr:(NSString*) expr target:(XHandler) target{
    NSString* key = [NSString stringWithFormat:@"%zi_%@",obj.hash,expr];
    [_routerList setObject:[[XCodeListener alloc] initWith:expr.lowercaseString.hash target:target] forKey:key];
}
- (void)remove:(NSObject *)obj expr:(NSString *)expr{
    NSString* key = [NSString stringWithFormat:@"%zi_%@",obj.hash,expr];
    [_routerList removeObjectForKey:key];
}
//匹配目标
-(id)match:(NSString*) source{
    NSUInteger source_code = source.lowercaseString.hash;
    for (XCodeListener* l in _routerList) {
        if ([l matches:source_code]) {
            return l.target;
        }
    }
    
    return nil;
}

- (NSArray *)matches:(NSString *)source{
    NSMutableArray* list = [NSMutableArray array];
    
    NSUInteger source_code = source.lowercaseString.hash;
    for (XCodeListener* l in _routerList) {
        if ([l matches:source_code]) {
            [list addObject:l.target];
        }
    }
    
    return list;
}
@end
