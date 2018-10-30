//
//  PTCheckVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTCheckVC.h"
#import "PTReadCheckVC.h"
#import "PTShanKaCheckVC.h"
#import "PTSchulteCheckVC.h"

@interface PTCheckVC ()

{
    
    NSArray *titleArray;
    
}

@end

@implementation PTCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self layoutCheckItems];
    // Do any additional setup after loading the view.
}

- (void) layoutCheckItems
{
    
    CGFloat margin = 20;
    CGFloat buttonWidth = (kScreenWidth - margin * 8) / 4;
    CGFloat buttonHeight = buttonWidth;
    
    NSInteger buttonNumber = titleArray.count;
    for (NSInteger i = 0; i < buttonNumber; ++i) {
        
        UIButton *checkButton = [UIButton buttonWithType:0];
        checkButton.frame = CGRectMake(margin + (buttonWidth + margin * 2) * (i % 4), margin + (buttonHeight + margin) * (i / 4), buttonWidth, buttonHeight);
        checkButton.layer.cornerRadius = 5;
        checkButton.clipsToBounds = YES;
        checkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3"]];
        [checkButton setTitle:titleArray[i] forState:UIControlStateNormal];
        checkButton.titleLabel.font = [UIFont systemFontOfSize:24];
        checkButton.tag = 100 + i;
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:checkButton];
    }
}

- (void) checkButtonClick:(UIButton *)button
{
    
    switch (button.tag - 100) {
        case 0:
            //阅读
        {
            
            PTReadCheckVC *readVC = [PTReadCheckVC new];
            [self.navigationController pushViewController:readVC animated:YES];
        }
            
            
            break;
        case 1:
            //闪卡
        {
            
            PTShanKaCheckVC *shanKaVC = [PTShanKaCheckVC new];
            [self.navigationController pushViewController:shanKaVC animated:YES];
        }
            break;
        case 2:
            //舒尔特表
        {
            
            PTSchulteCheckVC *schulteVC = [PTSchulteCheckVC new];
            [self.navigationController pushViewController:schulteVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void) initDataSource
{
    
    titleArray = @[@"阅读测试", @"闪卡测试", @"舒尔特表测试"];
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
