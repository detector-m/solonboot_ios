# solonboot_ios
将客户端的组件功能服务化的一个框架

### solonboot使用说明

###### 1、相关项目添加引用

`pod 'solonboot',:git=>"https://github.com/noear/solonboot_ios.git"`

###### 2、主项目启动服务
`[XApp start:[[XRouterExp alloc] init]];`

###### 3、组件项目进行配配
####### 3.1 配置XMoudle
```oc
XModule2.h
@interface XModule2 : NSObject<XModule>

@end

XModule2.m
@implementation XModule2
-(void)start:(XApp*) app{
    [app reg:self expr:@"xapp://module2/xxx" handler:^(XContext * _Nonnull cxt) {
        [cxt output:@"m2"]; //跳转控制器等...业务处理
    }];
}
@end
```
####### 3.2 添加配置文件 solonboot.plist
`solonboot.xmodule = XModule2`

###### 4、主项目引入组xmodule2（内部配置自己完成）
`pod 'xmodule2'`

###### 5 服务调用
####### 5.1 本地代码调用
```oc
[XClient call:self url:@"xapp://module2/xxx?id=1" params:nil];
```
####### 5.2 内嵌WEB调用（需要适配一下WebView）
```html
<a href="xapp://module2/xxx?id=1">xxx</a>
```
