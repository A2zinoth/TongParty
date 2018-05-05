//
//  AppDelegate.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


#import "AppDelegate.h"
#import "AppDelegate+AppRootVC.h"
#import "AppDelegate+AppService.h"
#import "DDTJShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "AppDelegate+AppLocation.h"
#import "ZLLAuthorizationCheckTool.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    kWeakSelf
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = kWhiteColor;
    
    // UMeng
    [UMConfigure setLogEnabled:true];
    [MobClick setCrashReportEnabled:YES];
    [UMConfigure initWithAppkey:UmengAppKey channel:@"App Store"];
    [[DDTJShareManager sharedManager] registerAllPlatForms];
    
    // JPush
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:@"App Store"
                 apsForProduction:false
            advertisingIdentifier:@""];
    [self registerJPush];
    
    // Amap
    [self registerAmap];
    [ZLLAuthorizationCheckTool availableAccessForLocationServices:self.window.rootViewController jumpSettering:true alertNotAvailable:false resultBlock:^(BOOL isAvailable, ZLLAuthorizationStatus status) {
        if (isAvailable) {
            [weakSelf startLocation];
        }
    }];
    
    
    if (@available(ios 9.0, *)) {
        [self initShortcutItems];
    }
    
    [self setTabbar];
    
    // 加载用户信息
    [userManager loadUserInfo];
    
    [DDUserDefault removeObjectForKey:@"isFirstOpen"];
    
    if (![DDUserDefault objectForKey:@"isFirstLogin"]) {
        [self isAppFirstOpen];
    } else {
        [self setTabbar];
    }
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = false;//控制点击背景是否收起键盘
    //控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条。
    manager.enableAutoToolbar = false;

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken:%@", [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS 7 available Receive Remote Notification");
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"iOS10 Deprecated Receive Remote Notification");
    [JPUSHService handleRemoteNotification:userInfo];
}

-(void)setTabbar{
    _tabbar = [[DDTabbarViewController alloc]init];
    self.window.rootViewController = _tabbar;
    [self.window makeKeyAndVisible];
   
}



- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [UMSocialSnsService  applicationDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    //这里可以获的shortcutItem对象的唯一标识符
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
    
}

- (void)initShortcutItems {
    
    if ([UIApplication sharedApplication].shortcutItems.count >= 4)
        return;
    
    NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    
    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.guolu.tongParty.openSearch" localizedTitle:@"搜索" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [arrShortcutItem addObject:shoreItem1];
    
    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.guolu.tongParty.openCompose" localizedTitle:@"新消息" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    [arrShortcutItem addObject:shoreItem2];
    
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
    
    NSLog(@"%lu", [UIApplication sharedApplication].shortcutItems.count);
}

@end








