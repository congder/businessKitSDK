//
//  DistrictDetailsViewController.m
//  SmartCommunity
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "DistrictDetailsViewController.h"

#import "BaseTableViewCell.h"
#import "MenuCell.h"
#import "DistrictPhoneNumTabCell.h"
//#import "DistrictDetailsModel.h"
//#import "CommodityDetailsViewController.h"
//#import "OrderViewController.h"
//#import "UIImage+Addition.h"
//#import "UIButton+WebCache.h"
//#import "UIImageView+WebCache.h"
//#import "PreferentialGoodsModel.h"
//#import "BaiduDituViewController.h"
//#import "RouteQueryViewController.h"
//#import "DistrictPhoneTableViewCell.h"
#import "DistrictIntroTableViewCell.h"
//#import "PreferentialDetailViewController.h"
//#import "DistrictCouponViewController.h"
#import "DistrictMapTableViewCell.h"
//
#import "DistrictLogoTableViewCell.h"
#import "DistricStoreIntroduceViewController.h"
#import "DistrictDetailStoreNameCell.h"
#import "DistrictTitleTableViewCell.h"
//#import "DistrictDetailsModel.h"
#import "DistrictCouponTableViewCell.h"
//#import "NZShareView.h"
//#import "UIScrollView+HandleData.h"
//#import "DistrictLocationTableViewCell.h"
#import "NSString+Regular.h"
#import "NSString+Addition.h"
#import "NetworkAPI.h"
#import "APIOperation.h"
#import "MacroDefine.h"
#import "UIViewController+HUD.h"
#import "LocalCache.h"
#import "HStringPool.h"
#import "CommonUtil.h"
@interface DistrictDetailsViewController (){//2
    NSMutableArray *dataArray;
    NSMutableArray *menuArray;
    NSMutableArray *allzheNumArray;
    NSMutableArray *orderDataArray;
    NSString       *numberStr;
    NSString       *monryStr;
    /***产品的数组****/
    NSMutableArray *storeInfoArr;
    /***优惠券的数组****/
    NSMutableArray *goodsModelArr;
    
    BOOL            productOPEN;
    BOOL            couponOPEN;
    NSString  *cellId;
    

    NSString *latitude;
    NSString *longitude;
    
    IBOutlet NSLayoutConstraint *bottomViewY;
}
/****显示详情的table***/
@property (strong, nonatomic) IBOutlet UITableView *detailsTableView;

@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
/***商品数量的****/
@property (weak, nonatomic) IBOutlet UIImageView *numBgView;
/***确认订单的按钮***/
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;



/***商家详情信息***/
@property(nonatomic,strong)NSMutableArray *bsDetailSectionDataArray;

@property (assign, nonatomic) int amountNum;
@property (strong, nonatomic) NSString *printNum;
@property (strong, nonatomic) DistrictDetailsModel *districtDetailModel;
@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) NSString *storeStr;
@property (strong, nonatomic) NSString *carInfoStr;
@property (strong, nonatomic) NSString *busStr;
@property (strong, nonatomic) NSString *titImageStr;

@property (strong, nonatomic) NSDictionary *detailDict;

//记录执行次数
@property (nonatomic) int numCount;

@end

@implementation DistrictDetailsViewController

- (id)init
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];

   self = [super initWithNibName:@"DistrictDetailsViewController" bundle:bundle];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.view setBackgroundColor:[UIColor blueColor]];
    NSLog(@"第2个2:%@",self.view);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // _bsDetailSectionDataArray = []
    allzheNumArray = [NSMutableArray array];
    
    
    //执行次数
    _numCount = 0;
    
    bottomViewY.constant = -45;
    
    productOPEN = NO;
    [self main];
    
    [self initTitleLabel];
