//
//  PTLearnDetailVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTLearnDetailVC.h"

@interface PTLearnDetailVC ()

@end

@implementation PTLearnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenHeight - 20);
    contentLabel.text = [NSString stringWithFormat:@"        %@", self.content];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:contentLabel];
    contentLabel.backgroundColor = [UIColor redColor];
    
    
    CGSize oldSize = CGSizeMake(kScreenWidth - 40, MAXFLOAT);
    CGSize newSize;
    
    NSString *content = [NSString stringWithFormat:@"        %@", self.content];
    
    newSize = [content boundingRectWithSize:oldSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    
    contentLabel.frame = CGRectMake(20, 20, newSize.width, newSize.height);
    
    // Do any additional setup after loading the view.
}


- (void) setUpNav
{
    
    self.title = @"知识详情";
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
