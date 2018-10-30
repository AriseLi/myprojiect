//
//  PTShanKaCheckQuestionVC.m
//  PotentialTraining
//
//  Created by admin on 2018/9/4.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTShanKaCheckQuestionVC.h"
#import "PTShanKaResultVC.h"

@interface PTShanKaCheckQuestionVC ()
{
    
    NSMutableArray *dataSourceArray;
    NSInteger trueCount;
}
@property (nonatomic, strong) UILabel *questionLabel;

@property (nonatomic, strong) UILabel *answerAlertLabel;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) NSMutableArray *falseNumDataSource;

@property (nonatomic, assign) BOOL isCurrect;

@end

@implementation PTShanKaCheckQuestionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    trueCount = 0;
    
    NSLog(@"=======%@", self.dataSource);
    
    [self setUpNav];
    [self initDataSource];
    
    [self layoutSubControls];
    
    [self layoutAnswerButtons];
    
    [self loadData];
}

- (void) loadData
{
    
    
    NSDictionary *dic = dataSourceArray[self.questionNumber];
    self.questionLabel.text = [NSString stringWithFormat:@"问题%ld:\n%@", self.questionNumber + 1, dic[@"que1"]];
    
    NSArray *arr1 = dic[@"ans1"];
    for (int i = 0; i < arr1.count; ++i) {
        
        UIButton *button = [self.view viewWithTag:100 + i];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[NSString stringWithFormat:@"%@", arr1[i]] forState:UIControlStateNormal];
    }
    
}

- (void) layoutAnswerButtons
{
    NSDictionary *dic = dataSourceArray[self.questionNumber];
    NSArray *arr1 = dic[@"ans1"];
    CGFloat buttonWidth = kScreenWidth / 3;
    CGFloat buttonHeight = 60;
    for (int i = 0; i < arr1.count; ++i) {
        
        UIButton *answerButton = [UIButton buttonWithType:0];
        answerButton.frame = CGRectMake((kScreenWidth - buttonWidth) / 2, 40 + CGRectGetMaxY(self.answerAlertLabel.frame) + (buttonHeight + 40) * (i % arr1.count), buttonWidth, buttonHeight);
        answerButton.tag = 100 + i;
        answerButton.layer.cornerRadius = 5;
        answerButton.layer.borderWidth = 1;
        answerButton.layer.borderColor = [UIColor blackColor].CGColor;
        [answerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [answerButton addTarget:self action:@selector(answerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:answerButton];
    }
    
    UIView *coverView = [UIView new];
    coverView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //    coverView.backgroundColor = kAlphaColor(289, 89, 89, 0.5);
    coverView.hidden = YES;
    coverView.tag = 80;
    [self.view addSubview:coverView];
    self.coverView = coverView;
    coverView.backgroundColor = kAlphaColor(255, 255, 255, 0);
}
- (void) layoutSubControls
{
    
    UILabel *questionLabel = [UILabel new];
    questionLabel.frame = CGRectMake(20, 80, kScreenWidth - 20, 60);
    questionLabel.font = [UIFont systemFontOfSize:24];
    questionLabel.textColor = [UIColor blackColor];
    questionLabel.numberOfLines = 0;
    questionLabel.text = [NSString stringWithFormat:@"问题%ld:\n\n%@", self.questionNumber, @"问题一"];
    [self.view addSubview:questionLabel];
    self.questionLabel = questionLabel;
    
    UILabel *answerAlertLabel = [UILabel new];
    answerAlertLabel.frame = CGRectMake(CGRectGetMinX(questionLabel.frame), CGRectGetMaxY(questionLabel.frame) + 40, kScreenWidth, 60);
    answerAlertLabel.font = [UIFont systemFontOfSize:24];
    answerAlertLabel.text = @"请选择你认为正确的答案：";
    [self.view addSubview:answerAlertLabel];
    self.answerAlertLabel = answerAlertLabel;
    
}

- (void) answerButtonClick:(UIButton *)button
{
    NSDictionary *dic = dataSourceArray[self.questionNumber];
    NSString *trueAns = dic[@"trueAns"];
    kDLog(@"正确答案是：%@", trueAns);
    kDLog(@"点击的答案是：%@", button.titleLabel.text);
    
    
    
    
    
    
    if ([button.titleLabel.text isEqualToString:trueAns]) {
        button.backgroundColor = [UIColor greenColor];
        trueCount++;
        
        self.isCurrect = YES;
        
    } else {
        
        self.isCurrect = NO;
        
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
        
        for (UIView * view in self.view.subviews) {
            
            if (view.tag >= 100) {
                
                UIButton *btn = (UIButton *)[self.view viewWithTag:view.tag];
                if ([btn.titleLabel.text isEqualToString:trueAns]) {
                    
                    btn.backgroundColor = [UIColor greenColor];
                }
            }
        }
    }
    
    
    if (self.questionNumber == dataSourceArray.count - 1) {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            PTShanKaResultVC *readCheckResultVC = [PTShanKaResultVC new];
            readCheckResultVC.isCurrect = self.isCurrect ;
            [self.navigationController pushViewController:readCheckResultVC animated:YES];
        });
    } else {
        
        self.coverView.hidden = NO;
        self.questionNumber++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.coverView.hidden = YES;
            
            for (UIView *view in self.view.subviews) {
                
                if (view.tag >= 100) {
                    
                    [view removeFromSuperview];
                }
            }
            
            [self.coverView removeFromSuperview];
            
            [self layoutAnswerButtons];
            [self loadData];
        });
    }
}