//    [self initLeftButton];
    
    _storeStr    = @"";
    _carInfoStr  = @"";
    _busStr      = @"";
    _titImageStr = @"";
    //_isBussinessCircle = NO;
    storeInfoArr = [NSMutableArray new];
    if (goodsModelArr == nil) {
        goodsModelArr = [NSMutableArray new];
    }
    //DistrictDetailStoreNameCell@"",@"click_event"
    _bsDetailSectionDataArray = [[NSMutableArray alloc]initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"bsDetailImage",@"id",@"DistrictLogoTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:180],@"cell_heigt",nil],
                                 [[NSDictionary alloc] initWithObjectsAndKeys:@"storeName",@"id",@"DistrictDetailStoreNameCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:45],@"cell_height",@"toStoreInfoView:",@"click_event",nil],
//                                 [[NSDictionary alloc] initWithObjectsAndKeys:@"location",@"id",@"DistrictLocationTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:50],@"cell_height",@"toStoreMapView:",@"click_event",nil],
                                 [[NSDictionary alloc] initWithObjectsAndKeys:@"phoneNumber",@"id",@"DistrictPhoneNumTabCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:60],@"cell_height",@"phoneButtonClicked",@"click_event",nil],
                                 /*产品*/
                                 [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"productInfo",@"id",@"MenuCell",@"cell_class",[NSNumber numberWithInt:0],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleDefault],@"selection_style",[NSNumber numberWithInt:145],@"cell_height",@"productCellClickedEvent:",@"click_event",nil],
                               
                                 /*优惠券*/
                                 [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"couponList",@"id",@"DistrictCouponTableViewCell",@"cell_class",[NSNumber numberWithInt:0],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:122],@"cell_height",@"couponCellClickedEvent:",@"click_event",nil],
//                                     [[NSDictionary alloc] initWithObjectsAndKeys:@"mapImage",@"id",@"DistrictMapTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:180],@"cell_height",@"baiduMap",@"click_event",nil],
                                 nil];
    
    // NSLog(@"%lu",(unsigned long)_bsDetailSectionDataArray.count);
    
      NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];
    
    for (NSDictionary *dic in _bsDetailSectionDataArray) {
        cellId = [dic objectForKey:@"cell_class"];
        [_detailsTableView registerNib:[UINib nibWithNibName:cellId bundle:bundle] forCellReuseIdentifier:cellId];
    }
    [_detailsTableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:bundle] forCellReuseIdentifier:@"MenuCell"];
    
    
    
    [self getStoreDetailInfo: YES];
    [mNotificationCenter addObserver:self selector:@selector(reloadDisTabelView:) name:HDisTableViewReload object:nil];
    [mNotificationCenter addObserver:self selector:@selector(disSubNumberReload:) name:HDisNumberReload object:nil];
    //[mNotificationCenter addObserver:self selector:@selector(singalproductNumChangeReload:) name:SINGALPRODUCTNUMCHANGE object:nil];
    //距离信息在 districModel 中，如果没有需要重新定位获取

}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
////    locService.delegate = self;
////    if (![self.districModel.titleName isNotEmpty]) {
////        [self mapLocation];
////    }
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
////    locService.delegate = nil;
//}
////
//- (void)backView {
//    NSNumber *isFromShare = [self valueForKey:@"isFromShare"];
//    if (isFromShare && isFromShare.boolValue) {
//        [ViewUtil backToMainPage:self];
//        [mAppDelegate setMainPageSelectedIndex:0];
//    } else {
//        [super backView];
//    }
//}



- (void)setDistricModel:(DistricModel *)districModel
{
    _districModel = districModel;
    if (_districModel.goodsList != nil && _districModel.goodsList.count > 0) {
        couponOPEN = _districModel.goodsList.count <= 2;
    } else {
        couponOPEN = NO;
    }
}

- (void)main
{
    _amountNum = 0;
    _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",@"0.00"];
    dataArray = [NSMutableArray array];
    orderDataArray = [NSMutableArray array];
    allzheNumArray = [NSMutableArray array];
    
    for (NSString *string in dataArray) {
        DistrictDetailsModel *modelNum = [[DistrictDetailsModel alloc] init];
        modelNum.dishes = string;
        modelNum.number = @"0";
        modelNum.indexPathRow = @"0";
        [allzheNumArray addObject:modelNum];
    }
    _detailsTableView.tableFooterView = [[UIView alloc] init];
    //把tableView的分行线画到头
    [mAppUtils tableViewSeparatorInsetZero:_detailsTableView];
    self.confirmButton.backgroundColor = kSysColor;
}

-(void)initTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 72.0, 32.0)];
    titleLabel.center = CGPointMake(mScreenWidth/2, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"商家详情";
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
}

//数据处理
- (NSString *)storeInfo:(NSString *)string
{
    NSString *telNum = string;
    if ([telNum isKindOfClass:[NSNull class]] || [telNum isEqualToString:@""]) {
        telNum = @"暂无数据";
    }
    return telNum;
}


#pragma mark - 获取店铺详情
- (void)getStoreDetailInfo: (BOOL)isShowLoading
{
    NSArray *parArr = @[self.districModel.storeId, latitude ? latitude : @"", longitude ? longitude : @""];
    NSArray *keyArr = @[@"id", @"latitude", @"longitude"];
    // NSLog(@"-----------------查看商家简单信息模型的数据%@",_districModel.storeId);
    /****获取本地缓存并解析****/
    id cached = [mAppCache cachedObjectForKey:CachePath(StoreInfo, parArr)];
    if (cached) {
        [self processStoreDetail:cached];
    } else {
        if (isShowLoading) {
//            [self showHudInView:self.view hint:STR_COMMON_LOADING];
        }
    }
    [hEncrypt encryptAccountWithUdid:parArr dicKeyArray:keyArr onCompletion:^(NSDictionary *dic) {
        [APIOperation GET:StoreInfo parameters:dic onCompletion:^(id responseData, NSError *error) {
            if (!error) {
                DLog(@"店铺详情查询--%@",responseData);
                [mAppCache storeObject:responseData forKey:CachePath(StoreInfo, parArr) block:nil];
                //                if (!cached) {
                //                    [self processStoreDetail:responseData];
                //                }
                NSDictionary *dataDic = [responseData objectForKey:@"SvcBody"];
                NSString *storeId = dataDic[@"id"];
                if (![storeId isNotEmpty]) {
                    [mAppUtils showHint:@"该店铺不存在"];
//                    [ViewUtil backToMainPage:self];
//                    [mAppDelegate setMainPageSelectedIndex:1];
                    return;
                }
                [self processStoreDetail:responseData];
            } else {
                [self hideHud];
                [_detailsTableView reloadData];
//                mAlertAPIErrorInfo(error);
                if (![mAppUtils hasConnectivity]) {
//                    [_detailsTableView showNoData:mLocalization(@"internet_not_good_message") withImage:[UIImage imageNamed:@"netnotgood"] withSize:CGSizeMake(120, 110) withTop:(mScreenHeight - 356) / 2 - 50];
                }
            }
        }];
    }];
}

