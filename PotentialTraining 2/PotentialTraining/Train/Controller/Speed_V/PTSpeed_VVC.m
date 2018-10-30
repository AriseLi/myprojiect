//
//  PTSpeed_VVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTSpeed_VVC.h"
#import "PTSpeed_VDetailVC.h"

@interface PTSpeed_VVC ()
{
    
    NSInteger difficult_speed;
}

@property (nonatomic, strong) UIView *bgView;

@end

@implementation PTSpeed_VVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    [self initData];
    [self layoutSubControls];
    [self layoutDifficultView];
}

- (void) layoutDifficultView
{
    CGFloat bgViewWidth = 800;
    CGFloat bgViewHeight = 350;
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake((kScreenWidth - bgViewWidth) / 2, 200, bgViewWidth, bgViewHeight);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor blackColor].CGColor;
    bgView.layer.borderWidth = 0.5;
    bgView.hidden = YES;
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    UILabel *speedLabel = [UILabel new];
    speedLabel.frame = CGRectMake(50, 100, 100, 60);
    speedLabel.text = @"速度：";
    speedLabel.font = [UIFont systemFontOfSize:24];
    speedLabel.textColor = [UIColor blackColor];
    [bgView addSubview:speedLabel];
    speedLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    
    CGFloat buttonWidth = self.bgView.frame.size.width / 3;
    CGFloat buttonHeight = 60;
    
    UIButton *cancelButton = [UIButton buttonWithType:0];
    cancelButton.frame = CGRectMake(buttonWidth / 3, CGRectGetMaxY(speedLabel.frame) + 100, buttonWidth, buttonHeight);
    cancelButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.textColor = [UIColor blackColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:0];
    confirmButton.frame = CGRectMake(CGRectGetMaxX(cancelButton.frame) + buttonWidth / 3, CGRectGetMinY(cancelButton.frame), buttonWidth, buttonHeight);
    confirmButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.textColor = [UIColor blackColor];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:confirmButton];
    
    CGFloat lengthButtonWidth = 100;
    CGFloat lengthButtonHeight = 60;
    
    
    NSArray *speedButtonTitleArr = @[@"120/分钟", @"150/分钟", @"180/分钟", @"200/分钟"];
    for (int i = 0; i < speedButtonTitleArr.count; i++) {
        
        UIButton *speedButton = [UIButton buttonWithType:0];
        speedButton.frame = CGRectMake(CGRectGetMaxX(speedLabel.frame) + 20 + (lengthButtonWidth + 20) * i, CGRectGetMinY(speedLabel.frame), lengthButtonWidth, lengthButtonHeight);
        [speedButton setTitle:speedButtonTitleArr[i] forState:UIControlStateNormal];
        speedButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [speedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [speedButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        speedButton.layer.borderWidth = 0.5;
        speedButton.layer.borderColor = [UIColor blackColor].CGColor;
        speedButton.tag = 200 + i;
        if (speedButton.tag == 200) {
            speedButton.selected = YES;
        }
        [speedButton addTarget:self action:@selector(speedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:speedButton];
    }
}
- (void) speedButtonClick:(UIButton *)button
{
    
    for (UIButton *speedButton in self.bgView.subviews) {
        
        if (speedButton.tag >= 200) {
            
            speedButton.selected = NO;
        }
    }
    
    button.selected = YES;
    switch (button.tag) {
        case 200:
            difficult_speed = 1;
            break;
        case 201:
            difficult_speed = 1;
            break;
            
        case 202:
            difficult_speed = 1;
            break;
            
        case 203:
            difficult_speed = 1;
            break;
        default:
            break;
    }
}

- (void) confirmButtonClick:(UIButton *)button
{
    
    self.bgView.hidden = YES;
}

- (void) cancelButtonClick
{
    
    self.bgView.hidden = YES;
}
- (void) layoutSubControls
{
    
    CGFloat imageViewWidth = 400;
    CGFloat imageViewHeight = imageViewWidth;
    UIImageView *imageView = [UIImageView new];
    imageView.frame =CGRectMake((kScreenWidth - imageViewWidth) / 2, (kScreenHeight - imageViewHeight - 64) / 2, imageViewWidth, imageViewHeight);
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    CGFloat buttonWidth = kScreenWidth / 3;
    CGFloat buttonHeight = 60;
    UIButton *difficultButton = [UIButton buttonWithType:0];
    difficultButton.frame = CGRectMake(20, kScreenHeight - buttonHeight - 20 - 64, buttonWidth, buttonHeight);
    difficultButton.backgroundColor = [UIColor redColor];
    [difficultButton setTitle:@"设置难度" forState:UIControlStateNormal];
    difficultButton.titleLabel.textColor = [UIColor blackColor];
    difficultButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [difficultButton addTarget:self action:@selector(difficultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:difficultButton];
    
    UIButton *prepareToTrainButton = [UIButton buttonWithType:0];
    prepareToTrainButton.frame = CGRectMake(kScreenWidth - buttonWidth - 20, CGRectGetMinY(difficultButton.frame), buttonWidth, buttonHeight);
    prepareToTrainButton.backgroundColor = [UIColor redColor];
    [prepareToTrainButton setTitle:@"开始训练" forState:UIControlStateNormal];
    prepareToTrainButton.titleLabel.textColor = [UIColor blackColor];
    prepareToTrainButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [prepareToTrainButton addTarget:self action:@selector(prepareToTrainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prepareToTrainButton];
}
- (void) prepareToTrainButtonClick:(UIButton *)button
{
    
    PTSpeed_VDetailVC *speed_VDetailVC = [PTSpeed_VDetailVC new];
    speed_VDetailVC.speed = difficult_speed;
    [self.navigationController pushViewController:speed_VDetailVC animated:YES];
}
- (void) difficultButtonClick:(UIButton *)button
{
    
    self.bgView.hidden = !self.bgView.hidden;
}
- (void) initData
{
    difficult_speed = 1;
}

- (void) setUpNav
{
    
    self.title = @"视速训练-竖";
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
