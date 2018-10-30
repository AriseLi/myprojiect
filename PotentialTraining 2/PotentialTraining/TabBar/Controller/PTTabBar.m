//
//  PTTabBar.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTTabBar.h"
#import "PTLoginVC.h"

@interface PTTabBar ()<UITabBarControllerDelegate>

@property (nonatomic, strong) PTTrainVC *train;
@property (nonatomic, strong) PTCheckVC *check;
@property (nonatomic, strong) PTLearnVC *learn;
@property (nonatomic, strong) PTTaskVC *task;
@property (nonatomic, strong) PTMineVC *mine;

@end

@implementation PTTabBar


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self setUpChildVC];
    // Do any additional setup after loading the view.
}

- (void) setUpChildVC
{
    
    PTTrainVC *train = [PTTrainVC new];
    train.view.backgroundColor = [UIColor whiteColor];
    train.tabBarItem.tag = 0;
    [self setUpVC:train withImage:[UIImage imageNamed:@"jcxl_wxz"] andSelectedImage:[UIImage imageNamed:@"jcxl_xz"] andTitle:@"基础训练"];
    self.train = train;
    
    PTCheckVC *check = [PTCheckVC new];
    check.view.backgroundColor = [UIColor whiteColor];
    check.tabBarItem.tag = 1;
    [self setUpVC:check withImage:[UIImage imageNamed:@"cgjc_wxz"] andSelectedImage:[UIImage imageNamed:@"cgjc_xz"] andTitle:@"成果检测"];
    self.check = check;
    
    PTLearnVC *learn = [PTLearnVC new];
    learn.view.backgroundColor = [UIColor whiteColor];
    learn.tabBarItem.tag = 2;
    [self setUpVC:learn withImage:[UIImage imageNamed:@"xxzs_wxz"] andSelectedImage:[UIImage imageNamed:@"xxzs_xz"] andTitle:@"学习知识"];
    self.learn = learn;
    
    PTTaskVC *task = [PTTaskVC new];
    task.view.backgroundColor = [UIColor whiteColor];
    task.tabBarItem.tag = 3;
    [self setUpVC:task withImage:[UIImage imageNamed:@"mrrw_wxz"] andSelectedImage:[UIImage imageNamed:@"mrrw_xz"] andTitle:@"每日任务"];
    self.task = task;
    
    PTMineVC *mine = [PTMineVC new];
    mine.view.backgroundColor = [UIColor whiteColor];
    mine.tabBarItem.tag = 4;
    [self setUpVC:mine withImage:[UIImage imageNamed:@"grzx_wxz"] andSelectedImage:[UIImage imageNamed:@"grzx_xz"] andTitle:@"个人中心"];
    self.mine = mine;
    
    self.selectedIndex = 0;
}

- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{

//    PTNav *nav = (PTNav *) viewController;
//
//    if ([[nav.viewControllers objectAtIndex:0] isKindOfClass:[PTMineVC class]]) {
//
//        if (![[NSFileManager defaultManager] fileExistsAtPath:kUserFilePath]) {
//
//            PTLoginVC *vc = [PTLoginVC new];
//            PTNav *nav = [[PTNav alloc] initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:^{
//
//            }];
//            return NO;
//        }else{
//
//            return YES;
//        }
//
//    } else {
//
//        return YES;
//    }
    return YES;
}

- (void) setUpVC:(UIViewController *)aViewController withImage:(UIImage *)anImage andSelectedImage:(UIImage *)aSelectedImage andTitle:(NSString *)aTitle
{
    
    aViewController.tabBarItem.image = anImage;
    aViewController.tabBarItem.selectedImage = aSelectedImage;
    aViewController.tabBarItem.title = aTitle;
    aViewController.title = aTitle;
    
    
    PTNav *nav = [[PTNav alloc] initWithRootViewController:aViewController];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
