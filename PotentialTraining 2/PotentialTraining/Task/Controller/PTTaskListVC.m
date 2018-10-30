//
//  PTTaskListVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTTaskListVC.h"

@interface PTTaskListVC ()

@end

@implementation PTTaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
}

- (void) setUpNav
{
    
    self.title = @"任务列表";
    self.view.backgroundColor = [UIColor whiteColor];
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
