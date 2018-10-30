//
//  ReadLeftCell.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ReadLeftCell.h"
#import "PTReadCheckModel.h"

@implementation ReadLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void) configCellWithModel:(PTReadCheckModel *)model{
    
    self.classLabel.text = model.book_name;
}

- (void) configCellWithDiff:(NSString *)diff {
    
    
    self.classLabel.text = diff;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
