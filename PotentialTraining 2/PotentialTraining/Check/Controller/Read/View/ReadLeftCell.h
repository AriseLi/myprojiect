//
//  ReadLeftCell.h
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTReadCheckModel;

@interface ReadLeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *classLabel;

- (void) configCellWithModel:(PTReadCheckModel *)model;

- (void) configCellWithDiff:(NSString *)diff;

@end
