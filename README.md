# solonboot_ios
将客户端的组件功能服务化的一个框架

### solonboot使用说明

###### 1、添加pod

`pod 'solonboot',:git=>"https://github.com/noear/solonboot_ios.git"`

###### 2、主项目启动XApp
`[XApp start:[[XRouterExp alloc] init]];`

###### 3、组件项目进行配配
####### 3.1 配置XMoudle
`
@interface XModule2 : NSObject<XModule>

@end

@implementation XModule2
-(void)start:(XApp*) app{
    [app reg:self expr:@"xapp://module2/xxx" handler:^(XContext * _Nonnull cxt) {
        [cxt output:@"m2"]; //跳转控制器等...业务处理
    }];
}
@end
`
####### 3.2 添加配置文件 solonboot.plist
`solonboot.xmodule = XModule2`

###### 4、主项目引入组xmodule2（内部配置自己完成）
`pod 'xmodule2'`
