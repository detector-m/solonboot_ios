//
//  XApp.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XApp.h"
#import "XRouter.h"
#import "XModule.h"
#import "XUtil.h"
#import "XContext.h"

static id _global = nil;

/** 通用应用（同时是个通用代理） */
@interface XApp (){
    NSMutableArray* _modules;
    id<XRouter> _router; /** 路由器 */
}
-(instancetype)initWith:(id<XRouter>)router;
 /** 加载模块 */
-(void)loadModules;
-(void)do_execute:(XContext *)context handler:(XHandler)handler;

@end

/** 通用应用（同时是个通用代理） */
@implementation XApp

+(XApp*)global{
    return _global;
}

+(instancetype)start:(id<XRouter>)router{
    if(_global == nil){
        _global =  [[XApp alloc] initWith:router];
    
        //加载组件
        @try {
            [_global loadModules];
        } @catch (NSException* ex) {
            NSLog(@"%@", ex);
        }
    }
    
    return _global;
}

-(instancetype)initWith:(id<XRouter>)router{
    _router = router;
    _modules = [NSMutableArray array];
    
    return self;
}

-(void)loadModules{
    NSArray<NSBundle *> *ary = [NSBundle allFrameworks];
    for(NSBundle* boundle in ary){
        NSString* path = [boundle pathForResource:@"solonboot" ofType:@"plist"];
        
        if([XUtil isEmpty:path]){
            continue;
        }
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        if(dic == nil){
            continue;
        }
        
        @try{
            id xmstr = dic[@"solonboot.xmodule"];
            
            if([XUtil isEmpty:xmstr] == false){
                // 创建对象
                id xmobj = [XUtil newClass:xmstr];
                if(xmobj!=nil){
                    [xmobj start:self]; //xmobj is XModule
                
                    [_modules addObject:xmobj];
                }
            }
        }
        @catch(NSException* ex){
            NSLog(@"%@", ex);
        }
        
    }
}

-(void)reg:(NSObject*) obj expr:(NSString*)expr handler:(XHandler)handler{
    [_router add:obj expr:expr target:handler];
}

-(void)unreg:(NSObject*) obj expr:(NSString*)expr{
    [_router remove:obj expr:expr];
}

-(void)execute:(XContext *)context isMultiple:(BOOL)isMultiple{
    NSString* fullpath = context.fullpath;
    if(isMultiple){
        for(XHandler handler in [_router matches:fullpath]){
            @try {
                [self do_execute:context handler:handler];
            } @catch (NSException *ex) {
                NSLog(@"%@", ex);
            }
        }
    }else{
        XHandler handler   = [_router match:fullpath];
        [self do_execute:context handler:handler];
    }
}

-(void)do_execute:(XContext *)context handler:(XHandler)handler{
    if (handler != nil) {
        handler(context);
        [context setHandled:true];
    }
}

@end
