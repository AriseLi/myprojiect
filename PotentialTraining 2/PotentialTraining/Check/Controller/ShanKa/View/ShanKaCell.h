//
//  ShanKaCell.h
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShanKaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void) configCellWithDiff:(NSString *)diff;

@end
