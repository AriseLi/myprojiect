//
//  PTTrainVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTTrainVC.h"
#import "PTArrowVC.h"
#import "PTRectangleVC.h"
#import "PTAroundVC.h"
#import "PTCoupleVC.h"
#import "PTSpeed_HVC.h"
#import "PTSpeed_VVC.h"
#import "PTPointVC.h"
#import "PTSchulteCheckVC.h"
#import "PTShanKaVC.h"

#import "trainCell.h"
@interface PTTrainVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *classCollectionView;

@property (nonatomic, strong) NSMutableArray *classAry;
@property (nonatomic, strong) NSMutableArray *dataAry;
@end

@implementation PTTrainVC

- (NSMutableArray *)classAry{
    if (_classAry == nil) {
        _classAry = [NSMutableArray arrayWithObjects:@"视幅",@"视速",@"专注力",@"瞬间记忆练习", nil];
    }
    return _classAry;
}
- (NSMutableArray *)dataAry{
    if (_dataAry == nil) {
        NSArray *ary = @[@[@"发散箭头",@"扩大方块",@"左思右想",@"无独有偶"],@[@"视速（横）",@"视速（竖）"],@[@"一点凝视",@"舒尔特表"],@[@"闪卡训练"]];
        _dataAry = [NSMutableArray arrayWithArray:ary];
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    NSMutableArray *aaa = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
    [aaa insertObject:@"5" atIndex:2];
    NSLog(@"%@", aaa);
}

#pragma mark - 右侧视图
- (void) addSubViews{
    /**
     *
     *我要写一个NB的collectionView
     */
    // 这个是系统提供的布局类，可以布局一些比较规则的布局。
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
    flowLayout.itemSize = CGSizeMake((kScreenWidth- 160)/4, (kScreenWidth- 160)/4);//宽高
    // 设置列的最小间距，cell之间的距离
    flowLayout.minimumInteritemSpacing = 0;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 20;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//纵向滑动
    self.classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 20) collectionViewLayout:flowLayout];
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
#pragma mark - UICollectionView Delegate
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return NO;
}

// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.classAry.count;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *ary = self.dataAry[section];
    return ary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    trainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trainCell" forIndexPath:indexPath];
    NSArray *ary = self.dataAry[indexPath.section];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",ary[indexPath.item]];
    return cell;
    
}

// 点击图片的方法 //已经选中某个item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        switch (indexPath.item) {
            case 0:
                {
                    
                    PTArrowVC *arrowVC = [PTArrowVC new];
                    [self.navigationController pushViewController:arrowVC animated:YES];
                }
                break;
            case 1:
                {
                    PTRectangleVC *rectangleVC = [PTRectangleVC new];
                    [self.navigationController pushViewController:rectangleVC animated:YES];
                }
                break;
            case 2:
                {
                    PTAroundVC *aroundVC = [PTAroundVC new];
                    [self.navigationController pushViewController:aroundVC animated:YES];
                }
                break;
            case 3:
                {
                    PTCoupleVC *coupleVC = [PTCoupleVC new];
                    [self.navigationController pushViewController:coupleVC animated:YES];
                }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        
        switch (indexPath.item) {
            case 0:
            {
                PTSpeed_HVC *speed_HVC = [PTSpeed_HVC new];
                [self.navigationController pushViewController:speed_HVC animated:YES];
            }
                break;
            case 1:
            {
                PTSpeed_VVC *speed_VVC = [PTSpeed_VVC new];
                [self.navigationController pushViewController:speed_VVC animated:YES];
            }
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        
        switch (indexPath.item) {
            case 0:
            {
                PTPointVC *pointVC = [PTPointVC new];
                [self.navigationController pushViewController:pointVC animated:YES];
            }
                break;
            case 1:
            {
                PTSchulteCheckVC *schulteVC = [PTSchulteCheckVC new];
                [self.navigationController pushViewController:schulteVC animated:YES];
            }
                break;
            default:
                break;
        }
    } else{
        
        switch (indexPath.item) {
            case 0:
            {
                PTShanKaVC *shankaVC = [PTShanKaVC new];
                [self.navigationController pushViewController:shankaVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:@"UICollectionViewHeader"
                                                                                       forIndexPath:indexPath];
        
        [headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(20, 20, kScreenWidth-40, 60);
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%@",self.classAry[indexPath.section]];
        [headView addSubview:label];
        return headView;
    }else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth, 80);
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

