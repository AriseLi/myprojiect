//
//  PTSchulteCheckVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTSchulteCheckVC.h"
#import "PTSchulteVC.h"

@interface PTSchulteCheckVC ()

@end

@implementation PTSchulteCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self layoutCheckItems];
    // Do any additional setup after loading the view.
}

- (void) layoutCheckItems
{
    
    UIButton *numberButton = [UIButton buttonWithType:0];
    numberButton.frame = CGRectMake((kScreenWidth - kScreenWidth / 3) / 2, 220, kScreenWidth / 3, 60);
    numberButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [numberButton setTitle:@"数字" forState:UIControlStateNormal];
    numberButton.titleLabel.textColor = [UIColor blackColor];
    numberButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [numberButton addTarget:self action:@selector(pushSchulteVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numberButton];
    
    UIButton *characterButton = [UIButton buttonWithType:0];
    characterButton.frame = CGRectMake((kScreenWidth - kScreenWidth / 3) / 2, CGRectGetMaxY(numberButton.frame) + 20, CGRectGetWidth(numberButton.frame), CGRectGetHeight(numberButton.frame));
    characterButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [characterButton setTitle:@"字母" forState:UIControlStateNormal];
    characterButton.titleLabel.textColor = [UIColor blackColor];
    characterButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [characterButton addTarget:self action:@selector(pushSchulteVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:characterButton];
    
    
    
   
}

- (void) pushSchulteVC:(UIButton *)button
{
    
    PTSchulteVC *schulteVC = [PTSchulteVC new];
    
    if ([button.titleLabel.text isEqualToString:@"数字"]) {
        
        schulteVC.schulteType = @"number";
    } else {
        
        schulteVC.schulteType = @"character";
    }
    [self.navigationController pushViewController:schulteVC animated:YES];
}
- (void) setUpNav
{
    
    self.title = @"舒尔特表测试";
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
