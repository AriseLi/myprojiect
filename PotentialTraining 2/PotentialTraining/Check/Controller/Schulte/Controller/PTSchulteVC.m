//
//  PTSchulteVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTSchulteVC.h"

@interface PTSchulteVC ()

{
    
    NSMutableArray *dataSource;
    
    NSInteger touchNumber;
    
    NSInteger relayout;
    
    NSInteger timeSecond;
}

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionView *SchulteCollectionView;


@end

@implementation PTSchulteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self initDataSource];
    
    [self layoutControls];
}

- (void) beganTiming
{
    timeSecond++;
    _timeLabel.text = [NSString stringWithFormat:@"%@%ld%@", @"已用时", (long)timeSecond, @"秒"];
    [_timeLabel sizeToFit];
    //    kDLog(@"%@", _timeLabel.text);
}

- (void) start
{
    
    _timeLabel.text = @"已用时0秒";
    [_timeLabel sizeToFit];
    
    _timer.fireDate = [NSDate distantFuture];
    timeSecond = 0;
    
    if (relayout == 1) {
        
        [dataSource removeAllObjects];
        relayout = 0;
        for (UIButton *chouseButton in self.view.subviews) {
            
            if (chouseButton.tag > 99) {
                
                [chouseButton removeFromSuperview];
            }
        }
    }
    
    if (dataSource.count < self.count) {
        
        NSInteger storageValue = arc4random() % self.count + 1;
        if (dataSource.count == 0) {
            
            [dataSource addObject:@(storageValue)];
            //            kDLog(@"1.第一次添加的：%@", dataSource);
            [self start];
        } else {
            
            NSMutableArray *array =[NSMutableArray arrayWithArray:dataSource];
            NSInteger flag = 0;
            for (NSInteger i = 0; i < array.count; i++) {
                
                NSNumber *compareValue = array[i];
                if (storageValue != [compareValue integerValue]) {
                    
                    flag++;
                }
                
                if (flag == array.count) {
                    
                    [dataSource addObject:@(storageValue)];
                    //                    kDLog(@"2.遍历之后添加的：%@", dataSource);
                }
            }
            [self start];
        }
    } else {
        
        kDLog(@"开始布局");
        [self layoutButton];
    }
}


- (void) layoutButton
{
    
    relayout = 1;
    touchNumber = 1;
    
    CGFloat labelWidth = (kScreenWidth - kAutoSizeWidth(400)) / sqrt(self.count);
    CGFloat labelHeight = labelWidth;
    NSInteger lineCount = sqrt(self.count);
    NSInteger colCount = lineCount;
    
    for (NSInteger i = 0; i < dataSource.count; i++) {
        
        UIButton *chouseButton = [UIButton buttonWithType:0];
        chouseButton.frame = CGRectMake(kAutoSizeWidth(200) + labelWidth * (i / lineCount), 50 + labelHeight * (i %colCount), labelWidth, labelHeight);
        chouseButton.adjustsImageWhenHighlighted = YES;
        chouseButton.backgroundColor = [UIColor whiteColor];
        chouseButton.layer.borderColor = [UIColor grayColor].CGColor;
        chouseButton.layer.borderWidth = 0.5;
        chouseButton.tag = 100 + [dataSource[i] integerValue];
        if ([self.schulteType isEqualToString:@"number"]) {
            
            [chouseButton setTitle:[NSString stringWithFormat:@"%@", dataSource[i]] forState:UIControlStateNormal];
        } else {
            
            char character = 96 + [dataSource[i] charValue];
            [chouseButton setTitle:[NSString stringWithFormat:@"%c", character] forState:UIControlStateNormal];
            
        }
        [chouseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chouseButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        chouseButton.titleLabel.font = [UIFont systemFontOfSize:labelWidth * 0.7];
        [chouseButton addTarget:self action:@selector(chouseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:chouseButton];
    }
}

- (void) chouseButtonClick:(UIButton *)button
{
    
//    kDLog(@"3.点击的是：%ld", button.tag);
    
    if (button.tag - 100 == touchNumber) {
        
        button.enabled = NO;
        if (touchNumber == 1) {
            
            _timer.fireDate = [NSDate distantPast];;
        }
        touchNumber++;
    }
    
    if (touchNumber - 1 == self.count) {
        
        //弹出提示框
        UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"测试完毕" message:_timeLabel.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *endTrain = [UIAlertAction actionWithTitle:@"结束训练" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [_timer invalidate];
            _timer = nil;
        }];
        
        UIAlertAction *restart = [UIAlertAction actionWithTitle:@"继续训练" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self start];
        }];
        
        [popAlert addAction:endTrain];
        [popAlert addAction:restart];
        [self presentViewController:popAlert animated:YES completion:nil];
    }
}

- (void) layoutControls
{
    
    UIButton *startButton = [UIButton buttonWithType:0];
    startButton.frame = CGRectMake(50, 50, 100, 100);
    [startButton setTitle:@"开始测试" forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    startButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.frame = CGRectMake(CGRectGetMinX(startButton.frame), CGRectGetMaxY(startButton.frame) + 10, CGRectGetWidth(startButton.frame), 30);
    timeLabel.text = @"已用时0秒";
    [_timeLabel sizeToFit];
    timeLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(beganTiming) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _timer.fireDate = [NSDate distantFuture];
}

- (void) initDataSource
{
    
    dataSource = [NSMutableArray array];
    
    self.count = 25;
    
    touchNumber = 1;
    
    relayout = 0;
    
    timeSecond = 1;
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
