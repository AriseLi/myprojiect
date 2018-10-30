//
//  PTTaskVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTTaskVC.h"
#import "PTTaskListVC.h"

@interface PTTaskVC ()

{
    
    NSArray *titleArray;
    
}

@end

@implementation PTTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataSource];
    [self layoutCheckItems];
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
        checkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
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
            //任务
        {
            
            PTTaskListVC *taskListVC = [PTTaskListVC new];
            [self.navigationController pushViewController:taskListVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

- (void) initDataSource
{
    
    titleArray = @[@"赚积分"];
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
