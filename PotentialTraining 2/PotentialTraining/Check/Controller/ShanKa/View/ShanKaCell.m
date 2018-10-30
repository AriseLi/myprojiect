//
//  ShanKaCell.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ShanKaCell.h"

@implementation ShanKaCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) configCellWithDiff:(NSString *)diff {
    
    self.titleLabel.text = diff;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
