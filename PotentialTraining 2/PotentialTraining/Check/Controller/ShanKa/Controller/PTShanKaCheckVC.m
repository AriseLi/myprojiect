//
//  PTShanKaCheckVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTShanKaCheckVC.h"
#import "ReadLeftCell.h"
#import "ShanKaCell.h"
#import "PTShanKaDetailVC.h"

@interface PTShanKaCheckVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger difficult_length;
    NSInteger difficult_speed;
}
@property (nonatomic, strong)UITableView *leftTab;
/** 记录选中的cell */
@property (nonatomic, strong)ReadLeftCell *selectCell;
@property (nonatomic, strong)UITableView *rightTab;


@property (nonatomic, strong) NSArray *leftArr;

@property (nonatomic, strong) NSArray *rightArr;

@end

@implementation PTShanKaCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftArr = @[@[@"一级（6位）", @"二级（7位）", @"三级（8位）", @"四级（9位）", @"四级（10位）"]];
    self.rightArr = @[@[@"数字测试"]];
    
    difficult_speed = 1;
    
    difficult_length = 6;
    
    
    [self setUpNav];
    [self addSubViews];
}

- (void) setUpNav
{
    
    self.title = @"闪卡测试";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 右侧视图
- (void) addSubViews{
    /*
     *
     *tabelview
     *
     */
    self.leftTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, kScreenHeight-64)];
    self.leftTab.backgroundColor = kColor(238, 238, 238);
    self.leftTab.delegate = self;
    self.leftTab.dataSource = self;
    self.leftTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTab.tableFooterView = [UIView new];
    [self.leftTab registerNib:[UINib nibWithNibName:NSStringFromClass([ReadLeftCell class]) bundle:nil] forCellReuseIdentifier:@"ReadLeftCell"];
    [self.view addSubview:self.leftTab];
    [self.leftTab reloadData];
    
    self.rightTab = [[UITableView alloc]initWithFrame:CGRectMake(200, 0, kScreenWidth-200, kScreenHeight-64)];
    self.rightTab.backgroundColor = [UIColor whiteColor];
    self.rightTab.delegate = self;
    self.rightTab.dataSource = self;
    self.rightTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTab.tableFooterView = [UIView new];
    [self.rightTab registerNib:[UINib nibWithNibName:NSStringFromClass([ShanKaCell class]) bundle:nil] forCellReuseIdentifier:@"ShanKaCell"];
    [self.view addSubview:self.rightTab];
    [self.rightTab reloadData];
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTab) {
        NSArray *arr = self.leftArr[section];
        return arr.count;
    }else{
        NSArray *arr = self.rightArr[section];
        return arr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTab) {
        ReadLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadLeftCell"];
        if (indexPath.row == 0) {
            self.selectCell = cell;
            cell.classLabel.textColor = kColor(253, 134, 9);
        }
        
        NSArray *arr = self.leftArr[indexPath.section];
        
        [cell configCellWithDiff:arr[indexPath.row]];
        
        return cell;
    }else{
        ShanKaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShanKaCell"];
        
        NSArray *arr = self.rightArr[indexPath.section];
        
        [cell configCellWithDiff:arr[indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTab) {
        //取消点击后变色
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        ReadLeftCell *cell = [self.leftTab cellForRowAtIndexPath:indexPath];
        if (self.selectCell == cell) {
            cell.classLabel.textColor = kColor(253, 134, 9);
        }else{
            self.selectCell.classLabel.textColor = [UIColor blackColor];
            cell.classLabel.textColor = kColor(253, 134, 9);
            self.selectCell = cell;
        }
        
        
        difficult_speed = 1;
        
        difficult_length = 6 + indexPath.row;
        
    }else{
        kDLog(@"点击了分类");
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        
        PTShanKaDetailVC *shanKaDetailVC = [PTShanKaDetailVC new];
        shanKaDetailVC.shanKaType = @"数字";
        shanKaDetailVC.length = difficult_length;
        shanKaDetailVC.speed = difficult_speed;
        shanKaDetailVC.isCheck = YES;
        [self.navigationController pushViewController:shanKaDetailVC animated:YES];
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTab) {
       return 50;
    }else{
      return 100;
    }
    
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
