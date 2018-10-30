//
//  PTReadCheckQuestionVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTReadCheckQuestionVC.h"
#import "PTReadCheckResultVC.h"

@interface PTReadCheckQuestionVC ()

{
    
    NSMutableArray *dataSourceArray;
    NSInteger trueCount;
}
@property (nonatomic, strong) UILabel *questionLabel;

@property (nonatomic, strong) UILabel *answerAlertLabel;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation PTReadCheckQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    trueCount = 0;
    
    [self setUpNav];
    [self initDataSource];
    [self layoutSubControls];
    [self layoutAnswerButtons];
    [self loadData];
}

- (void) loadData
{
    
    
    NSDictionary *dic = dataSourceArray[self.questionNumber];
    self.questionLabel.text = [NSString stringWithFormat:@"问题%ld:\n%@", self.questionNumber + 1, dic[@"title"]];
    
    NSArray *arr1 = dic[@"answer"];
    for (int i = 0; i < arr1.count; ++i) {
        
        NSString *answer = [NSString stringWithFormat:@"%@", arr1[i]];
        if ([answer containsString:@"\n"]) {
            NSLog(@"xxxxxxxxxxxxxxxxxxxxx");
        }
        UIButton *button = [self.view viewWithTag:100 + i];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:arr1[i] forState:UIControlStateNormal];
    }
    
}

- (void) layoutAnswerButtons
{
    NSDictionary *dic = dataSourceArray[self.questionNumber];
    NSArray *arr1 = dic[@"answer"];
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
    NSString *trueAns = dic[@"right_answer"];
    kDLog(@"正确答案是：%@", trueAns);
    NSString *clickAnswer = [NSString stringWithFormat:@"%@", button.titleLabel.text];
    kDLog(@"点击的答案是：%@", [clickAnswer substringToIndex:1]);
    
    if ([[clickAnswer substringToIndex:1] isEqualToString:trueAns]) {
        button.backgroundColor = [UIColor greenColor];
        trueCount++;
    } else {
        
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
        
        CGFloat accuracy = trueCount * 100 / dataSourceArray.count;
//        kDLog(@"正确率是：%f", accuracy);
        
        
        
        
        
        
        [self submitScore:accuracy];
        
        
        
        
        
        PTReadCheckResultVC *readCheckResultVC = [PTReadCheckResultVC new];
        readCheckResultVC.accuracy = accuracy;
        [self.navigationController pushViewController:readCheckResultVC animated:YES];
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

- (void) submitScore:(CGFloat)accuracy {
    
    
    NSDictionary *userIdDic = [NSDictionary dictionaryWithContentsOfFile:kUserFilePath];
    
    NSString *bookUrl = [NSString stringWithFormat:@"%@%@user_id/%@/continuetime/%@/accuracy/%.0f", [[VersionManager shareManager] currentVersion], kSCORE, userIdDic[@"user_id"], @"0", accuracy];
    
    kDLog(@"阅读检测给后台传正确率和时间的接口是：%@", bookUrl);
    [CHNetWorkSingleton requestAFWithURL:bookUrl params:nil httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"阅读检测给后台传正确率和时间的接口返回的数据是：%@", result);
        
    } errorBlock:^(NSError *error) {
        
        kDLog(@"阅读检测给后台传正确率和时间的接口请求失败，错误是：%@", error);
    }];
}

- (void) initDataSource
{
    
//    NSArray *qaArr1 = @[
//  @{@"que1" :@"鲁迅原名到底叫什么？", @"ans1" :@[@"周迅", @"冰心", @"步惊云", @"周树人"], @"trueAns" : @"周树人"},
//  @{@"que1" :@"答案是1？", @"ans1" :@[@"1", @"2", @"3", @"4"], @"trueAns" : @"1"},
//  @{@"que1" :@"答案是2？", @"ans1" :@[@"2", @"3", @"4", @"5"], @"trueAns" : @"2"},
//  @{@"que1" :@"答案是3？", @"ans1" :@[@"3", @"4", @"5"], @"trueAns" : @"3"},
//  @{@"que1" :@"答案是4？", @"ans1" :@[@"4", @"5", @"6", @"7"], @"trueAns" : @"4"},
//  @{@"que1" :@"答案是5？", @"ans1" :@[@"5", @"6", @"7", @"8"], @"trueAns" : @"5"},
//                        ];
    
    
    
    dataSourceArray = [NSMutableArray arrayWithArray:self.queArray];
}

- (void) setUpNav
{
    
    self.title = @"问题";
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
