//
//  RankingView.m
//  PotentialTraining
//
//  Created by admin on 2018/2/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "RankingView.h"
#import "RangkingleftCell.h"
#import "RangkingInfoCell.h"
@interface RankingView ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSIndexPath *selectIndex;
    
}
@property (nonatomic, strong) UITableView *classTab;
@property (nonatomic, strong) UITableView *infoTab;
@end
@implementation RankingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColor(238, 238, 238);
        [self addSubview:self.classTab];
        [self addSubview:self.infoTab];
    }
    return self;
}

- (UITableView *)classTab{
    if (_classTab == nil) {
        _classTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 199, kScreenHeight-49-64)];
        _classTab.backgroundColor = [UIColor whiteColor];
        _classTab.delegate = self;
        _classTab.dataSource = self;
        _classTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _classTab.tableFooterView = [UIView new];
        [_classTab registerNib:[UINib nibWithNibName:NSStringFromClass([RangkingleftCell class]) bundle:nil] forCellReuseIdentifier:@"RangkingleftCell"];
    }
    return _classTab;
}

- (UITableView *)infoTab{
    if (_infoTab == nil) {
        _infoTab = [[UITableView alloc]initWithFrame:CGRectMake(200, 0, kScreenWidth-300-200, kScreenHeight-49-64)];
        _infoTab.backgroundColor = [UIColor whiteColor];
        _infoTab.delegate = self;
        _infoTab.dataSource = self;
        _infoTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTab.tableFooterView = [UIView new];
        [_infoTab registerNib:[UINib nibWithNibName:NSStringFromClass([RangkingInfoCell class]) bundle:nil] forCellReuseIdentifier:@"RangkingInfoCell"];
    }
    return _infoTab;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.classTab) {
        return 3;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.classTab) {
        return 5;
    }else{
       return 15;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classTab) {
        RangkingleftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangkingleftCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (selectIndex == nil) {
            if (indexPath.section == 0 && indexPath.row == 0) {
                cell.titleLabel.textColor = kColor(254, 211, 54);
            }else{
                cell.titleLabel.textColor = [UIColor blackColor];
            }
        }else{
            if (indexPath == selectIndex) {
                cell.titleLabel.textColor = kColor(254, 211, 54);
            }else{
                cell.titleLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }else{
        RangkingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangkingInfoCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classTab) {
        selectIndex = indexPath;
        [self.classTab reloadData];
        if ([self.TabDetegate respondsToSelector:@selector(DidselectTTab:)]){
            [self.TabDetegate DidselectTTab:indexPath];
        }
    }else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classTab) {
         return 40;
    }else{
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.classTab) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 199, 60)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(20, 15, 199 - 40, 28);
        label.text = @"闪卡训练";
        label.font = [UIFont systemFontOfSize:24];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-300 - 200, 60)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, (view.width - 80)/3, 60)];
        label1.text = @"名次";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:24];
        label1.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(40+(view.width - 80)/3, 0, (view.width - 80)/3, 60)];
        label2.text = @"答题正确率";
        label2.textColor = [UIColor blackColor];
        label2.font = [UIFont systemFontOfSize:24];
        label2.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label2];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(40+(view.width - 80)/3*2, 0, (view.width - 80)/3, 60)];
        label3.text = @"用时间";
        label3.textColor = [UIColor blackColor];
        label3.font = [UIFont systemFontOfSize:24];
        label3.textAlignment = NSTextAlignmentRight;
        [view addSubview:label3];
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.classTab) {
        return 50;
    }else{
        return 60;
    }
}

@end
