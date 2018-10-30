//
//  PTLearnListVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTLearnListVC.h"
#import "PTLearnDetailVC.h"

#import "PTLearnModel.h"

#import "PTLearnTableCell.h"

@interface PTLearnListVC ()<UITableViewDelegate,UITableViewDataSource>

{
    /**
     *  知识的数据源
     */
    NSMutableArray *learnDataSource;
    
    
}

@property (nonatomic, strong) UITableView *learnTableView;

@end

@implementation PTLearnListVC

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (learnDataSource.count) {
        
        return learnDataSource.count;
    }else
        return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTLearnTableCell *learnCell = [tableView dequeueReusableCellWithIdentifier:@"learnCell"];
    learnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (learnDataSource.count) {
        
        PTLearnModel *model = learnDataSource[indexPath.row];
        [learnCell configLabelWithModel:model];
        return learnCell;
    }else{
        
        UITableViewCell *nilCell = [tableView dequeueReusableCellWithIdentifier:@"nilCell"];
        return nilCell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTLearnDetailVC *detailVC = [PTLearnDetailVC new];
    PTLearnModel *model = learnDataSource[indexPath.row];
    detailVC.content = model.content;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self setUpNav];
    [self layoutSubControls];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void) loadData {
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@", [[VersionManager shareManager] currentVersion], kZhiShi];
    
    kDLog(@"学习知识接口是：%@", getUrl);
    
    [CHNetWorkSingleton requestAFWithURL:getUrl params:nil httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"学习知识接口请求成功，返回的信息是：%@", result);
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSArray *arr = result[@"data"];
            NSString *info = result[@"info"];
            NSString *code = result[@"code"];
            
            if ([code isEqualToString:@"11"] && [arr isKindOfClass:[NSArray class]]) {
                
                [learnDataSource removeAllObjects];
                for (NSDictionary *dic in arr) {
                    PTLearnModel *model = [PTLearnModel mj_objectWithKeyValues:dic];
                    [learnDataSource addObject:model];
                }
            }else{
                
                UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:info preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [popAlert addAction:popAction];
                [self presentViewController:popAlert animated:YES completion:nil];
            }
            
            
        }
        [self.learnTableView reloadData];
        [self.learnTableView.mj_header endRefreshing];
        [self.learnTableView.mj_footer endRefreshing];
        
    } errorBlock:^(NSError *error) {
        [self.learnTableView.mj_header endRefreshing];
        [self.learnTableView.mj_footer endRefreshing];
        [self.learnTableView reloadData];
    }];
}

- (void) layoutSubControls
{
    
    //1.左边的tableView
    UITableView *learnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    learnTableView.backgroundColor = [UIColor whiteColor];
    learnTableView.delegate = self;
    learnTableView.dataSource = self;
    learnTableView.tag = 888;
    [learnTableView registerClass:[PTLearnTableCell class] forCellReuseIdentifier:@"learnCell"];
    [learnTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nilCell"];
    [self.view addSubview:learnTableView];
    self.learnTableView = learnTableView;
    
    learnTableView.tableFooterView = [UIView new];
    
    self.learnTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
    }];
    
    self.learnTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [self loadData];
    }];
    
    if ([learnTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [learnTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([learnTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [learnTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (void) setUpNav
{
    
    self.title = @"学习知识";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) initDataSource
{
    
    learnDataSource = [NSMutableArray array];
    
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
