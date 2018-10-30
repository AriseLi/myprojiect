//
//  PTLearnTableCell.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTLearnTableCell.h"
#include "PTLearnModel.h"

@implementation PTLearnTableCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel  *titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(20, 20, kScreenWidth - 40, 30);
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = kColor(100, 100, 100);
        titleLabel.font = [UIFont systemFontOfSize:24];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel  *introduceLabel = [UILabel new];
        introduceLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 10, CGRectGetWidth(titleLabel.frame), 50);
        introduceLabel.backgroundColor = [UIColor whiteColor];
        introduceLabel.textColor = kColor(100, 100, 100);
        introduceLabel.numberOfLines = 2;
        introduceLabel.font = [UIFont systemFontOfSize:20];
        introduceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:introduceLabel];
        self.introduceLabel = introduceLabel;
    }
    return self;
}

- (void) configLabelWithModel:(PTLearnModel *)model
{
    
    self.titleLabel.text = model.knowledge_title;
    self.introduceLabel.text = model.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
