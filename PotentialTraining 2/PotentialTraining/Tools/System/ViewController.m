//
//  ViewController.m
//  PotentialTraining
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 admin. All rights reserved.
//

// 屏幕尺寸

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kAutoSizeWidth(controlWidth) ((controlWidth) * kScreenWidth) / 1024

#ifdef DEBUG
#define kDLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define kDLog(FORMAT, ...) nil
#endif

#define labelX kAutoSizeWidth(200)
#define labelY kAutoSizeWidth(200)

#import "ViewController.h"


@interface ViewController ()

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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource = [NSMutableArray array];
    
    self.count = 25;
    
    touchNumber = 1;
    
    relayout = 0;
    
    timeSecond = 1;
    
    kDLog(@"创建控件");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *startButton = [UIButton buttonWithType:0];
    startButton.frame = CGRectMake(50, 50, 100, 100);
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor orangeColor];
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
    
    CGFloat labelWidth = (kScreenWidth - 400) / sqrt(self.count);
    CGFloat labelHeight = labelWidth;
    NSInteger lineCount = sqrt(self.count);
    NSInteger colCount = lineCount;
    
    for (NSInteger i = 0; i < dataSource.count; i++) {
        
        UIButton *chouseButton = [UIButton buttonWithType:0];
        chouseButton.frame = CGRectMake(200 + labelWidth * (i / lineCount), 50 + labelHeight * (i %colCount), labelWidth, labelHeight);
        chouseButton.adjustsImageWhenHighlighted = YES;
        chouseButton.backgroundColor = [UIColor whiteColor];
        chouseButton.layer.borderColor = [UIColor grayColor].CGColor;
        chouseButton.layer.borderWidth = 0.5;
        chouseButton.tag = 100 + i;
        [chouseButton setTitle:[NSString stringWithFormat:@"%@", dataSource[i]] forState:UIControlStateNormal];
        [chouseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chouseButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        chouseButton.titleLabel.font = [UIFont systemFontOfSize:labelWidth * 0.7];
        [chouseButton addTarget:self action:@selector(chouseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:chouseButton];
    }
}

- (void) chouseButtonClick:(UIButton *)button
{
    
//    kDLog(@"3.点击的数字是：%@", button.titleLabel.text);
    
    if ([button.titleLabel.text integerValue] == touchNumber) {
        
        button.enabled = NO;
        if (touchNumber == 1) {
            
            _timer.fireDate = [NSDate distantPast];;
        }
        touchNumber++;
    }
    
    if (touchNumber - 1 == self.count) {
        
        [self start];
    }
}
    
- (void)deviceOrientationChange:(NSNotification *)notification
{
    
//    kDLog(@"DeviceOrientation：%ld", (long)[UIDevice currentDevice].orientation);
    switch ([UIDevice currentDevice].orientation) {
        case 1:
        {
                
            kDLog(@"Home在下");
        }
            break;
        case 2:
        {
            
            kDLog(@"Home在上");
        }
            break;
        case 3:
        {
            
            kDLog(@"Home在右");
        }
            break;
        case 4:
        {
            
            kDLog(@"Home在左");
        }
            break;
        default:
            break;
    }
}


- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
