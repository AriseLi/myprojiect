//
//  PTLoginView.m
//  PotentialTraining
//
//  Created by admin on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTLoginView.h"

@interface PTLoginView ()<UITextFieldDelegate>

/**
 用户名、手机号输入框
 */
@property (nonatomic, strong) UITextField *phoneTextField;

/**
 密码输入框
 */
@property (nonatomic, strong) UITextField *verifyTextField;

/**
 创建用户密码输入框右按钮
 */
@property (nonatomic, strong) UIButton *getVerifyButton;

//登录按钮
@property (nonatomic, strong) UIButton *loginButton;

//稍后登录按钮
@property (nonatomic, strong) UIButton *cancelButton;


@end


@implementation PTLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kAlphaColor(250, 250, 250, 0.7);
        [self initLoginView];
    }
    return self;
}

- (void) initLoginView
{
    
    //用户名输入框
    CGFloat phoneTextFieldW = 350;
    CGFloat phoneTextFieldH = 45;
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.frame = CGRectMake((kScreenWidth - phoneTextFieldW) / 2, kAutoSizeWidth(175), phoneTextFieldW, phoneTextFieldH);
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.font = [UIFont systemFontOfSize:17];
    self.phoneTextField.placeholder = @"请输入手机号";
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.phoneTextField];
    
    //用户名输入框下面的线
    UIView *phoneTextFieldLine = [[UIView alloc] init];
    phoneTextFieldLine.frame = CGRectMake(CGRectGetMinX(self.phoneTextField.frame), CGRectGetMaxY(self.phoneTextField.frame) + 1, CGRectGetWidth(self.phoneTextField.frame), 1);
    phoneTextFieldLine.backgroundColor = kColor(200, 200, 200);
    [self addSubview:phoneTextFieldLine];
    
    
    //用户密码输入框
    CGFloat passwordTextFieldW = phoneTextFieldW;
    CGFloat passwordTextFieldH = phoneTextFieldH;
    self.verifyTextField = [[UITextField alloc] init];
    self.verifyTextField.borderStyle = UITextBorderStyleNone;
    self.verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyTextField.frame = CGRectMake(CGRectGetMinX(self.phoneTextField.frame), CGRectGetMaxY(phoneTextFieldLine.frame) + 1, passwordTextFieldW, passwordTextFieldH);
    self.verifyTextField.placeholder = @"请输入短信验证码";
    [self.verifyTextField addTarget:self action:@selector(verifyTextFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    self.getVerifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getVerifyButton.frame = CGRectMake(CGRectGetMaxX(self.getVerifyButton.frame), CGRectGetMinY(self.getVerifyButton.frame), kAutoSizeWidth(100), kAutoSizeWidth(35));
    [self.getVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getVerifyButton.titleLabel.font = [UIFont systemFontOfSize:kAutoSizeWidth(14)];
    [self.getVerifyButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
//    [self.getVerifyButton setBackgroundImage:[UIImage imageNamed:@"verify_able"] forState:UIControlStateNormal];
//    [self.getVerifyButton setBackgroundImage:[UIImage imageNamed:@"verify_disable"] forState:UIControlStateDisabled];
    
    [self.getVerifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getVerifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.getVerifyButton.adjustsImageWhenHighlighted = NO;
    self.getVerifyButton.layer.cornerRadius = 2;
    self.getVerifyButton.clipsToBounds = YES;
    [self.getVerifyButton addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.verifyTextField.rightViewMode = UITextFieldViewModeAlways;
    self.verifyTextField.rightView = _getVerifyButton;
    [self addSubview:self.verifyTextField];
    
    //用户名输入框下面的线
    UIView *passwordTextFieldLine = [[UIView alloc] init];
    passwordTextFieldLine.frame = CGRectMake(CGRectGetMinX(self.phoneTextField.frame), CGRectGetMaxY(self.verifyTextField.frame) + 1, CGRectGetWidth(self.phoneTextField.frame), 1);
    passwordTextFieldLine.backgroundColor = kColor(200, 200, 200);
    [self addSubview:passwordTextFieldLine];
    
    CGFloat loginButtonW = passwordTextFieldW;
    CGFloat loginButtonH = passwordTextFieldH;
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake((kScreenWidth - loginButtonW) / 2, CGRectGetMaxY(_verifyTextField.frame) + 31, loginButtonW, loginButtonH);
    self.loginButton.layer.cornerRadius = 3;
    self.loginButton.layer.borderWidth = 0.5;
    self.loginButton.layer.borderColor = kColor(200, 200, 200).CGColor;
    [self.loginButton setTitle:@"马上登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:kColor(200, 200, 200) forState:UIControlStateDisabled];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:kAutoSizeWidth(14)];
    [self.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    self.loginButton.enabled = NO;
    [self addSubview:self.loginButton];
    
    //稍后登录后面的背景按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake((kScreenWidth - kAutoSizeWidth(70)) / 2, kScreenHeight - kAutoSizeWidth(70), kAutoSizeWidth(70), kAutoSizeWidth(30));
    [ self.cancelButton setTitle:@"暂不登录" forState:UIControlStateNormal];
    [ self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAutoSizeWidth(14)];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.cancelButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit:)];
    [self addGestureRecognizer:tap];
    
}

- (void) getVerifyCountDown
{
    
    //动态倒计时
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //当倒计时到0时  重新获取验证码视图消失  加载获取验证码视图
                self.getVerifyButton.enabled = YES;
                [self.getVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        } else {
            int seconds = timeout % 61; //对61取余 而不是对60取余 这样最开始不会显示00  而显示timeout的值
            NSString *strTime = [NSString stringWithFormat:@"重新获取：%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.getVerifyButton setTitle:[NSString stringWithFormat:@"%@s", strTime] forState:UIControlStateNormal];
                self.getVerifyButton.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void) refreshLoginButtonState
{
    
    if (_phoneTextField.text.length == 11 && _verifyTextField.text.length == 4) {
        
        self.loginButton.enabled = YES;
        self.loginButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else {
        
        self.loginButton.enabled = NO;
        self.loginButton.layer.borderColor = [UIColor grayColor].CGColor;
    }
}

- (void) verifyTextFieldTextChange:(UITextField *)textField
{
    
    if ([_delegate respondsToSelector:@selector(loginViewVerifyTextFieldTextChange:)]) {
        
        [_delegate loginViewVerifyTextFieldTextChange:textField];
    }
}

- (void) phoneTextFieldTextChange:(UITextField *)textField
{
    
    if ([_delegate respondsToSelector:@selector(loginViewPhoneTextFieldTextChange:)]) {
        
        [_delegate loginViewPhoneTextFieldTextChange:textField];
    }
}

- (void) cancelButtonClick:(UIButton *)button
{
    
    if ([_delegate respondsToSelector:@selector(loginViewCancelButtonClick:)]) {
        
        [_delegate loginViewCancelButtonClick:button];
    }
}

- (void) loginButtonClick:(UIButton *)button
{
    
    if ([_delegate respondsToSelector:@selector(loginViewLoginButtonClick:)]) {
        
        [_delegate loginViewLoginButtonClick:button];
    }
}

- (void) verifyButtonClick:(UIButton *)button
{
    
    if ([_delegate respondsToSelector:@selector(loginViewVerifyButtonClick:)]) {
        
        [_delegate loginViewVerifyButtonClick:button];
    }
}

- (void) endEdit:(UITapGestureRecognizer *)tap
{
    if (![tap.view isEqual:self.cancelButton]) {
        
        [self endEditing:YES];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
