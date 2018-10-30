//
//  PTReadCheckResultVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTReadCheckResultVC.h"

@interface PTReadCheckResultVC ()

@end

@implementation PTReadCheckResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self layoutSubControls];
    
    
}

- (void) layoutSubControls
{
    
    UILabel *resultLabel = [UILabel new];
    resultLabel.frame = CGRectMake(100, 100, 400, 100);
    resultLabel.font = [UIFont systemFontOfSize:24];
    resultLabel.text = [NSString stringWithFormat:@"正确率：%.0f%@", self.accuracy, @"%"];
    resultLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [self.view addSubview:resultLabel];
    
    UIButton *endButton = [UIButton buttonWithType:0];
    endButton.frame = CGRectMake(100, 300, 400, 100);
    [endButton setTitle:@"结束" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(endButtonClick) forControlEvents:UIControlEventTouchUpInside];
    endButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [self.view addSubview:endButton];
}
- (void) endButtonClick
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) setUpNav
{
    
    self.title = @"结果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *endButton = [UIButton buttonWithType:0];
    endButton.frame = CGRectMake(0, 0, 40, 10);
    [endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [endButton setTitle:@"返回" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(endButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    endButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
//    [self.view addSubview:endButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:endButton];
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
