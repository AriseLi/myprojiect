//
//  PTNav.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTNav.h"

@interface PTNav ()

@end

@implementation PTNav

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarTintColor:kAlphaColor(244, 244, 244, 0.8)];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"fanhui" highImageName:@"fanhui" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
