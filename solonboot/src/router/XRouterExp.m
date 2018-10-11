//
//  XRouter.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XRouterExp.h"
#import "XUtil.h"
#import "XContext.h"

/** 通用监听者 */
@interface XRuleListener : NSObject {
    NSRegularExpression* _rule;
}
@property(nonatomic) id target;
-(BOOL)matches:(NSString*) source;

-(instancetype)initWith:(NSString*)expr target:(id)target;
@end

/** 通用监听者 */
@implementation XRuleListener
//初始化
-(instancetype)initWith:(NSString*)expr target:(id)target{
    _rule = [NSRegularExpression regularExpressionWithPattern:expr options:NSRegularExpressionCaseInsensitive error:nil];
    _target = target;
    
    return self;
}
//匹配
-(BOOL)matches:(NSString*) source{
    if(source == nil){
        return NO;
    }else{
        NSRange range = NSMakeRange(0, source.length);
        return [_rule firstMatchInString:source options:0 range:range] != nil;
    }
}

@end



///////////////////////////////////////////////////////
//
//
//

@interface XRouterExp (){
    NSMutableDictionary* _routerList;
}

@end

/** 通用路由 */
@implementation XRouterExp

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
    
    //做开始预处理
    if([expr startsWith:@"**"] == false){
        expr = [NSString stringWithFormat:@"^%@",expr];
    }
    
    //做结束预处理
    if ([expr endsWith:@"**"]) {
        expr = [expr subString:0 length:expr.length - 2]; //不限内容
    } else {
        if ([expr endsWith:@"$"] == false) { //结束不要加
            expr = [NSString stringWithFormat:@"%@$",expr];
        }
    }
    
    //替换*值
    expr = [expr replace:@"\\*" with:@"[^/]+" ];
    
    [_routerList setObject:[[XRuleListener alloc] initWith:expr target:target] forKey:key];
}

-(void)remove:(NSObject *)obj expr:(NSString *)expr{
    NSString* key = [NSString stringWithFormat:@"%zi_%@",obj.hash,expr];
    [_routerList removeObjectForKey:key];
}

//匹配目标
-(id)match:(NSString*) source{
    for (XRuleListener* l in _routerList.allValues) {
        if ([l matches:source]) {
            return l.target;
        }
    }
    
    return nil;
}

- (NSArray *)matches:(NSString *)source{
    NSMutableArray* list = [NSMutableArray array];
    
    for (XRuleListener* l in _routerList.allValues) {
        if ([l matches:source]) {
            [list addObject:l.target];
        }
    }
    
    return list;
}

@end