- (void) initDataSource
{
    
    self.falseNumDataSource = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 2; i++) {
        NSInteger randomNumber = pow(10, self.numberLenght);
        [self.falseNumDataSource addObject:[NSString stringWithFormat:@"%ld", arc4random() % randomNumber]];
    }
    [self.falseNumDataSource addObject:@"无"];
    
    NSString *numberStr;
    
    if ((arc4random() % 2 + 1) % 2 == 0) {
        NSLog(@"随机取一个正确的插进去");
        NSInteger index = arc4random() % (self.dataSource.count);
        
        numberStr = [NSString stringWithFormat:@"%@", self.dataSource[index]];
        [self.falseNumDataSource insertObject:numberStr atIndex:arc4random() % 3];
    } else {
        NSLog(@"随机生成一个不一样的插进去");
        NSInteger randomNumber2 = pow(10, self.numberLenght);

        [self.falseNumDataSource insertObject:[NSString stringWithFormat:@"%ld", arc4random() % randomNumber2] atIndex:arc4random() % 3];
    }
    
    NSLog(@"+++++++++%@", self.falseNumDataSource);
    
    
    BOOL isHadTrueNum = NO;
    
    
    for (NSInteger i = 0; i < self.falseNumDataSource.count - 1; i++) {
        NSString *falseNumStr = [NSString stringWithFormat:@"%@", self.falseNumDataSource[i]];
        for (NSInteger j = 0; j < self.dataSource.count; j++) {
            NSString *correctNumStr = [NSString stringWithFormat:@"%@", self.dataSource[j]];
            if ([falseNumStr isEqualToString:correctNumStr]) {
                isHadTrueNum = YES;
                break;
            }
        }
    }
    
    
    NSArray *qaArr1 = @[
                        @{@"que1" :@"刚才哪个数字出现过？", @"ans1" :self.falseNumDataSource, @"trueAns" : isHadTrueNum == YES?[NSString stringWithFormat:@"%@", numberStr]:@"无"}
                        ];
    dataSourceArray = [NSMutableArray arrayWithArray:qaArr1];
    
    
    NSLog(@"*********%@", dataSourceArray);
}

- (void) setUpNav
{
    
    self.title = @"问题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];

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
