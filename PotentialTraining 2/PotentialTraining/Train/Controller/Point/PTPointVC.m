//
//  PTPointVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTPointVC.h"

@interface PTPointVC ()

@end

@implementation PTPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ningshi" ofType:@"gif"];
    /*
     NSData *data = [NSData dataWithContentsOfFile:path];
     使用loadData:MIMEType:textEncodingName: 则有警告
     [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
     */
    NSURL *url = [NSURL URLWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self setUpNav];
}

- (void) setUpNav
{
    
    self.title = @"一点凝视";
    self.view.backgroundColor = [UIColor whiteColor];
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
