//
//  XApp.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XApp.h"
#import "XUtil.h"
#import "XContext.h"


static id _global = nil;

/** 通用应用（同时是个通用代理） */
@interface XApp (){
    NSMutableArray* _modules;
    id<XRouter> _router; /** 路由器 */
    UIApplication* _application;
}
-(instancetype)initWith:(UIApplication*)application router:(id<XRouter>)router;
/** 自动加载模块 */
-(void)loadModules;
-(void)do_execute:(XContext *)context handler:(XHandler)handler;

@end

/** 通用应用（同时是个通用代理） */
@implementation XApp

+(XApp*)global{
    return _global;
}

+(instancetype)start:(UIApplication*)application router:(id<XRouter>)router{
    if(_global == nil){
        _global =  [[XApp alloc] initWith:application router:router];
    
        //加载组件
        @try {
            [_global loadModules];
        } @catch (NSException* ex) {
            NSLog(@"%@", ex);
        }
    }
    
    return _global;
}

-(instancetype)initWith:(UIApplication*)application router:(id<XRouter>)router{
    _router = router;
    _modules = [NSMutableArray array];
    _application = application;
    
    return self;
}

-(void)loadModules{
    NSArray<NSBundle *> *ary = [NSBundle allFrameworks];
    
    NSString *boundleExtension  = @"bundle";
    NSString *boundleName = nil;
    NSString *boundlePath = nil;
    NSBundle* boundle = nil;
    
    for(NSBundle* b1 in ary){
        boundle = b1;
        NSString* path = [boundle pathForResource:@"solonboot" ofType:@"plist"];
        
        if([XUtil isEmpty:path]){
            /** 如果配置路径不存在 */
            
            //1.检查是否存在二级包
             boundleName = [boundle infoDictionary][@"CFBundleExecutable"];
            if([XUtil isEmpty:boundleName]){
                continue;
            }
            
            //2.检查是否有包路径
            boundlePath = [boundle pathForResource:boundleName ofType:boundleExtension];
            if([XUtil isEmpty:boundlePath]){
                continue;
            }
            
            //3.检查是否有配置文件的路径
            boundle = [NSBundle bundleWithPath:boundlePath];
            path = [boundle pathForResource:@"solonboot" ofType:@"plist"];
            if([XUtil isEmpty:path]){
                continue;
            }
        }
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        if(dic == nil){
            continue;
        }
        
        @try{
            id xmstr = dic[@"solonboot.xmodule"];
            
            if([XUtil isEmpty:xmstr] == false){
                // 创建对象
                id<XModule> module = (id<XModule>)[XUtil newClass:xmstr];
                [self addModule:module];
            }
        }
        @catch(NSException* ex){
            NSLog(@"%@", ex);
        }
        
    }
}
    
-(UIApplication*)application{
    return _application;
}
    
/** 手动添加模块 */
-(void)addModule:(id<XModule>)module{
    if(module != nil){
        [module start:self]; //xmobj is XModule
    
        [_modules addObject:module];
    }
}

-(void)reg:(NSObject*) obj expr:(NSString*)expr handler:(XHandler)handler{
    [_router add:obj expr:expr target:handler];
}

-(void)unreg:(NSObject*) obj expr:(NSString*)expr{
    [_router remove:obj expr:expr];
}

-(BOOL)execute:(XContext *)context isMultiple:(BOOL)isMultiple{
    NSString* fullpath = context.fullpath;
    BOOL is_matched = FALSE;
    
    if(isMultiple){
        for(XHandler handler in [_router matches:fullpath]){
            @try {
                [self do_execute:context handler:handler];
            } @catch (NSException *ex) {
                NSLog(@"%@", ex);
            }
            is_matched = TRUE;
        }
    }else{
        XHandler handler   = [_router match:fullpath];
        [self do_execute:context handler:handler];
        is_matched = (handler != nil);
    }
    
    return is_matched;
}

-(void)do_execute:(XContext *)context handler:(XHandler)handler{
    if (handler != nil) {
        handler(context);
        [context setHandled:true];
    }
}

@end
