//
//  TabBarBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TabBarBaseController.h"
#import "NavigationBaseController.h"
#import "QHTabBar.h"
#import "PromptView.h"
#import "FarmViewController.h"
#import "ServiceViewController.h"
#import "GroupViewController.h"
#import "SelfViewController.h"

@interface TabBarBaseController ()
@property(nonatomic,assign)int oldIndex;
@end

@implementation TabBarBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self setValue:[[QHTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSDictionary *attrs =@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};

    
    NSDictionary *selectedAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    /*
     * 添加子导航栏控制器
     */
    [self setupChildVc:[[FarmViewController alloc] init] title:@"首页" image:@"TabBar_Home_Normal" selectedImage:@"TabBar_Home_Selected"];

//    [self setupChildVc:[[ServiceViewController alloc] init] title:@"记录" image:@"TabBar_Record_Normal" selectedImage:@"TabBar_Record_Selected"];
    
    [self setupChildVc:[[GroupViewController alloc] init] title:@"圈子" image:@"TabBar_Store_Normal" selectedImage:@"TabBar_Store_Selected"];

    [self setupChildVc:[[SelfViewController alloc] init] title:@"我" image:@"TabBar_Mine_Normal" selectedImage:@"TabBar_Mine_Selected"];

    self.tabBar.barTintColor = RGB(255, 218, 68);
    self.tabBar.backgroundColor = RGB(255, 218, 68);
//    [self addNotification];
}

- (UINavigationController *)yq_navigationController {
    return self.selectedViewController;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NavigationBaseController *nav = [[NavigationBaseController alloc] initWithRootViewController:vc];
    
    [nav.navigationBar setBackgroundColor:RGB(38, 74, 254)];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                }];
    [self addChildViewController:nav];
}
   
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
}



- (NavigationBaseController *)getCurrentVC {
    NavigationBaseController *nav ;
    int index = (int)self.selectedIndex;
    nav = self.childViewControllers[index]; 
    return nav;
}


@end
