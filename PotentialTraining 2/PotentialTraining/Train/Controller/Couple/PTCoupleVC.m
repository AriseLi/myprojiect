//
//  PTCoupleVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTCoupleVC.h"
#import "ImgButton.h"
#import "NSArray+RandomSort.h"
#import "NSMutableArray+RandomSort.h"
@interface PTCoupleVC ()
{
    NSInteger btnTag;
    NSInteger clickNum;
    
}
@property (nonatomic, strong) UIImageView *bgImg;
/** 包含按钮的数组 */
@property (nonatomic, strong) NSMutableArray *btnAry;
/** 包含随机数的数组 */
@property (nonatomic, strong) NSMutableArray *numAry;
@end

@implementation PTCoupleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    btnTag = 1000;
    clickNum = 0;
    [self setUpNav];
    [self.view addSubview:self.bgImg];
    [self addSubViews];
}

- (void) setUpNav{
    self.title = @"无独有偶";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addSubViews{
    NSArray *temp = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6",@"7", @"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:temp];
    int i;
    NSInteger count = temp.count;
    for (i = 0; i < 12; i ++) {
        int index = arc4random() % (count - i);
        [self.numAry addObject:[tempArray objectAtIndex:index]];
        [tempArray removeObjectAtIndex:index];
    }
    //    为数组添加重复数据
    NSInteger nweCount = self.numAry.count;
    NSMutableArray *NewtempArray = [[NSMutableArray alloc] initWithArray:self.numAry];
    for (i = 0; i < 2; i ++) {
        int index = arc4random() % (nweCount - i);
        [self.numAry addObject:[NewtempArray objectAtIndex:index]];
        [NewtempArray removeObjectAtIndex:index];
    }
    NSLog(@"resultArray is %@",self.numAry);
    [self.numAry randomObjects]; ///打乱数组顺序
    NSLog(@"resultArray is %@",self.numAry);
    CGFloat btnWith = (self.bgImg.width-100)/4;
    for (int i = 0; i < 14; i++) {
        ImgButton *btn = [ImgButton buttonWithType:0];
        btn.tag = [self.numAry[i] integerValue];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.numAry[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0) {
            btn.frame = CGRectMake(20, 20, btnWith, btnWith);;
        }else if (i==1){
            btn.frame = CGRectMake(40+btnWith, 20, btnWith, btnWith);
        }else if (i==2){
            btn.frame = CGRectMake(60+2*btnWith, 20, btnWith, btnWith);
        }else if (i==3){
            btn.frame = CGRectMake(80+3*btnWith, 20, btnWith, btnWith);
        }else if (i==4){
            btn.frame = CGRectMake(20, 40+btnWith, btnWith, btnWith);
        }else if (i==5){
            btn.frame = CGRectMake(40+btnWith, self.bgImg.height/2-btnWith/2, btnWith, btnWith);
        }else if (i==6){
            btn.frame = CGRectMake(60+2*btnWith, self.bgImg.height/2-btnWith/2, btnWith, btnWith);
        }else if (i==7){
            btn.frame = CGRectMake(80+3*btnWith, 40+btnWith, btnWith, btnWith);
        }else if (i==8){
            btn.frame = CGRectMake(20, 60+2*btnWith, btnWith, btnWith);
        }else if (i==9){
            btn.frame = CGRectMake(80+3*btnWith, 60+2*btnWith, btnWith, btnWith);
        }else if (i==10){
            btn.frame = CGRectMake(20, 80+3*btnWith, btnWith, btnWith);
        }else if (i==11){
            btn.frame = CGRectMake(40+btnWith, 80+3*btnWith, btnWith, btnWith);
        }else if (i==12){
            btn.frame = CGRectMake(60+2*btnWith, 80+3*btnWith, btnWith, btnWith);
        }else if (i==13){
            btn.frame = CGRectMake(80+3*btnWith, 80+3*btnWith, btnWith, btnWith);
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnAry addObject:btn];
        [self.bgImg addSubview:btn];
    }
}
#pragma mark - 第一次点击按钮
- (void)clickBtn:(ImgButton *)btn{
    if (btn.selected == NO) {
        if (btnTag != 1000) {
            [self secondClick:btn];
        }else{
            btnTag = btn.tag;
            btn.selected = YES;
        }
    }else{
        btn.selected = NO;
        btnTag = 1000;
    }
    
}
#pragma mark - 第二次点击按钮
- (void) secondClick:(ImgButton *)btn{
    if (btn.tag == btnTag) {
        for (ImgButton *inBtn in self.btnAry) {
            if (inBtn.tag == btnTag) {
                inBtn.hidden = YES;
            }
        }
        clickNum = clickNum+1;
        btnTag = 1000;
        if (clickNum == 2) {
            [self.numAry removeAllObjects];
            [self.bgImg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self addSubViews];
            clickNum = 0;
        }
    }else{
        for (ImgButton *inBtn in self.btnAry) {
            inBtn.selected = NO;
            btnTag = 1000;
        }
    }
}

- (UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-kScreenWidth/4, 20, kScreenWidth/2, kScreenWidth/2)];
        _bgImg.image = [UIImage imageNamed:@"shaonv"];
        _bgImg.userInteractionEnabled = YES;
    }
    return _bgImg;
}

- (NSMutableArray *)btnAry{
    if (_btnAry == nil) {
        _btnAry = [NSMutableArray array];
    }
    return _btnAry;
}
- (NSMutableArray *)numAry{
    if (_numAry == nil) {
        _numAry = [NSMutableArray array];
    }
    return _numAry;
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
