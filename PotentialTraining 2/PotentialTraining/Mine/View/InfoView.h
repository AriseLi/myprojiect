//
//  InfoView.h
//  PotentialTraining
//
//  Created by admin on 2018/2/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DidEditHeadImg <NSObject>

- (void) DidselectTHeadImg:(UIImageView *)headImg;

- (void) didClickSendInfoButton;

@end
@interface InfoView : UIView
/** 头像的代理 */
@property (weak,nonatomic) id<DidEditHeadImg>HeadImgDetegate;

@end
