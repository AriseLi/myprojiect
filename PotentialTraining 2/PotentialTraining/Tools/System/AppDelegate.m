//
//  AppDelegate.m
//  PotentialTraining
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (nonatomic, strong) PTTabBar *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self enter];
    
    [self loadData];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void) loadData
{
    
//        //1.来自哪
//        NSString *channel = @"ios";
    
        //2.版本是
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    //3.是否计数
    NSString *ifCount;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kIfFirstInstall]) {
        
        ifCount = @"0";
        
    } else {
        
        ifCount = @"1";
    }
    
    
    //初始化接口
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@version/%@", INIT, currentVersion]];
    
    kDLog(@"初始化接口的url是：%@", url);
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];//默认为get请求
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (received != nil) {
        
        id responseBody = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        kDLog(@"初始化接口返回的数据是:%@", responseBody);
        
        NSString *code = responseBody[@"code"];
        
        if ([code isEqualToString:@"11"]) {
            kDLog(@"初始化接口有请求成功，code是11");
            NSDictionary *mainDataDict = responseBody[@"data"];
            
            NSString *baseUrlString = mainDataDict[@"base_url"];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:baseUrlString forKey:@"base"];
            
            //把baseUrl存到本地
            [dic writeToFile:kIfFirstInstall atomically:YES];
            
            [self initTabbarAndCurrentVersion];
            
            
        }else{
            kDLog(@"初始化接口有请求失败，code不是11");
            [self initTabbarAndCurrentVersion];
        }
        
    }else{
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:kIfFirstInstall]) {
            
            kDLog(@"初始化接口出问题了,但是之前已经运行过，有baseUrl了");
            
            [self initTabbarAndCurrentVersion];
        } else {
            
            kDLog(@"初始化接口出问题了,碰巧是还是第一次运行,没有baseUrl");
            
        }
    }
}


- (void) initTabbarAndCurrentVersion
{
    
    VersionManager *manager = [VersionManager shareManager];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kIfFirstInstall];
    
    NSString *baseUrlString = dic[@"base"];
    
    manager.currentVersion = baseUrlString;
    
    self.tabBarController = [[PTTabBar alloc] init];
    
    self.window.rootViewController = self.tabBarController;
    
//    self.window.backgroundColor = kColor(32, 32, 32);
}

- (void) enter
{
    
    PTTabBar *tabBar = [PTTabBar new];
    tabBar.tabBar.translucent = NO;
    self.window.rootViewController = tabBar;
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
}


@end
