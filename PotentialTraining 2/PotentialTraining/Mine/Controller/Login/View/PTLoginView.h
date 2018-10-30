//
//  PTLoginView.h
//  PotentialTraining
//
//  Created by admin on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTLoginViewDelegate <NSObject>;


- (void) loginViewVerifyButtonClick:(UIButton *)button;

- (void) loginViewLoginButtonClick:(UIButton *)button;

- (void) loginViewCancelButtonClick:(UIButton *)button;

- (void) loginViewPhoneTextFieldTextChange:(UITextField *)textField;

- (void) loginViewVerifyTextFieldTextChange:(UITextField *)textField;

@end

@interface PTLoginView : UIView

- (void) getVerifyCountDown;

- (void) refreshLoginButtonState;

@property (nonatomic, weak) id <PTLoginViewDelegate> delegate;

@end
