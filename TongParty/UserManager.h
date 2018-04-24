//
//  UserManager.h
//  MiAiApp
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUserSingleton.h"
#import <YYCache/YYCache.h>

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeAccount = 0,  //账号
    kUserLoginTypeWeChat,       //微信登录
    kUserLoginTypeQQ,           //QQ登录
    kUserLoginTypeWeibo,        //微博登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);

#define bLogined [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
//登录状态改变通知
#define KNotificationLoginStateChange      @"loginStateChange"
//自动登录成功
#define KNotificationAutoLoginSuccess      @"KNotificationAutoLoginSuccess"
//被踢下线
#define KNotificationOnKick                @"KNotificationOnKick"
//用户信息缓存 名称
#define KUserCacheName                     @"KUserCacheName"
//用户model缓存
#define KUserModelCache                    @"KUserModelCache"

@interface UserManager : NSObject

@property (nonatomic, strong) DDUserSingleton   *curUserInfo; //当前用户
@property (nonatomic, assign) UserLoginType     loginType;
@property (nonatomic, assign) BOOL              isLogined;

+ (instancetype)sharedUserManager;

#pragma mark - ——————— 登录相关 ————————

/**
 三方登录

 @param loginType 登录方式
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion;

/**
 带参登录

 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录

 @param completion 回调
 */
- (void)autoLoginToServer:(loginBlock)completion;
//- (void)autoLoginToServerWithDic:(NSDictionary *)dic completion:(loginBlock)completion;
/**
 退出登录

 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据

 @return 是否成功
 */
-(BOOL)loadUserInfo;

@end
