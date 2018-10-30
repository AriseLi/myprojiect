//
//  RankingView.h
//  PotentialTraining
//
//  Created by admin on 2018/2/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TableviewDidSelect <NSObject>

- (void) DidselectTTab:(NSIndexPath *)indexPath;

@end
@interface RankingView : UIView
/**  */
@property (weak,nonatomic) id<TableviewDidSelect>TabDetegate;
@end
