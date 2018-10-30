//
//  trainCell.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "trainCell.h"

@implementation trainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)configBookInfo:(PTReadCheckModel *)model {
    
    self.titleLabel.text = model.book_name;
}

@end
