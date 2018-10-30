//
//  MainInfoCell.m
//  PotentialTraining
//
//  Created by admin on 2018/1/29.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MainInfoCell.h"

@implementation MainInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImg.clipsToBounds = YES;
    self.headerImg.layer.cornerRadius = 50;
    self.headerImg.layer.borderWidth = 2;
    self.headerImg.layer.borderColor = kColor(200, 200, 200).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
