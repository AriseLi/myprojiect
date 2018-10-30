//
//  PTShanKaVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTShanKaVC.h"
#import "PTShanKaDetailVC.h"

@interface PTShanKaVC ()

{
    
    NSInteger difficult_length;
    NSInteger difficult_speed;
}
@property (nonatomic, strong) UIView *bgView;

@end

@implementation PTShanKaVC

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
    CGFloat bgViewWidth = 600;
    CGFloat bgViewHeight = 350;
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake((kScreenWidth - bgViewWidth) / 2, 200, bgViewWidth, bgViewHeight);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor blackColor].CGColor;
    bgView.layer.borderWidth = 0.5;
    bgView.hidden = YES;
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    UILabel *lengthLabel = [UILabel new];
    lengthLabel.frame = CGRectMake(50, 50, 100, 60);
    lengthLabel.text = @"长度：";
    lengthLabel.font = [UIFont systemFontOfSize:24];
    lengthLabel.textColor = [UIColor blackColor];
    [bgView addSubview:lengthLabel];
    lengthLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    
    UILabel *speedLabel = [UILabel new];
    speedLabel.frame = CGRectMake(CGRectGetMinX(lengthLabel.frame), CGRectGetMaxY(lengthLabel.frame) + 50, CGRectGetWidth(lengthLabel.frame), CGRectGetHeight(lengthLabel.frame));
    speedLabel.text = @"速度：";
    speedLabel.font = lengthLabel.font;
    speedLabel.textColor = lengthLabel.textColor;
    [bgView addSubview:speedLabel];
    speedLabel.backgroundColor = lengthLabel.backgroundColor;
    
    CGFloat buttonWidth = self.bgView.frame.size.width / 3;
    CGFloat buttonHeight = 60;
    
    UIButton *cancelButton = [UIButton buttonWithType:0];
    cancelButton.frame = CGRectMake(buttonWidth / 3, CGRectGetMaxY(speedLabel.frame) + 50, buttonWidth, buttonHeight);
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
    
    CGFloat lengthButtonWidth = 60;
    CGFloat lengthButtonHeight = lengthButtonWidth;
    NSArray *lengthButtonTitleArr = @[@"6", @"7", @"8", @"9", @"10"];
    for (int i = 0; i < lengthButtonTitleArr.count; i++) {
        
        UIButton *lengthButton = [UIButton buttonWithType:0];
        lengthButton.frame = CGRectMake(CGRectGetMaxX(lengthLabel.frame) + 20 + (lengthButtonWidth + 20) * i, CGRectGetMinY(lengthLabel.frame), lengthButtonWidth, lengthButtonHeight);
        [lengthButton setTitle:lengthButtonTitleArr[i] forState:UIControlStateNormal];
        lengthButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [lengthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lengthButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        lengthButton.layer.borderWidth = 0.5;
        lengthButton.layer.borderColor = [UIColor blackColor].CGColor;
        lengthButton.tag = 100 + i;
        if (lengthButton.tag == 100) {
            
            lengthButton.selected = YES;
        }
        [lengthButton addTarget:self action:@selector(lengthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:lengthButton];
    }
    
//    CGFloat speedButtonWidth = 100;
//    CGFloat speedButtonHeight = lengthButtonHeight;
    NSArray *speedButtonTitleArr = @[@"1秒", @"½秒", @"⅓秒"];
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
        default:
            break;
    }
}
- (void) lengthButtonClick:(UIButton *)button
{
    
    for (UIButton *lengthButton in self.bgView.subviews) {
        
        if (lengthButton.tag >= 100 && lengthButton.tag <200) {
            
            lengthButton.selected = NO;
        }
    }
    
    button.selected = YES;
    difficult_length = [button.titleLabel.text integerValue];
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
    
    CGFloat buttonWidth = kScreenWidth / 3;
    CGFloat buttonHeight = 60;
    
    UIButton *numberButton = [UIButton buttonWithType:0];
    numberButton.frame = CGRectMake((kScreenWidth - kScreenWidth / 3) / 2, 220, buttonWidth, buttonHeight);
    numberButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [numberButton setTitle:@"数字" forState:UIControlStateNormal];
    numberButton.titleLabel.textColor = [UIColor blackColor];
    numberButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [numberButton addTarget:self action:@selector(pushShanKaVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numberButton];
    
    UIButton *characterButton = [UIButton buttonWithType:0];
    characterButton.frame = CGRectMake((kScreenWidth - kScreenWidth / 3) / 2, CGRectGetMaxY(numberButton.frame) + 20, buttonWidth, buttonHeight);
    characterButton.backgroundColor = [UIColor redColor];
    [characterButton setTitle:@"字母" forState:UIControlStateNormal];
    characterButton.titleLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    characterButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [characterButton addTarget:self action:@selector(pushShanKaVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:characterButton];
    
    UIButton *difficultButton = [UIButton buttonWithType:0];
    difficultButton.frame = CGRectMake(20, kScreenHeight - buttonHeight - 20 - 64, buttonWidth, buttonHeight);
    difficultButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [difficultButton setTitle:@"设置难度" forState:UIControlStateNormal];
    difficultButton.titleLabel.textColor = [UIColor blackColor];
    difficultButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [difficultButton addTarget:self action:@selector(difficultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:difficultButton];
    
    UIButton *prepareToTrainButton = [UIButton buttonWithType:0];
    prepareToTrainButton.frame = CGRectMake(kScreenWidth - buttonWidth - 20, CGRectGetMinY(difficultButton.frame), buttonWidth, buttonHeight);
    prepareToTrainButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [prepareToTrainButton setTitle:@"开始训练" forState:UIControlStateNormal];
    prepareToTrainButton.titleLabel.textColor = [UIColor blackColor];
    prepareToTrainButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [prepareToTrainButton addTarget:self action:@selector(prepareToTrainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:prepareToTrainButton];
}
//- (void) prepareToTrainButtonClick:(UIButton *)button
//{
//
//    PTShanKaDetailVC *shanKaDetailVC = [PTShanKaDetailVC new];
//    shanKaDetailVC.length = difficult_length;
//    shanKaDetailVC.speed = difficult_speed;
//    [self.navigationController pushViewController:shanKaDetailVC animated:YES];
//}
- (void) difficultButtonClick:(UIButton *)button
{
    
    self.bgView.hidden = !self.bgView.hidden;
}

- (void) pushShanKaVC:(UIButton *)button
{
    
    PTShanKaDetailVC *shanKaDetailVC = [PTShanKaDetailVC new];
    shanKaDetailVC.shanKaType = button.titleLabel.text;
    shanKaDetailVC.length = difficult_length;
    shanKaDetailVC.speed = difficult_speed;
    [self.navigationController pushViewController:shanKaDetailVC animated:YES];
}
- (void) initData
{
    
    difficult_length = 6;
    difficult_speed = 1;
}
- (void) setUpNav
{
    
    self.title = @"闪卡训练";
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