- (void)processStoreDetail:(id)responseData {
    NSDictionary *dataDic = [responseData objectForKey:@"SvcBody"];
    self.detailDict = dataDic;
    self.districModel.businessId = dataDic[@"business_id"];
    
    DLog(@"--------------------detailDict-商家详情的字典-----------: %@", dataDic);
    
    NSString *addressStr = [dataDic objectForKey:@"desc"];
    //停车位数据
    NSString *carInfo = [dataDic objectForKey:@"parking"];
    //公交信息
    NSString *busStr = [dataDic objectForKey:@"busInfo"];
    
    if ([carInfo isKindOfClass:[NSNull class]]) {
        _carInfoStr = STR_COMMON_NO_DATA;
    } else {
        _carInfoStr = carInfo;
    }
    if ([busStr isKindOfClass:[NSNull class]]) {
        _busStr = STR_COMMON_NO_DATA;
    } else {
        _busStr = busStr;
    }
    //商户图片
    if ([dataDic objectForKey:@"photo_url"] != nil) {
        _titImageStr = [dataDic objectForKey:@"photo_url"];
    }
    
    //电话号码
    numberStr = [self storeInfo:[dataDic objectForKey:@"telephone"]];
    _storeStr = addressStr;
    [self getStoreProductList];
}

#pragma mark -
#pragma mark - 获取商品资讯列表
- (void)getStoreProductList
{
    NSMutableArray *parArr = [NSMutableArray arrayWithObjects:@"1",@"100", @"03", nil];
    NSMutableArray *keyArr = [NSMutableArray arrayWithObjects:@"pageflag",@"reqnum", @"sort", nil];
    
    if (![self.districModel.businessId isEqualToString:@""]) {
        [parArr addObject:self.districModel.businessId];
        [keyArr addObject:@"business_id"];
    }
    if (![self.districModel.storeId isEqualToString:@""]) {
        [parArr addObject:self.districModel.storeId];
        [keyArr addObject:@"shop_id"];
    }
    
    id cached = [mAppCache cachedObjectForKey:CachePath(StoreProductList, parArr)];
    if (cached) {
        [self processGoodList:cached];
    }
    
    [hEncrypt encryptAccountWithUdid:parArr dicKeyArray:keyArr onCompletion:^(NSDictionary *dic) {
        [APIOperation GET:StoreProductList parameters:dic onCompletion:^(id responseData, NSError *error) {
            [self hideHud];
            if (!error) {
                DLog(@"店铺资讯列表--%@",responseData);
                [mAppCache storeObject:responseData forKey:CachePath(StoreProductList, parArr) block:nil];
                //                if (!cached) {
                //                    [self processGoodList:responseData];
                //                }
                [self processGoodList:responseData];
            } else {
                mAlertAPIErrorInfo(error);
            }
        }];
    }];
}

- (BOOL) isCoupon: (NSDictionary *)goodsDic {
    BOOL flag = false;
    NSArray *productCategoryIdList = goodsDic[@"productCategoryIdList"];
    
    if (productCategoryIdList.count !=0) {
        for (NSDictionary *category in productCategoryIdList) {
            if ([CategoryTypeCoupon isEqualToString:category[@"productCategoryType"]]) {
                flag = true;
                break;
            }
        }
    }
    return flag;
}

- (NSMutableDictionary *) findTableDataWithId: (NSString *) _id {
    if (!_id) {
        return nil;
    }
    NSMutableDictionary *data;
    for (NSMutableDictionary *item in _bsDetailSectionDataArray) {
        if ([_id isEqualToString:item[@"id"]]) {
            data = item;
            break;
        }
    }
    return data;
}

#pragma mark - 获取产品或者优惠券的
- (void)processGoodList:(id)responseData {
    
    NSMutableArray *productArray = [NSMutableArray array];
    NSMutableArray *couponArray = [NSMutableArray array];
    
    NSArray *goodsArr = [[responseData objectForKey:@"SvcBody"] objectForKey:@"goods_list"];
    
    for (NSDictionary *goodsDic in goodsArr) {
        if ([self isCoupon:goodsDic]) {
            [couponArray addObject:goodsDic];
        } else {
            DistrictDetailsModel *disModel = [DistrictDetailsModel districtModel:goodsDic];
            //保留原来商品选择数量
            for (DistrictDetailsModel *model in allzheNumArray) {
                if ([model.goodsId isEqualToString:disModel.goodsId]) {
                    disModel.number = model.number;
                    break;
                }
            }
            if (![disModel.number isNotEmpty]) {
                disModel.number = @"0";
            }
            disModel.indexPathRow = @"0";
            disModel.company = disModel.name;
            [productArray addObject:disModel];
        }
    }
    
    
    [allzheNumArray removeAllObjects];
    [goodsModelArr removeAllObjects];
    [allzheNumArray addObjectsFromArray:productArray];
    [goodsModelArr addObjectsFromArray:couponArray];
    
    
    couponOPEN = goodsModelArr.count <= 2 || couponOPEN;
    
    productOPEN = allzheNumArray.count <=3 || productOPEN;
    
    //如果有优惠券数据就更改优惠券的字典数据
    NSMutableDictionary *couponData = [self findTableDataWithId:@"couponList"];
    if (goodsModelArr.count == 0) {
        [couponData setValue:[NSNumber numberWithInt:0] forKey:@"count"];
    }else{
        [couponData setValue:[NSNumber numberWithInt:(int)goodsModelArr.count] forKey:@"count"];
    }
    
    NSMutableDictionary *productData = [self findTableDataWithId:@"productInfo"];
    if (allzheNumArray.count > 0) {
        [productData setValue:[NSNumber numberWithInt:(int)allzheNumArray.count + 1] forKey:@"count"];
        [productData setValue:@"MenuCell" forKey:@"cell_class"];
        [productData setValue:[NSNumber numberWithInt:145] forKey:@"cell_height"];
    } else {
        [productData setValue:nil forKey:@"click_event"];
    }
    
    [_detailsTableView reloadData];
}



