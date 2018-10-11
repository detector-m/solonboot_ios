//
//  XUtil.h
//  solonboot
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 内部用工具 */
@interface XUtil : NSObject
/** 生成UGID */
+(NSString*)guid;
/** 检查字符串是否为空 */
+(BOOL)isEmpty:(nullable NSString*)str;
/** 根据字符串生成一个类 */
+(id)newClass:(NSString*)str;
@end



/** 扩展NSString的接口，与Java的基础接口打平 */
@interface NSString (solon)
-(NSInteger)indexOf:(NSString *)searchstring;
-(NSInteger)lastIndexOf:(NSString *)searchstring;

-(NSString*)subString:(NSInteger)start;
-(NSString*)subString:(NSInteger)start length:(NSInteger)length;

-(NSString*)replace:(NSString *)what with:(NSString *)with;

-(NSArray*)split:(NSString *)withwhat;
    
-(BOOL)startsWith:(NSString*)subString;
-(BOOL)endsWith:(NSString*)subString;
@end

NS_ASSUME_NONNULL_END
