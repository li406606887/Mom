//
//  AppDelegate.m
//  FamilyFarm
//
//  Created by user on 2017/10/17.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.frame = [UIScreen mainScreen].bounds;
    if ([UserInformation getInformation].loginModel.token.length<10) {
        self.window.rootViewController = self.navgitonController;
    } else {
        self.window.rootViewController = self.main;
    }
    [WXApi registerApp:@"wx681ba63c19d5ed89"];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    return  [WXApi handleOpenURL:url delegate:self];
//}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        switch (response.errCode){
            case WXSuccess: {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:nil];
//                NSlog(@"支付成功");
            }
                break;
            default:
//                NSlog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == 0) {
            SendAuthResp *sendResp = (SendAuthResp *)resp;
            NSDictionary *param = @{@"type":@"3",@"wxcode":sendResp.code};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChatLogin" object:param];
        }
    }
}


-(TabBarBaseController *)main {
    if (!_main) {
        _main = [[TabBarBaseController alloc] init];
        @weakify(self)
        _main.outLoginBlock = ^{
            @strongify(self)
            self.window.rootViewController = self.navgitonController;
            self.main = nil;
        };
    }
    return _main;
}

- (UINavigationController *)navgitonController {
    if (!_navgitonController) {
        _login = [[LoginViewController alloc] init];
        _navgitonController = [[UINavigationController alloc] initWithRootViewController:_login];
        @weakify(self)
        _login.releaseBlock = ^{
            @strongify(self)
            self.window.rootViewController = self.main;
            self.navgitonController = nil;
            _login = nil;
        };
    }
    return _navgitonController;
}

@end