//接收通知   刷新
#pragma mark - 确认订单返回接收通知
- (void)reloadDisTabelView:(NSNotification *)model
{
    DistrictDetailsModel *disDetailModel = (DistrictDetailsModel *)model.object;
    for (int i =0;i <allzheNumArray.count;i++){
        if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
            DistrictDetailsModel *disModel = [allzheNumArray objectAtIndex:i];
            if ([disModel.indexPathRow isEqualToString:disDetailModel.indexPathRow]) {
                //处理合计
                _amountNum = _amountNum - [disDetailModel.number intValue];
                _numLabel.text = [NSString stringWithFormat:@"数量: %ld",(long)_amountNum];
                _printNum =[NSString stringWithFormat:@"%d",[_printNum intValue] - ([disDetailModel.price intValue]*[disDetailModel.number intValue])];
                _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@f",[NSString prodContentString:_printNum]];
                //初始化为0
                disModel.number = @"0";
                [orderDataArray removeObject:disDetailModel];
            }
        }
    }
    [_detailsTableView reloadData];
}

- (void)disSubNumberReload:(NSNotification *)notification
{
    int numberAdd = 0;
    //    float moneyAdd = 0;
    NSString *moneyAdd = @"0";
    NSArray *notArray = (NSArray *)notification.object;
    //NSLog(@"%@",notArray);
    if (notArray != nil && notArray.count != 0) {
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                for (DistrictDetailsModel *model in notArray) {
                    if ([disModel.goodsId isEqualToString:model.goodsId]) {
                        //处理合计
                        if ([model.number intValue] == 0) {
                            [orderDataArray removeObject:model];
                        }
                        disModel.number = model.number;
                    }
                }
            }
        }
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                if (![[NSString stringWithFormat:@"%@",disModel.price] isEqualToString:@""]) {
                    numberAdd = numberAdd + [disModel.number intValue];
                    moneyAdd = [NSString stringWithFormat:@"%.2lf" ,[moneyAdd floatValue] +[[NSString prodContentString:disModel.price] floatValue]*[disModel.number intValue]];
                }
            }
        }
        _amountNum = numberAdd;
        _printNum = moneyAdd;
        _numLabel.text = [NSString stringWithFormat:@"数量: %d",numberAdd];
        _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",moneyAdd];
    }else if (notArray == nil || notArray.count == 0){
        
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                if (![[NSString stringWithFormat:@"%@",disModel.price] isEqualToString:@""]) {
                    numberAdd = numberAdd + [disModel.number intValue];
                    moneyAdd = [NSString stringWithFormat:@"%.2lf" ,[moneyAdd floatValue] +[[NSString prodContentString:disModel.price] floatValue]*[disModel.number intValue]];
                }
            }
        }
        _amountNum = numberAdd;
        _printNum = moneyAdd;
        _numLabel.text = [NSString stringWithFormat:@"数量: %d",numberAdd];
        _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",moneyAdd];
        /***全部删除之后回传的是个空数据需要隐藏购物车*****/
        if (_amountNum != 0) {
            [_bottomView layoutIfNeeded];
            [UIView animateWithDuration:0.3 animations:^{
                bottomViewY.constant = 0;
                [_bottomView layoutIfNeeded];
            }];
            
        }else{
            [_bottomView layoutIfNeeded];
            [UIView animateWithDuration:0.3 animations:^{
                bottomViewY.constant = -45;
                [_bottomView layoutIfNeeded];
            }];
        }
        
        
    }
    [_detailsTableView reloadData];
}

