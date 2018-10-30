//
//  InfoView.m
//  PotentialTraining
//
//  Created by admin on 2018/2/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "InfoView.h"
#import "VipInfoCell.h"
#import "BRTextField.h"
@interface InfoView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *infoTab;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *tishiLabel;
/** 姓名 */
@property (nonatomic, strong) BRTextField *nameTF;
/** 年龄 */
@property (nonatomic, strong) BRTextField *ageTF;
/** 签名 */
@property (nonatomic, strong) BRTextField *qainTF;
/** 地区 */
@property (nonatomic, strong) BRTextField *addressTF;
/** 确定修改按钮 */
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) NSArray *tagAry;
@end
@implementation InfoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.infoTab];
    }
    return self;
}

- (UITableView *)infoTab{
    if (_infoTab == nil) {
        _infoTab = [[UITableView alloc]initWithFrame:CGRectMake(60, 60, kScreenWidth - 300-120, kScreenHeight - 49-64-120)];
        _infoTab.backgroundColor = [UIColor whiteColor];
        _infoTab.delegate = self;
        _infoTab.dataSource = self;
        _infoTab.scrollEnabled = NO;
        _infoTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTab.tableFooterView = [UIView new];
        [_infoTab registerNib:[UINib nibWithNibName:NSStringFromClass([VipInfoCell class]) bundle:nil] forCellReuseIdentifier:@"VipInfoCell"];
    }
    return _infoTab;
}
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VipInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VipInfoCell"];
    cell.tagLabel.text = self.tagAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            [self setupNameTF:cell];
        }
            break;
        case 1:
        {
            [self setupAgeTF:cell];
        }
            break;
        case 2:
        {
            [self setupQianTF:cell];
        }
            break;
        case 3:
        {
            [self setupAddressTF:cell];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 300-120, 200)];
    [view addSubview:self.headImg];
    [view addSubview:self.tishiLabel];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 300-120, 70)];
    [view addSubview:self.sendBtn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

#pragma mark - 点击上传头像
- (void) tapCovreView:(UIImageView *)headView{
    NSLog(@"点击了头像");
    if ([self.HeadImgDetegate respondsToSelector:@selector(DidselectTHeadImg:)]){
        [self.HeadImgDetegate DidselectTHeadImg:headView];
    }
}
#pragma mark - 保存
- (void)clickSendInfoButton{
    [self endEditing:YES];
    if ([self.HeadImgDetegate respondsToSelector:@selector(didClickSendInfoButton)]){
        [self.HeadImgDetegate didClickSendInfoButton];
    }
}

- (UIImageView *)headImg{
    if (_headImg == nil) {
        _headImg = [[UIImageView alloc]init];
        _headImg.frame = CGRectMake((kScreenWidth - 300-120)/2-60, 20, 120, 120);
        _headImg.clipsToBounds = YES;
        _headImg.layer.cornerRadius = 60;
        _headImg.image = [UIImage imageNamed:@"shaonv"];
        _headImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCovreView:)];
        tap.delegate = self;
        [_headImg addGestureRecognizer:tap];
    }
    return _headImg;
}

- (UILabel *)tishiLabel{
    if (_tishiLabel == nil) {
        _tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, kScreenWidth - 300-120, 60)];
        _tishiLabel.textAlignment = NSTextAlignmentCenter;
        _tishiLabel.font = [UIFont systemFontOfSize:20];
        _tishiLabel.textColor = [UIColor grayColor];
        _tishiLabel.text = @"点击上传修改头像";
    }
    return _tishiLabel;
}
#pragma mark - 设置textfield
- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(75, 0, kScreenWidth - 300-120-60-30, 60)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:18.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = [UIColor blackColor];
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 姓名 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"小泽玛利亚";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 0;
    }
}
#pragma mark - 年龄 textField
- (void)setupAgeTF:(UITableViewCell *)cell {
    if (!_ageTF) {
        _ageTF = [self getTextField:cell];
        _ageTF.placeholder = @"18";
        _ageTF.returnKeyType = UIReturnKeyDone;
        _ageTF.tag = 0;
    }
}
#pragma mark - 签名 textField
- (void)setupQianTF:(UITableViewCell *)cell {
    if (!_qainTF) {
        _qainTF = [self getTextField:cell];
        _qainTF.placeholder = @"小泽玛利亚真的太好看";
        _qainTF.returnKeyType = UIReturnKeyDone;
        _qainTF.tag = 0;
    }
}
#pragma mark - 地区 textField
- (void)setupAddressTF:(UITableViewCell *)cell {
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"日本";
        _addressTF.returnKeyType = UIReturnKeyDone;
        _addressTF.tag = 0;
    }
}

- (UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:0];
        [_sendBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor blueColor];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.clipsToBounds = YES;
        _sendBtn.layer.cornerRadius = 5;
        _sendBtn.frame = CGRectMake((kScreenWidth - 300-120)/2-75, 20, 150, 50);
        [_sendBtn addTarget:self action:@selector(clickSendInfoButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (NSArray *)tagAry{
    if (_tagAry == nil) {
        _tagAry = @[@"姓名",@"年龄",@"简介",@"地区"];
    }
    return _tagAry;
}

@end
