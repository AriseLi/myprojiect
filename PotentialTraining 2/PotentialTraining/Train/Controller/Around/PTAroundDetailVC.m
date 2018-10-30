//
//  PTAroundDetailVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/12.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTAroundDetailVC.h"

@interface PTAroundDetailVC ()
{
    
    CGPoint rightUpStartPoint;
    CGPoint rightUpEndPoint;
    
    CGPoint leftUpStartPoint;
    CGPoint leftUpEndPoint;
    
    CGPoint leftDownStartPoint;
    CGPoint leftDownEndPoint;
    
    CGPoint rightDownStartPoint;
    CGPoint rightDownEndPoint;
    
}

@property (nonatomic, strong) UILabel *rightUpLabel1;
@property (nonatomic, strong) UILabel *leftUpLabel1;
@property (nonatomic, strong) UILabel *leftDownLabel1;
@property (nonatomic, strong) UILabel *rightDownLabel1;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation PTAroundDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self layoutSubControls];
    // Do any additional setup after loading the view.
}

- (void) beganTiming{

    if (self.rightUpLabel1.center.x == rightUpStartPoint.x) {
        [UIView animateWithDuration:self.speed animations:^{
            
            self.rightUpLabel1.center = rightUpEndPoint;
            self.leftUpLabel1.center = leftUpEndPoint;
            self.leftDownLabel1.center = leftDownEndPoint;
            self.rightDownLabel1.center = rightDownEndPoint;

        }];
    } else if (self.rightUpLabel1.center.x == rightUpEndPoint.x){
        
        
        
        
        
        [UIView animateWithDuration:self.speed animations:^{
            
            self.rightUpLabel1.center = rightUpStartPoint;
            self.leftUpLabel1.center = leftUpStartPoint;
            self.leftDownLabel1.center = leftDownStartPoint;
            self.rightDownLabel1.center = rightDownStartPoint;
        }];
    }
}
- (void) layoutSubControls{
    
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 60;
    
    CGFloat viewWidth = kScreenWidth;
    CGFloat viewHeight = kScreenHeight - 64;
    
    rightUpStartPoint = CGPointMake(viewWidth / 2 + labelWidth / 2, viewHeight / 2 - labelHeight / 2);
    rightUpEndPoint = CGPointMake(viewWidth - labelWidth / 2, labelHeight / 2);
    
    leftUpStartPoint = CGPointMake(viewWidth / 2 - labelWidth / 2, viewHeight / 2 - labelHeight / 2);
    leftUpEndPoint = CGPointMake(labelWidth / 2, labelHeight / 2);
    
    leftDownStartPoint = CGPointMake(viewWidth / 2 - labelWidth / 2, viewHeight / 2 + labelHeight / 2);
    leftDownEndPoint = CGPointMake(labelWidth / 2, viewHeight - labelHeight / 2);
    
    rightDownStartPoint = CGPointMake(viewWidth / 2 + labelWidth / 2, viewHeight / 2 + labelHeight / 2);
    rightDownEndPoint = CGPointMake(viewWidth - labelWidth / 2, viewHeight - labelHeight / 2);
    
    UILabel *rightUpLabel1 = [UILabel new];
    rightUpLabel1.frame = CGRectMake(viewWidth / 2, viewHeight / 2 - labelHeight, labelWidth, labelHeight);
    rightUpLabel1.center = rightUpStartPoint;
    rightUpLabel1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    rightUpLabel1.text = @"潜能训练1";
    rightUpLabel1.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:rightUpLabel1];
    self.rightUpLabel1 = rightUpLabel1;
    
    UILabel *leftUpLabel1 = [UILabel new];
    leftUpLabel1.frame = CGRectMake(viewWidth / 2 - labelWidth, CGRectGetMinY(rightUpLabel1.frame), labelWidth, labelHeight);
    leftUpLabel1.center = leftUpStartPoint;
    leftUpLabel1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    leftUpLabel1.text = @"潜能训练2";
    leftUpLabel1.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:leftUpLabel1];
    self.leftUpLabel1 = leftUpLabel1;
    
    UILabel *leftDownLabel1 = [UILabel new];
    leftDownLabel1.frame = CGRectMake(viewWidth / 2 - labelWidth, CGRectGetMaxY(leftUpLabel1.frame), labelWidth, labelHeight);
    leftDownLabel1.center = leftDownStartPoint;
    leftDownLabel1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3"]];
    leftDownLabel1.text = @"潜能训练3";
    leftDownLabel1.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:leftDownLabel1];
    self.leftDownLabel1 = leftDownLabel1;
    
    UILabel *rightDownLabel1 = [UILabel new];
    rightDownLabel1.frame = CGRectMake(viewWidth / 2, CGRectGetMinY(leftDownLabel1.frame), labelWidth, labelHeight);
    rightDownLabel1.center = rightDownStartPoint;
    rightDownLabel1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    rightDownLabel1.text = @"潜能训练4";
    rightDownLabel1.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:rightDownLabel1];
    self.rightDownLabel1 = rightDownLabel1;
    
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(beganTiming) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void) setUpNav
{
    self.title = @"四周扩散-左思右想";
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
