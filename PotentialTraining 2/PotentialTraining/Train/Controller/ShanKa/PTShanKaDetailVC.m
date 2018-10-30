//
//  PTShanKaDetailVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/7.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTShanKaDetailVC.h"
#import "PTShanKaCheckQuestionVC.h"

@interface PTShanKaDetailVC ()
{
    NSInteger labelX;
    NSInteger labelY;
    CGFloat labelWidth;
    CGFloat labelHeight;
}

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *moveLabel;

@property (nonatomic, assign) NSInteger timeCount;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PTShanKaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.timeCount = 1;
    self.dataSource = [NSMutableArray array];
    
    [self setUpNav];
    [self layoutSubControls];
}

- (void) beganTiming
{
    
    
    
    
    NSInteger xxx  = kScreenWidth - labelWidth;
    labelX = arc4random() % xxx;
    
    NSInteger yyy  = kScreenHeight - 64 - labelHeight;
    labelY = arc4random() % yyy;
    
    self.moveLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    if ([self.shanKaType isEqualToString:@"数字"]) {
        
        NSLog(@"长度是%ld", self.length);
        
        NSInteger randomNumber = pow(10, self.length);
        self.moveLabel.text = [NSString stringWithFormat:@"%ld", arc4random() % randomNumber];
        
        
        NSLog(@"数字是：%@", self.moveLabel.text);
        
        if (self.isCheck == YES) {
            self.timeCount ++;
            
            [self.dataSource addObject:[NSString stringWithFormat:@"%ld", arc4random() % randomNumber]];
            
            if (self.timeCount == 7) {
                
                NSLog(@"12222222222222222________________%@", self.dataSource);
                
                PTShanKaCheckQuestionVC *vc = [PTShanKaCheckQuestionVC new];
                vc.numberLenght = self.length;
                vc.dataSource = self.dataSource;
                vc.questionNumber = 0;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
        
        
    } else {
        
        NSMutableArray *mutArr = [NSMutableArray new];
        for (int i = 0; i < self.length; i++) {
            NSInteger num = arc4random() % 26 + 1;
            char character = 96 + num;
            NSString *characterString = [NSString stringWithFormat:@"%c", character];
            [mutArr addObject:characterString];
        }
        NSString *labelText = [mutArr componentsJoinedByString:@" "];
        self.moveLabel.text = [NSString stringWithFormat:@"%@", labelText];
    }
    
    
    
}
- (void) layoutSubControls
{
    
    labelX = 50;
    labelY = labelX;
    labelWidth = 300;
    labelHeight = 90;
    UILabel *moveLabel = [UILabel new];
    moveLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    moveLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3"]];
    moveLabel.textColor = [UIColor blackColor];
    moveLabel.font = [UIFont systemFontOfSize:40];
    moveLabel.text = @"准备！";
    moveLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moveLabel];
    self.moveLabel = moveLabel;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/self.speed target:self selector:@selector(beganTiming) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
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

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
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
