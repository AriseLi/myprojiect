//
//  PTReadCheckVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTReadCheckVC.h"
#import "PTReadCheckDetailVC.h"

#import "ReadLeftCell.h"
#import "trainCell.h"

#import "PTReadCheckModel.h"
@interface PTReadCheckVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

{
    
    NSMutableArray *dataArray;
}
@property (nonatomic, strong)UITableView *leftTab;
@property (nonatomic, strong) UICollectionView *classCollectionView;
/** 记录选中的cell */
@property (nonatomic, strong)ReadLeftCell *selectCell;

@property (nonatomic, strong) NSArray *diffArr;
@end

@implementation PTReadCheckVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self setUpNav];
    [self addSubViews];
    [self loadData:@"0"];
}

- (void) loadData:(NSString *)diffcult{
    
    
    NSString *bookUrl = [NSString stringWithFormat:@"%@%@diffcult/%@", [[VersionManager shareManager] currentVersion], kBOOK, diffcult];
    
    kDLog(@"阅读检测的接口是：%@", bookUrl);
    [CHNetWorkSingleton requestAFWithURL:bookUrl params:nil httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"阅读检测接口返回的数据是：%@", result);
        
        [dataArray removeAllObjects];
        
        NSArray *bookArray = result[@"data"];
        
        if ([result[@"code"] isEqualToString:@"11"]) {
            
            for (NSDictionary *bookDic in bookArray) {
                
                PTReadCheckModel *model = [PTReadCheckModel mj_objectWithKeyValues:bookDic];
                [dataArray addObject:model];
            }
        }
        
//        [self.leftTab reloadData];
        [self.classCollectionView reloadData];
        
//        kDLog(@"书籍是：%@", dataArray);
        
    } errorBlock:^(NSError *error) {
        
        kDLog(@"阅读检测接口请求失败，错误是：%@", error);
    }];
}

- (void) initDataSource{
    
    dataArray = [NSMutableArray array];
    self.diffArr = @[@[@"一级（1000字/分钟）", @"二级（1100字/分钟）", @"三级（1200字/分钟）", @"四级（1300字/分钟）", @"五级（1400字/分钟）", @"六级（1500字/分钟）", @"七级（1600字/分钟）", @"八级（1700字/分钟）", @"九级（1800字/分钟）", @"十级（1900字/分钟）"]];
}

- (void) setUpNav{
    self.title = @"阅读测试";
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
    
    
    
    /**
     *
     *我要写一个NB的collectionView
     */
    // 这个是系统提供的布局类，可以布局一些比较规则的布局。
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
    flowLayout.itemSize = CGSizeMake((kScreenWidth-200- 120)/3, (kScreenWidth-200- 120)/3);//宽高
    // 设置列的最小间距，cell之间的距离
    flowLayout.minimumInteritemSpacing = 0;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 20;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//纵向滑动
    self.classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(200, 0, kScreenWidth-200, kScreenHeight-64) collectionViewLayout:flowLayout];
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    [self.classCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    self.classCollectionView.showsVerticalScrollIndicator = NO;
    self.classCollectionView.backgroundColor = [UIColor whiteColor];
    // 设置代理
    self.classCollectionView.delegate = self;
    self.classCollectionView.dataSource = self;
    [self.classCollectionView registerNib:[UINib nibWithNibName:@"trainCell" bundle:nil] forCellWithReuseIdentifier:@"trainCell"];
    [self.view addSubview:self.classCollectionView];
    
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.diffArr[section];
    return arr.count;
    
    if (dataArray.count) {
        
        return dataArray.count;
    } else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadLeftCell"];
    
    
    
    if (indexPath.row == 0) {
        self.selectCell = cell;
        cell.classLabel.textColor = kColor(253, 134, 9);
    }
    
    if (self.diffArr.count) {
        
        NSArray *arr = self.diffArr[indexPath.section];
        [cell configCellWithDiff:arr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    [self loadData:[NSString stringWithFormat:@"%ld", indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - UICollectionView Delegate
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return NO;
}

// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (dataArray.count) {
        
        return dataArray.count;
    } else {
        
        return 1;
    }
    
    if (section == 0) {
        return 20;
    }else{
        return 15;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    trainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trainCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//    NSArray *ary = self.dataAry[indexPath.section];
//    cell.titleLabel.text = [NSString stringWithFormat:@"%@",ary[indexPath.item]];
    
    if (dataArray.count) {
        
        PTReadCheckModel *model = dataArray[indexPath.row];
        
        [cell configBookInfo:model];
    }
    
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTReadCheckDetailVC *readCheckDetailVC = [PTReadCheckDetailVC new];
    
    PTReadCheckModel *model = dataArray[indexPath.row];
    
    readCheckDetailVC.content = model.content;
    readCheckDetailVC.bookId = model.book_id;
    [self.navigationController pushViewController:readCheckDetailVC animated:YES];
}

- (void) dealloc
{
    
    
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
