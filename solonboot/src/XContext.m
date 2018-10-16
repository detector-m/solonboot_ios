//
//  XContext.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XContext.h"
#import "XUtil.h"

@interface XContext (){
    NSString* _originalUrl;
    NSMutableDictionary* _paramMap;
    
    BOOL _handled;
    XCallback _callback;
    id _requester;
    
    NSURL* _url;
}

@end

@implementation XContext

-(instancetype)initWith:(id)requester url:(NSString*)url params:(NSDictionary*)params callback:(XCallback)callback{
    _originalUrl = url;
    
    _paramMap = [NSMutableDictionary dictionary];
    _requester = requester;
    _callback = callback;
    
    _url = [NSURL URLWithString:url];
    
    if(params != nil){
        [_paramMap addEntriesFromDictionary:params];
    }
    
    //将queryString的参数进行整合
    NSString* query = [_url query];
    if(query != nil){
        NSArray* ss = [query split:@"&"];
        for(NSString* s in ss){
            NSArray* kv = [s split:@"="];
            if (kv.count == 2) {
                [_paramMap setObject:kv[1] forKey:kv[0]];
            }
        }
    }
    
    return self;
}

-(void)setHandled:(BOOL)handled{
    _handled = handled;
}
-(BOOL)getHandled{
    return _handled;
}

-(id)requester{
    return _requester;
}

-(NSString*)originalUrl{
    return _originalUrl;
}
-(NSURL*)url{
    return _url;
}

-(NSString*)protocol{
    return [_url scheme];
}
-(NSString*)host{
    return [_url host];
}
-(NSString*)path{
    return [_url path];
}
    
-(NSArray*)pathSegments{
    return [[[self path] subString:1] split:@"/"];
}

- (NSString *)fullpath{
    return [NSString stringWithFormat:@"%@://%@%@",self.protocol,self.host,self.path];
}

-(id)param:(NSString*)key{
    return [_paramMap objectForKey:key];
}
-(id)param:(NSString*)key def:(id)def{
    id val = [_paramMap objectForKey:key];
    
    if(val == nil){
        return def;
    }else{
        return val;
    }
}
-(NSDictionary*)paramMap{
    return _paramMap;
}

-(void)output:(id)data{
    if(_callback != nil){
        _callback(self,data);
    }
}

-(void)destroy{
    
}

@end
