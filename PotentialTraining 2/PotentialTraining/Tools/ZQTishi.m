//
//  ZQTishi.m
//  yicheyixianShop
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 com.juzhen. All rights reserved.
//

#import "ZQTishi.h"

@implementation ZQTishi

+ (void)addTishiStr:(NSString *)str{
    UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [popAlert addAction:popAction];
    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [vc presentViewController:popAlert animated:YES completion:nil];
    
}

@end
