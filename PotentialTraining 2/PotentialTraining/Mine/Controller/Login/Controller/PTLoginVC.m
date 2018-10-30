//
//  PTLoginVC.m
//  PotentialTraining
//
//  Created by admin on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTLoginVC.h"
#import "PTLoginView.h"

@interface PTLoginVC ()<PTLoginViewDelegate>

{
    
    NSString *phoneString;
    
    NSString *verifyString;
    
}

@property (nonatomic, strong) PTLoginView *loginView;

@end

@implementation PTLoginVC

- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLoginView];
    
    
    
    // Do any additional setup after loading the view.
}


- (void) loginViewVerifyTextFieldTextChange:(UITextField *)textField
{
    
    kDLog(@"验证码输入框正在输入");
    verifyString = textField.text;
    
    
    NSRange verifyStrRange = NSMakeRange(0, verifyString.length);
    NSString * passwordToBeString = [verifyString stringByReplacingCharactersInRange:verifyStrRange withString:verifyString];
    
    if (passwordToBeString.length > 4 && verifyStrRange.length!=1){
        
        textField.text = [passwordToBeString substringToIndex:4];
        verifyString = textField.text;
    }
    [self.loginView refreshLoginButtonState];
}

- (void) loginViewPhoneTextFieldTextChange:(UITextField *)textField
{
    
    kDLog(@"手机号输入框正在输入");
    phoneString = textField.text;
    NSRange phoneStrRange = NSMakeRange(0, phoneString.length);
    NSString * phoneToBeString = [phoneString stringByReplacingCharactersInRange:phoneStrRange withString:phoneString];
    
    if (phoneToBeString.length > 11 && phoneStrRange.length!=1){
        
        textField.text = [phoneToBeString substringToIndex:11];
        phoneString = textField.text;
    }
    
    [self.loginView refreshLoginButtonState];
}

- (void) loginViewCancelButtonClick:(UIButton *)button
{
    
    kDLog(@"返回");
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (void) loginViewLoginButtonClick:(UIButton *)button
{
    
    kDLog(@"登录");
    
    if (phoneString.length == 0 || verifyString.length == 0) {
        
        return;
    }
    
    NSDictionary *postDic = @{
                              @"phone" : phoneString,
                              @"code" : verifyString
                              };
    kDLog(@"登录字典是：%@", postDic);
    
    NSString *postUrl = [NSString stringWithFormat:@"%@%@", [[VersionManager shareManager] currentVersion], kREGIST];
    
    kDLog(@"登录接口是：%@", postUrl);
    
    [CHNetWorkSingleton requestAFWithURL:postUrl params:postDic httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"登录接口请求成功，返回的信息是：%@", result);
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = result[@"data"];
            NSString *info = result[@"info"];
            NSString *code = result[@"code"];
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                
                if ([code isEqualToString:@"11"]) {
                    
                    [self.view endEditing:YES];
                    
                    kDLog(@"===%@", dic);
                    [dic writeToFile:kUserFilePath atomically:YES];
                    
                    NSString *ifComplete = [NSString stringWithFormat:@"%@", dic[@"info_complete"]];
                    
                    if ([ifComplete isEqualToString:@"0"]) {
                        
                        
                        //                    SNMyInfoViewController *vc = [SNMyInfoViewController new];
                        //                    vc.ifLoginVCPush = @"1";
                        //                    [self.navigationController pushViewController:vc animated:YES];
                    } else {
                        
                        [self getUserinfoWithUserId:dic];
                        
                    }
                    
                    
                }else{
                    
                    UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:info preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                    [popAlert addAction:popAction];
                    [self presentViewController:popAlert animated:YES completion:nil];
                }

            }
            
            
        } else {
            
            return ;
        }
        
    } errorBlock:^(NSError *error) {
        
        kDLog(@"登录失败，错误是：%@", error);
    }];
     
}

- (void) getUserinfoWithUserId:(NSDictionary *)userDic
{
    
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@user_id/%@", [[VersionManager shareManager] currentVersion], kGETINFO, userDic[@"user_id"]];
    kDLog(@"获取信息页页面接口是：%@", getUrl);
    
    [CHNetWorkSingleton requestAFWithURL:getUrl params:nil httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
        
        NSDictionary *dic = result[@"data"];
        NSString *code = result[@"code"];
        
        if ([code isEqualToString:@"11"] && dic != nil) {
            
            [dic writeToFile:kInfoFilePath atomically:YES];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }
    } errorBlock:^(NSError *error) {
        
        kDLog(@"登录失败，错误是：%@", error);
    }];
    
    
}

- (void) loginViewVerifyButtonClick:(UIButton *)button
{
    
    if (phoneString.length != 11) {
        
        kDLog(@"手机号码不对");
        UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入正确的手机号！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [popAlert addAction:popAction];
        [self presentViewController:popAlert animated:YES completion:nil];
        
    } else {
        
        kDLog(@"获取验证码");
        NSString *getUrl = [NSString stringWithFormat:@"%@%@phone/%@", [[VersionManager shareManager] currentVersion], kVERIFY, phoneString];
        kDLog(@"获取验证码接口是：%@", getUrl);
        
        [CHNetWorkSingleton requestAFWithURL:getUrl params:nil httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
            
            kDLog(@"获取验证码接口请求成功，返回的信息是：%@", result);
            
            NSString *code = result[@"code"];
            //            NSString *info = responseBody[@"info"];
            if ([code isEqualToString:@"11"]) {
                
                [self.loginView getVerifyCountDown];
            }else{
                
                //                UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:info preferredStyle:UIAlertControllerStyleAlert];
                //                UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                //                [popAlert addAction:popAction];
                //                [self presentViewController:popAlert animated:YES completion:nil];
            }
            
        } errorBlock:^(NSError *error) {
            
            kDLog(@"获取验证码失败，错误是：%@", error);
        }];
    }
}

- (void) initLoginView
{
    
    
    PTLoginView *loginView = [[PTLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    self.loginView = loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
