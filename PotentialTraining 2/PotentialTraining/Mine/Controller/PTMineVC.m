//
//  PTMineVC.m
//  PotentialTraining
//
//  Created by admin on 2018/1/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PTMineVC.h"
#import "MainInfoCell.h"
#import "mainClassCell.h"
#import "RankingView.h"
#import "InfoView.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZLocationManager.h"
#import "TZImageManager.h"
@interface PTMineVC ()<UITableViewDelegate,UITableViewDataSource,TableviewDidSelect,DidEditHeadImg,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
{
    //记录右侧选中的
    NSInteger secetRow;
}
@property (nonatomic, strong)UITableView *mainTab;
@property (nonatomic, strong) NSMutableArray *classAry;
/** 个人资料的View */
@property (nonatomic, strong) InfoView *infoView;
/** 排行榜的View */
@property (nonatomic, strong) RankingView *leftView;
@end

@implementation PTMineVC

- (NSMutableArray *)classAry{
    if (_classAry == nil) {
        _classAry = [NSMutableArray arrayWithObjects:@"排行榜",@"成绩查询",@"我的积分",@"我的推广码", nil];
    }
    return _classAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    secetRow = 0;
    [self addSubViews];
}

#pragma mark - 右侧视图
- (void) addSubViews{
    /*
     *
     *tabelview
     *
     */
    self.mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, kScreenHeight-49-64)];
    self.mainTab.backgroundColor = kColor(238, 238, 238);
    self.mainTab.delegate = self;
    self.mainTab.dataSource = self;
    self.mainTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTab.tableFooterView = [UIView new];
    [self.mainTab registerNib:[UINib nibWithNibName:NSStringFromClass([MainInfoCell class]) bundle:nil] forCellReuseIdentifier:@"MainInfoCell"];
    [self.mainTab registerNib:[UINib nibWithNibName:NSStringFromClass([mainClassCell class]) bundle:nil] forCellReuseIdentifier:@"mainClassCell"];
    [self.view addSubview:self.mainTab];
    self.infoView = [[InfoView alloc]initWithFrame:CGRectMake(300, 0, kScreenWidth - 300, kScreenHeight-49-64)];
    self.infoView.HeadImgDetegate = self;
    [self.view addSubview:self.infoView];
    self.infoView.hidden = NO;
    self.leftView = [[RankingView alloc]initWithFrame:CGRectMake(300, 0, kScreenWidth - 300, kScreenHeight-49-64)];
    self.leftView.TabDetegate = self;
    [self.view addSubview:self.leftView];
    self.leftView.hidden = YES;
    
}

#pragma mark - 第二列表的点击事件
- (void)DidselectTTab:(NSIndexPath *)indexPath{
    NSLog(@"%ld----%ld",indexPath.section,indexPath.row);
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MainInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainInfoCell"];
        cell.backgroundColor = kColor(238, 238, 238);
        if (secetRow == 0) {
            cell.backgroundColor = kColor(254, 211, 54);
        }
        return cell;
    }else{
        mainClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainClassCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.classAry[indexPath.row-1]];
        
        if (indexPath.row == 3) {
            cell.subLabel.hidden = NO;
        }else{
            cell.subLabel.hidden = YES;
        }
        if (secetRow == indexPath.row) {
            cell.backgroundColor = kColor(254, 211, 54);
        }else{
            cell.backgroundColor = kColor(238, 238, 238);
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消点击后变色
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    secetRow = indexPath.row;
    [self.mainTab reloadData];
    if (indexPath.row == 0) {
        self.infoView.hidden = NO;
        self.leftView.hidden = YES;
    }else if (indexPath.row == 1 || indexPath.row == 2){
        self.leftView.hidden = NO;
        self.infoView.hidden = YES;
    }else{
        self.leftView.hidden = YES;
        self.infoView.hidden = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160;
    }else{
        return 60;
    }
}

#pragma mark - 保存信息
- (void) didClickSendInfoButton{
    NSLog(@"保存");
    
    NSString *bookUrl = [NSString stringWithFormat:@"%@%@user_id/%@/nickname/%@/sign/%@/sex/%@/age/%@/provice_id/%@/provice_id/%@/city_id/%@/district_id/%@", [[VersionManager shareManager] currentVersion], kSETINFO, @"", @"", @"", @"", @"", @"", @"", @"", @""];
    
    kDLog(@"修改用户信息的接口是：%@", bookUrl);
    [CHNetWorkSingleton requestAFWithURL:bookUrl params:nil httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        kDLog(@"修改用户信息接口返回的数据是：%@", result);
        
        //        [dataArray removeAllObjects];
        //
        //        NSArray *bookArray = result[@"data"];
        //
        //        if ([result[@"code"] isEqualToString:@"11"]) {
        //
        //            for (NSDictionary *bookDic in bookArray) {
        //
        //                PTReadCheckModel *model = [PTReadCheckModel mj_objectWithKeyValues:bookDic];
        //                [dataArray addObject:model];
        //            }
        //        }
        //
        //        //        [self.leftTab reloadData];
        //        [self.classCollectionView reloadData];
        
        //        kDLog(@"书籍是：%@", dataArray);
        
    } errorBlock:^(NSError *error) {
        
        kDLog(@"修改用户信息接口请求失败，错误是：%@", error);
    }];
    
    
}

#pragma mark - 更换头像
- (void)DidselectTHeadImg:(UIImageView *)headImg{
    NSLog(@"VC中更换头像");
    UIAlertController *popAlert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *popAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *popAction2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    [popAlert addAction:popAction];
    [popAlert addAction:popAction2];
    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [vc presentViewController:popAlert animated:YES completion:nil];
    
}
#pragma mark 从这里开始选择照片
#pragma mark 选择照片
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isStatusBarDefault = YES;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.cropRect = CGRectMake(0, (kScreenHeight-kScreenWidth)/2, kScreenWidth, kScreenWidth);
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    
    NSLog(@"相机");
    [self openCamera];
}
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerController Delegate
///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //媒体类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //原图URL
    NSURL *imageAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //如果 picker 没有设置可编辑，那么image 为 nil
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        PHAsset *asset;
        //拍照没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        
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