-(void)singalproductNumChangeReload:(NSNotification *)notification{
    DistrictDetailsModel *disDetailModel = (DistrictDetailsModel *)notification.object;
    //NSLog(@"%@",disDetailModel);
    
    [orderDataArray removeAllObjects];
    int numberAdd = 0;
    //    float moneyAdd = 0;
    NSString *moneyAdd = @"0";
    if ([notification.object isKindOfClass:[NSArray class]]) {
        NSArray *notArray = (NSArray *)notification.object;
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                for (DistrictDetailsModel *model in notArray) {
                    if ([disModel.goodsId isEqualToString:model.goodsId]) {
                        //处理合计
                        if ([model.number intValue] == 0) {
                            [orderDataArray removeObject:model];
                        }
                        disModel.number = model.number;
                    }
                }
            }
        }
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                
                if (![disModel.number isEqualToString:@"0"]) {
                    [orderDataArray addObject:[allzheNumArray objectAtIndex:i]];
                }
                
                if (![[NSString stringWithFormat:@"%@",disModel.price] isEqualToString:@""]) {
                    numberAdd = numberAdd + [disModel.number intValue];
                    moneyAdd = [NSString stringWithFormat:@"%.2lf" ,[moneyAdd floatValue] +[[NSString prodContentString:disModel.price] floatValue]*[disModel.number intValue]];
                }
            }
        }
        
        _amountNum = numberAdd;
        _printNum = moneyAdd;
        _numLabel.text = [NSString stringWithFormat:@"数量: %d",numberAdd];
        _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",moneyAdd];
    }else{
        
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                if ([disModel.goodsId isEqualToString:disDetailModel.goodsId]) {
                    //处理合计
                    if ([disDetailModel.number intValue] == 0) {
                        [orderDataArray removeObject:disModel];
                    }
                    disModel.number = disDetailModel.number;
                }
                
            }
        }
        
        for (int i =0;i < allzheNumArray.count; i++) {
            if ([allzheNumArray[i] isKindOfClass:[DistrictDetailsModel class]]){
                DistrictDetailsModel *disModel = allzheNumArray[i];
                if (![disModel.number isEqualToString:@"0"]) {
                    [orderDataArray addObject:[allzheNumArray objectAtIndex:i]];
                }
                
                if (![[NSString stringWithFormat:@"%@",disModel.price] isEqualToString:@""]) {
                    numberAdd = numberAdd + [disModel.number intValue];
                    moneyAdd = [NSString stringWithFormat:@"%.2lf" ,[moneyAdd floatValue] +[[NSString prodContentString:disModel.price] floatValue]*[disModel.number intValue]];
                }
            }
        }
        
        _amountNum = numberAdd;
        _printNum = moneyAdd;
        _numLabel.text = [NSString stringWithFormat:@"数量: %d",numberAdd];
        _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",moneyAdd];
        
    }
    
    if (_amountNum != 0) {
        [_bottomView layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            bottomViewY.constant = 0;
            [_bottomView layoutIfNeeded];
        }];
        
    }else{
        [_bottomView layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            bottomViewY.constant = -45;
            [_bottomView layoutIfNeeded];
        }];
    }
    
    [_detailsTableView reloadData];
}

#pragma mark--确认订单
- (IBAction)orderBtnClicked:(id)sender
{
    if (orderDataArray.count == 0) {
//        [self showHint:STR_DISTRICT_ORDERVC];
    }else{
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
        
        for (DistrictDetailsModel *model in orderDataArray) {
            if (![model.number isEqualToString:@"0"]) {
                [tempArray addObject:model];
            }
        }
        
//        OrderViewController *orderVC = [OrderViewController new];
//        orderVC.array       = tempArray;
//        orderVC.moneyString = _moneyLabel.text;
//        orderVC.districModel = self.districModel;
//        orderVC.isPreOrDisOrDet  = @"Dis";
//        orderVC.stroInfoDetailDic = _detailDict;
//        orderVC.hidesBottomBarWhenPushed = true;
//        [self.navigationController pushViewController:orderVC animated:YES];
        
    }
}

