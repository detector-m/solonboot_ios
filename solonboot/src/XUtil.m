//
//  XUtil.m
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <objc/runtime.h>
#import "XUtil.h"

@implementation XUtil
+(NSString*)guid{
    return nil;
}
+(BOOL)isEmpty:(nullable NSString*)str{
    if(str == nil || str.length==0){
        return true;
    }else{
        return false;
    }
}
+(id)newClass:(NSString*)str{
    const char *className = [str cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        //创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    return [[newClass alloc] init];
}


@end


/////////////////////////////////////

@implementation NSString (solon)

-(NSInteger)indexOf:(NSString *)searchstring
{
    NSRange start=[self rangeOfString:searchstring];
    if (start.location == NSNotFound)
        return -1;
    else
        return start.location;
}

-(NSInteger)lastIndexOf:(NSString *)searchstring
{
    
    NSRange start=[self rangeOfString:searchstring options:NSBackwardsSearch];
    if (start.location == NSNotFound)
        return -1;
    else
        return self.length - start.location - searchstring.length;
}

-(NSString *)subString:(NSInteger)start
{
    NSRange srange=NSMakeRange(start,[self length]-start);
    
    return [self substringWithRange:srange];
}

-(NSString *)subString:(NSInteger)start length:(NSInteger)length
{
    NSRange srange=NSMakeRange(start,length);
    
    return [self substringWithRange:srange];
}

-(NSString *)replace:(NSString *)what with:(NSString *)with
{
    return [self stringByReplacingOccurrencesOfString:what withString:with];
}
    
-(NSArray *)split:(NSString *)withwhat
{
    return [self componentsSeparatedByString: withwhat];
}

-(BOOL)startsWith:(NSString*)subString
{
    return [self indexOf:subString]==0;
}

-(BOOL)endsWith:(NSString*)subString
{
    NSInteger idx = [self lastIndexOf:subString];
    return idx==0;
}

@end
