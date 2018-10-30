//
//  PTLearnTableCell.h
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTLearnModel;

@interface PTLearnTableCell : UITableViewCell


/**
 *  标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  简介
 */
@property (nonatomic, strong) UILabel *introduceLabel;

- (void) configLabelWithModel:(PTLearnModel *)model;

@end
