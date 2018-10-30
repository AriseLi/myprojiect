//
//  PTSpeed_VDetailVC.m
//  PotentialTraining
//
//  Created by admin on 2018/2/9.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTSpeed_VDetailVC.h"

@interface PTSpeed_VDetailVC ()
{
    
    NSInteger timeSecond;
    
    BOOL ifAdd;
}

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation PTSpeed_VDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self initDataSource];
    [self layoutSubControls];
    // Do any additional setup after loading the view.
}
- (void) beganTiming
{
    
    NSInteger imgTag = timeSecond % 5;
    
    if (imgTag == 4) {
        ifAdd = 0;
    } else if (imgTag == 0) {
        ifAdd = 1;
    }
    
    if (ifAdd) {
        timeSecond++;
    } else {
        timeSecond--;
    }
    
    
    kDLog(@"%ld", imgTag);
    
    for (UIImageView *imageView in self.view.subviews) {
        
        if (imageView.tag >= 100) {
            
            imageView.hidden = YES;
        }
    }
    
    UIImageView *beShowImageView = [UIImageView new];
    switch (imgTag) {
        case 0:
        {
            beShowImageView = [self.view viewWithTag:100];
        }
            break;
        case 1:
        {
            beShowImageView = [self.view viewWithTag:101];
        }
            break;
        case 2:
        {
            beShowImageView = [self.view viewWithTag:102];
        }
            break;
        case 3:
        {
            beShowImageView = [self.view viewWithTag:103];
        }
            break;
        case 4:
        {
            beShowImageView = [self.view viewWithTag:104];
        }
            break;
        default:
            break;
    }
    
    beShowImageView.hidden = NO;
    beShowImageView.backgroundColor =kRandomColor;
}
- (void) layoutSubControls
{
    
    CGFloat imageViewWidth = 150;
    CGFloat imageViewHeight = imageViewWidth;
    CGFloat hMargin = (kScreenWidth - 100 - imageViewHeight * 5) / 4;
    
    UIImageView *firstImgV = [UIImageView new];
    firstImgV.frame = CGRectMake(50, 50, imageViewWidth, imageViewHeight);
    firstImgV.backgroundColor = [UIColor redColor];
    firstImgV.tag = 100;
    firstImgV.hidden = YES;
    [self.view addSubview:firstImgV];
    
    UIImageView *secondImgV = [UIImageView new];
    secondImgV.frame = CGRectMake(CGRectGetMaxX(firstImgV.frame) + hMargin, kScreenHeight - 64 - 50 - 150, imageViewWidth, imageViewHeight);
    secondImgV.backgroundColor = [UIColor redColor];
    secondImgV.tag = 101;
    secondImgV.hidden = YES;
    [self.view addSubview:secondImgV];
    
    UIImageView *thirdImgV = [UIImageView new];
    thirdImgV.frame = CGRectMake(CGRectGetMaxX(secondImgV.frame) + hMargin, CGRectGetMinY(firstImgV.frame), imageViewWidth, imageViewHeight);
    thirdImgV.backgroundColor = [UIColor redColor];
    thirdImgV.tag = 102;
    thirdImgV.hidden = YES;
    [self.view addSubview:thirdImgV];
    
    UIImageView *fourthImgV = [UIImageView new];
    fourthImgV.frame = CGRectMake(CGRectGetMaxX(thirdImgV.frame) + hMargin, CGRectGetMinY(secondImgV.frame), imageViewWidth, imageViewHeight);
    fourthImgV.backgroundColor = [UIColor redColor];
    fourthImgV.tag = 103;
    fourthImgV.hidden = YES;
    [self.view addSubview:fourthImgV];
    
    UIImageView *fifthImgV = [UIImageView new];
    fifthImgV.frame = CGRectMake(CGRectGetMaxX(fourthImgV.frame) + hMargin, CGRectGetMinY(thirdImgV.frame), imageViewWidth, imageViewHeight);
    fifthImgV.backgroundColor = [UIColor redColor];
    fifthImgV.tag = 104;
    fifthImgV.hidden = YES;
    [self.view addSubview:fifthImgV];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/self.speed target:self selector:@selector(beganTiming) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void) initDataSource
{
    
    timeSecond = 0;
    ifAdd = 1;
}
- (void) setUpNav
{
    self.title = @"视速训练-竖";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
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
