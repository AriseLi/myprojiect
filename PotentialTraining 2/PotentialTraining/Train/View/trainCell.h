//
//  trainCell.h
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTReadCheckModel.h"

@interface trainCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configBookInfo:(PTReadCheckModel *)model;


@end