#pragma mark - 判断是否滑倒底部，当只有商品列表的时候滑到最后自动展开
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    NSLog(@"height:%f contentYoffset:%f frame.y:%f",height,contentYoffset,scrollView.frame.origin.y);
    if (distanceFromBottom < height) {
        //如果只有商品滑到底部则自动展开
        if (goodsModelArr.count == 0 && allzheNumArray.count > 3) {
            if (_numCount == 0) {
                 ++_numCount;
                NSIndexPath *index = [NSIndexPath indexPathForRow:4 inSection:4];
                [self productCellClickedEvent:index];
            }
        }else if (allzheNumArray.count == 0 && goodsModelArr.count > 2){
            if (_numCount == 0) {
                 ++_numCount;
                NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:5];
                [self couponCellClickedEvent:index];
            }
        }else if(allzheNumArray.count > 3 || goodsModelArr.count > 2){
            if (_numCount == 0) {
                ++_numCount;
                if (allzheNumArray.count > 3) {
                    NSIndexPath *index = [NSIndexPath indexPathForRow:4 inSection:4];
                    [self productCellClickedEvent:index];
                }
               
                if (goodsModelArr.count > 2) {
                    NSIndexPath *index2 = [NSIndexPath indexPathForRow:3 inSection:5];
                    [self couponCellClickedEvent:index2];
                }
            }
        }
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.detailDict == nil) {
        return 0;
    }
    return _bsDetailSectionDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger couponCount = 0;
    
    //    switch (section) {
    //        case 0: //商家logo
    //        case 1: //商家电话
    //        case 2: //商家介绍
    //        case 3: //商家特色
    //        case 5:
    //            return 1;
    //        case 4:
    //            //展示优惠券数量
    //            couponCount = !couponOPEN ? 3 : goodsModelArr.count;
    //            if (goodsModelArr.count > 0) {
    //                couponCount += 1;
    //            }
    //            return couponCount;
    //        case 6: //商家产品
    //            return  [_bsDetailSectionDataArray[section][@"count"] intValue];;
    //        default:
    //            return 0;
    //    }
 
    if (goodsModelArr.count > 0 && section == 5) {
        couponCount = !couponOPEN ? 3 : [_bsDetailSectionDataArray[section][@"count"] intValue];
        couponCount += 1;
    } else if(allzheNumArray.count > 0 && section == 4){
        couponCount = !productOPEN ? 3 : [_bsDetailSectionDataArray[section][@"count"] intValue];
        //couponCount += 1;
        if (productOPEN) {
            couponCount = couponCount;
        }else{
            couponCount = couponCount + 2;
        }
    }else{
        couponCount = [_bsDetailSectionDataArray[section][@"count"] intValue];
    }
    NSLog(@"section%ld----count%ld",(long)section,(long)couponCount);
    return couponCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *para = _bsDetailSectionDataArray[indexPath.section];
    NSString *identify = para[@"id"];
    NSString *cellClass = para[@"cell_class"];
    NSNumber *selectionStyle = para[@"selection_style"];
    //  NSString *cellClass = nil;
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];
    
    if ([identify isEqual:@"productInfo"]) {
        if (indexPath.row > 0) {
            if (!productOPEN && indexPath.row + 1 == [self tableView:tableView numberOfRowsInSection:indexPath.section]) {
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponMoreTableViewCell"];
                if (cell == nil) {
                    cell = [[bundle loadNibNamed:@"CouponMoreTableViewCell" owner:self options:nil] lastObject];
                }
                return cell;
            }
        } else if (indexPath.row == 0 && allzheNumArray.count > 0) {
            DistrictTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DistrictTitleTableViewCell"];
            if(cell == nil) {
                cell = [[bundle loadNibNamed:@"DistrictTitleTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    } else if ([@"couponList" isEqual:identify]) {
        if (indexPath.row > 0) {
            if (!couponOPEN && indexPath.row + 1 == [self tableView:tableView numberOfRowsInSection:indexPath.section]) {
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponMoreTableViewCell"];
                if (cell == nil) {
                    cell = [[bundle loadNibNamed:@"CouponMoreTableViewCell" owner:self options:nil] lastObject];
                }
                return cell;
            }
        } else if (indexPath.row == 0 && goodsModelArr.count > 0) {
            DistrictIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DistrictTitleTableViewCell"];
            if(cell == nil) {
                cell = [[bundle loadNibNamed:@"DistrictTitleTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.bottomLine.alpha = 0;
//                cell.middleLine.alpha = 0;
            }
            cell.titleLabel.text = @"优惠券列表";
           // cell.iconImage.image = [UIImage imageNamed:@"cNewCoupon"];
            return cell;
        }
    } else if([@"mapImage" isEqualToString:identify]) {
        NSString *lon = self.detailDict[@"longitude"];
        NSString *lat = self.detailDict[@"latitude"];
        if ([CommonUtil isNilOrEmpty:lon] || [CommonUtil isNilOrEmpty:lat]) {
            DistrictIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DistrictIntroTableViewCell"];
            if(cell == nil) {
                cell = [[bundle loadNibNamed:@"DistrictIntroTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = @"店面地址";
            NSString *address = [DistrictMapTableViewCell getMapAddress:self.detailDict];
            cell.introLabel.text = address;
            cell.bottomLine.hidden = YES;
            cell.middleLine.hidden = NO;
            return cell;
        }
    }
    
    
    BaseTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (cell == nil) {
        cell = [[bundle loadNibNamed:cellClass owner:self options:nil] lastObject];
    }
    if ([identify isEqual:@"couponList"]) {
        NSInteger row = goodsModelArr.count == 0 ? indexPath.row : indexPath.row - 1;
        NSInteger totalNum = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        if ([cell isKindOfClass:DistrictCouponTableViewCell.class]) {
            DistrictCouponTableViewCell *_cell = (DistrictCouponTableViewCell *) cell;
            if (!couponOPEN && indexPath.row == totalNum - 2) {
                [_cell hideBottomLine];
            } else {
                [_cell showBottomLine];
            }
        }
        if (row < goodsModelArr.count) {
            [cell setData: goodsModelArr[row]];
        }
    } else if([identify isEqual:@"bsDetailImage"]){
        DistrictLogoTableViewCell *logoCell = (DistrictLogoTableViewCell *)cell;
        logoCell.bottomBlackView.hidden = YES;
        [cell setData:self.detailDict];
    }else if([@"productInfo" isEqualToString:identify]){
        NSInteger row = allzheNumArray.count == 0 ? indexPath.row : indexPath.row - 1;
        DistrictDetailsModel *model;
        if (row < allzheNumArray.count) {
            model = [allzheNumArray objectAtIndex:row];
        }
        MenuCell *menucell = (MenuCell *)cell;
        NSInteger totalNum = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        if (!productOPEN && indexPath.row == totalNum - 2) {
            [menucell hideBottomLine];
        } else {
            [menucell showBottomLine];
        }
        if (productOPEN && indexPath.row == totalNum - 1) {
            [menucell leadingBottomLine];
        } else {
            [menucell leadingEqualLogoBottomLine];
        }
        NSString *oldPrice = [NSString stringWithFormat:@"￥%@",[NSString prodContentString:model.show_price]];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:mRGBToColor(0x999999) range:NSMakeRange(0, oldPrice.length)];
        
        menucell.delegate = self;
        menucell.disModel = model;
        menucell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString prodContentString:model.price]];
        menucell.listLabel.attributedText = attri;
        menucell.indexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row - 1];
        
    }else{
        [cell setData:self.detailDict];
//        if ([identify isEqual:@"location"]) {
//            //     NSString *phone = data[@"telephone"];
//            //NSString *tel = data[@"telNum"];
//            //self.phoneLabel.text = phone.length == 0 ? tel : phone;
//            DistrictLocationTableViewCell *phoneCell = (DistrictLocationTableViewCell*)cell;
//            NSString *distance = self.detailDict[@"distance"];
//            [phoneCell setDistanceLbText:self.districModel.distance ? self.districModel.distance : distance];
//         //   phoneCell.delegate = self;
//        }
    }
    cell.selectionStyle = selectionStyle.integerValue;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = [_bsDetailSectionDataArray[indexPath.section][@"cell_height"] intValue];
    NSString *identify = [_bsDetailSectionDataArray[indexPath.section] objectForKey:@"id"];
    
    if ([identify isEqualToString:@"bsDetailImage"]) {
        height = 180;
    } else if ([@"storeName" isEqualToString:identify]) {
        return [DistrictDetailStoreNameCell getStoreNameStringHeight:self.detailDict[@"name"]];
    } else if ([@"introduceInfo" isEqualToString:identify]) {
        return [DistrictIntroTableViewCell measuredHeight:self.detailDict[@"desc"]];
    } else if ([@"specialInfo" isEqualToString:identify]) {
        return [DistrictIntroTableViewCell measuredHeight:self.detailDict[@"special"]];
    } else if ([@"productInfo" isEqual:identify]) {
        if (indexPath.row == 0) {
            return 60;
        }else if(indexPath.row == 4 && !productOPEN){
            return 54;
        }else{
            return height;
        }
    }else if ([@"couponList" isEqual:identify]){
        if (indexPath.row == 0) {
            return 60;
        } else if (!couponOPEN && indexPath.row == 3) {
            return 54;
        } else {
            NSInteger row = goodsModelArr.count == 0 ? indexPath.row : indexPath.row - 1;
            if (row < goodsModelArr.count) {
                float cellHeight = [DistrictCouponTableViewCell measureHeight:goodsModelArr[row][@"name"]];
                return roundf(cellHeight);
            }
            return 67;
        }
    }
    return height;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [_bsDetailSectionDataArray[indexPath.section] objectForKey:@"id"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [_bsDetailSectionDataArray objectAtIndex:indexPath.section];
    NSString *event = dic[@"click_event"];
    
    if (event != nil && NSSelectorFromString(event) !=nil) {
        if ([@"mapImage" isEqualToString:identify]) {
//            NSString *lon = self.detailDict[@"longitude"];
//            NSString *lat = self.detailDict[@"latitude"];
//            if ([CommonUtil isNilOrEmpty:lon] || [CommonUtil isNilOrEmpty:lat]) {
//                return;
//            }
        }
        if([@"productInfo" isEqualToString:identify]){
            if (allzheNumArray.count == 0) {
                return;
            }else{
                if (indexPath.row == 0) {
                    return;
                }
                
            }
        }
        if ([@"storeName" isEqualToString:identify] || [@"phoneName" isEqualToString:identify]) {
            [self performSelector:NSSelectorFromString(event) withObject:self.detailDict];
            return;
        }
        
        [self performSelector:NSSelectorFromString(event) withObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mAppUtils cellSeparatorInsetZero:cell];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f", scrollView.contentOffset.y);
//}

- (void)deleteCell:(id)sender
{
    [_detailsTableView deselectRowAtIndexPath:[_detailsTableView indexPathForSelectedRow] animated:YES];
}


#pragma mark - clickEvent

-(void)toStoreInfoView:(NSDictionary *)dict{
    
    NSLog(@"====>%@",dict);
    DistricStoreIntroduceViewController *dstorInfoView =[[DistricStoreIntroduceViewController alloc]init];
    dstorInfoView.dataDic = dict;
    [self.navigationController pushViewController:dstorInfoView animated:YES];
}


-(void)toStoreMapView:(NSDictionary *)dict{
    
    DistricModel *tempModel;
    
    if (![self.districModel.titleName isNotEmpty]) {
        tempModel = [DistricModel districMoadel:_detailDict];
    } else {
        tempModel = self.districModel;
    }
    
//    if (tempModel && [tempModel.latitude isNotEmpty] && [tempModel.longitude isNotEmpty]) {
//        BaiduDituViewController *baiduVC = [BaiduDituViewController new];
//        
//        NSDictionary *addressDict = [_detailDict objectForKey:@"address"];
//        
//        NSString *addressString = [NSString stringWithFormat:@"%@",[addressDict objectForKey:@"address"]];
//        baiduVC.canShowLocationNameOrOtherThing = YES;
//        baiduVC.addressString = addressString;
//        baiduVC.latitude = tempModel.latitude;
//        baiduVC.longitude = tempModel.longitude;
//        baiduVC.fromWithHome = @"是";
//        baiduVC.distance = @"";
//        baiduVC.diTuTitle = @"商家地图详情";
//        baiduVC.dataArray = @[tempModel];
//        baiduVC.hidesBottomBarWhenPushed = true;
//        //NSLog(@"乐生活地图-----%@",self.businessArray);
//        
//        [self.navigationController pushViewController:baiduVC animated:YES];
//    }
}


-(void)phoneButtonClicked{
    NSString *phone = self.detailDict[@"telephone"];
    NSString *tel = self.detailDict[@"telNum"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:phone.length == 0 ? tel : phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alertView show];
}

-(void)storeIntroduceCellClickEvent{
//    StoreIntroduceViewController *storeIntroduceVC = [StoreIntroduceViewController new];
//    storeIntroduceVC.addressStr = _storeStr;
//    storeIntroduceVC.carInfo = _carInfoStr;
//    storeIntroduceVC.busStr = _busStr;
//    storeIntroduceVC.titleImageView = _titImageStr;
//    storeIntroduceVC.hidesBottomBarWhenPushed = true;
//    [self.navigationController pushViewController:storeIntroduceVC animated:YES];
}
-(void)couponCellClickedEvent:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        if (!couponOPEN && indexPath.row + 1 == [self tableView:self.detailsTableView numberOfRowsInSection:indexPath.section]) {
            couponOPEN = true;
            [self.detailsTableView reloadData];
            return;
        }
        NSInteger row = goodsModelArr.count == 0 ? indexPath.row : indexPath.row - 1;
        if (row >= 0) {
//            DistrictCouponViewController *districtCouponVC = [DistrictCouponViewController new];
//            districtCouponVC.detailDict = self.detailDict;
//            districtCouponVC.couponId = goodsModelArr[row][@"id"];
//            [self.navigationController pushViewController:districtCouponVC animated:YES];
        }
    }
}

-(void)productCellClickedEvent:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 4) {
        if (!productOPEN && indexPath.row + 1 == [self tableView:self.detailsTableView numberOfRowsInSection:indexPath.section]) {
            NSLog(@"%ld",(long)indexPath.row);
            productOPEN = true;
            [self.detailsTableView reloadData];
            return;
        }
        NSInteger row = allzheNumArray.count == 0 ? indexPath.row : indexPath.row - 1;
        if (row >= 0) {
//            PreferentialDetailViewController *vc = [PreferentialDetailViewController new];
//            vc.stroInfoDetailDic = _detailDict;
//            DistrictDetailsModel *model = [allzheNumArray objectAtIndex:row];
//            vc.detailModel = model;
//            vc.districModel = self.districModel;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",numberStr]]];
    }
}

#pragma mark - MenuCellDelegate
- (BOOL)amountAddNum:(NSString *)number indexPath:(NSString *)indexPath isHidden:(BOOL)isHidden
{
    
    //增加菜品数量
    _amountNum = _amountNum + 1;
    if (_amountNum != 0) {
        [_bottomView layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            bottomViewY.constant = 0;
            [_bottomView layoutIfNeeded];
        }];
        
    }
    
    _numLabel.text = [NSString stringWithFormat:@"数量: %d",_amountNum];
    //总价格
    _printNum = [NSString stringWithFormat:@"%.2lf",[_printNum floatValue] + [number floatValue]];
   
    _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",_printNum];
    BOOL isIndex = YES;
    for (int i = 0;i < orderDataArray.count;i++) {
        DistrictDetailsModel *mode = [orderDataArray objectAtIndex:i];
        if ([mode.indexPathRow isEqualToString:indexPath]) {
            isIndex = NO;
        }
    }
    if (isIndex) {
        [orderDataArray addObject:[allzheNumArray objectAtIndex:[indexPath intValue]]];
    }
    return true;
}

-(void)subNum:(NSString *)number indexPath:(NSString *)indexPath isHidden:(BOOL)isHidden
{
    //减少菜品数量
    _amountNum = _amountNum - 1;
    if (_amountNum == 0) {
        [_bottomView layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            bottomViewY.constant = -45;
            [_bottomView layoutIfNeeded];
        }];
    }
    _numLabel.text = [NSString stringWithFormat:@"数量: %d",_amountNum];
    //总价格
    _printNum = [NSString stringWithFormat:@"%.2lf",[_printNum floatValue] - [number floatValue]];
    _moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@",_printNum];
    
    if (!isHidden) {
        for (int i = 0;i < orderDataArray.count;i++) {
            DistrictDetailsModel *mode = [orderDataArray objectAtIndex:i];
            if ([mode.indexPathRow isEqualToString:indexPath]) {
                [orderDataArray removeObjectAtIndex:i];
            }
        }
    }
}

- (void)dealloc
{
    [mNotificationCenter removeObserver:HDisTableViewReload];
    [mNotificationCenter removeObserver:HDisNumberReload];
    [mNotificationCenter removeObserver:SINGALPRODUCTNUMCHANGE];
}

#pragma mark - 定位设置并开始
- (void)mapLocation {
//    [locService startUserLocationService];
}


@end
