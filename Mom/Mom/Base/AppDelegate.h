//
//  AppDelegate.h
//  FamilyFarm
//
//  Created by user on 2017/10/17.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarBaseController.h"
#import "LoginViewController.h"
#import "GuidViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) TabBarBaseController *main;

@property (strong, nonatomic) UINavigationController *navgitonController;

@property (copy, nonatomic) LoginViewController *login;

@end

