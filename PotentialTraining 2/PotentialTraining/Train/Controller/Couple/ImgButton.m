//
//  ImgButton.m
//  PotentialTraining
//
//  Created by admin on 2018/2/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ImgButton.h"

@implementation ImgButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImg];
        [self setBackgroundImage:[UIImage imageNamed:@"shaonv"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"timg"] forState:UIControlStateSelected];
    }
    return self;
}

- (UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth/2-100)/4, (kScreenWidth/2-100)/4)];
        _bgImg.backgroundColor = kRandomColor;
    }
    return _bgImg;
}

@end
