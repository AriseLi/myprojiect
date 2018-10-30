//
//  PTReadCheckDetailVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTReadCheckDetailVC.h"
#import "PTReadCheckQuestionVC.h"

@interface PTReadCheckDetailVC ()

{
    
    NSInteger timeSecond;
}

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *queArray;

@end

@implementation PTReadCheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self layoutSubControls];
    
    [self loadData];
}

- (void) loadData {
    
    NSString *bookUrl = [NSString stringWithFormat:@"%@%@book_id/%@", [[VersionManager shareManager] currentVersion], kQUESTION, @"0000000002"];
    
    kDLog(@"阅读检测获取问题和答案的接口是：%@", bookUrl);
    [CHNetWorkSingleton requestAFWithURL:bookUrl params:nil httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"阅读检测获取问题和答案接口返回的数据是：%@", result);
        
        NSString *resultDoce = [NSString stringWithFormat:@"%@", result[@"code"]];
        if ([resultDoce isEqualToString:@"11"]) {
            self.queArray = result[@"data"];
        }
        
        
        
//        [dataArray removeAllObjects];
//
//        NSArray *bookArray = result[@"data"];
//
//        if ([result[@"code"] isEqualToString:@"11"]) {
//
//            for (NSDictionary *bookDic in bookArray) {
//
//                PTReadCheckModel *model = [PTReadCheckModel mj_objectWithKeyValues:bookDic];
//                [dataArray addObject:model];
//            }
//        }
//
//        //        [self.leftTab reloadData];
//        [self.classCollectionView reloadData];
        
        //        kDLog(@"书籍是：%@", dataArray);
        
    } errorBlock:^(NSError *error) {
        
        kDLog(@"阅读检测获取问题和答案接口请求失败，错误是：%@", error);
    }];
}

- (void) layoutSubControls
{
    
    UITextView *contentTextView = [UITextView new];
    contentTextView.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenHeight - 64 - 20 - 100);
    contentTextView.text = @"文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容";
    contentTextView.contentSize = CGSizeMake(kScreenWidth, kScreenWidth);
    contentTextView.editable = NO;
    contentTextView.layer.borderWidth = 0.5;
    contentTextView.layer.borderColor = [UIColor blackColor].CGColor;
    contentTextView.layer.cornerRadius = 5;
    contentTextView.textAlignment = NSTextAlignmentLeft;
    contentTextView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:contentTextView];
    contentTextView.text = self.content;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.frame = CGRectMake(CGRectGetMinX(contentTextView.frame), CGRectGetMaxY(contentTextView.frame) + 35, 150, 30);
    timeLabel.text = @"已用时0秒";
    [_timeLabel sizeToFit];
    timeLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(beganTiming) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _timer.fireDate = [NSDate distantFuture];
    
    CGFloat buttonWidth = 140;
    CGFloat buttonHeight = 60;
    
    UIButton *startOrEndButton = [UIButton buttonWithType:0];
    startOrEndButton.frame = CGRectMake(kScreenWidth - buttonWidth - 20, CGRectGetMaxY(contentTextView.frame) + 20, buttonWidth, buttonHeight);
    startOrEndButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    [startOrEndButton setTitle:@"开始计时" forState:UIControlStateNormal];
    startOrEndButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [startOrEndButton addTarget:self action:@selector(startOrEndButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startOrEndButton];
    
    UIButton *backButton = [UIButton buttonWithType:0];
    backButton.frame = CGRectMake(CGRectGetMinX(startOrEndButton.frame) - 160, CGRectGetMinY(startOrEndButton.frame), buttonWidth, buttonHeight);
    backButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [backButton setTitle:@"返回目录" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void) backButtonClick
{
    
    [_timer invalidate];
    _timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) startOrEndButtonClick:(UIButton *)button
{
    if (button.isSelected) {
        PTReadCheckQuestionVC *readCheckQuestionVC = [PTReadCheckQuestionVC new];
        readCheckQuestionVC.questionNumber = 0;
        readCheckQuestionVC.queArray = self.queArray;
        [self.navigationController pushViewController:readCheckQuestionVC animated:YES];
    } else {
        button.selected = YES;
        [button setTitle:@"开始测试" forState:UIControlStateNormal];
        _timer.fireDate = [NSDate distantPast];
    }
    
}

- (void) beganTiming
{
    timeSecond++;
    _timeLabel.text = [NSString stringWithFormat:@"%@%ld%@", @"已用时", (long)timeSecond, @"秒"];
    [_timeLabel sizeToFit];
}

- (void) setUpNav
{
    
    self.title = @"正文";
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
