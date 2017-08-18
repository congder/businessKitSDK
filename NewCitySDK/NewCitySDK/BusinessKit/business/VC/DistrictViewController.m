//
//  DistrictViewController.m
//  BusinessKit
//
//  Created by cc on 2017/8/8.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import "DistrictViewController.h"

#import "MJRefresh.h"
#import "HCommunityModeClass.h"
#import "AppUtils.h"
#import "MacroDefine.h"
#import "CollectionViewCell.h"
#import "APIOperation.h"
#import "UIViewController+HUD.h"
#import "HEncryptClass.h"
#import "UITableView+ExtendMJRefresh.h"
#import "LocalCache.h"
#import "NetworkAPI.h"
#import "HStringPool.h"
#import "HEncryptClass.h"
#import "DistricModel.h"
//#import "UIScrollView+HandleData.h"
#import "DistrictCellV2.h"
#import "NSString+Addition.h"
#import "DistrictDetailsViewController.h"
#import "TestViewController.h"
#define titleViewH 40
static int searchItemHeight = 44;
@interface DistrictViewController ()<UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *dataArray;          //商铺数据源
    NSMutableArray *searchArray;        //搜索数据源
    
    NSMutableArray *categoryArray;      //类别数据源
    NSMutableArray *distanceArray;      //距离数据源
    NSMutableArray *priceArray;         //价格数据源
    
    //    NSDictionary *allTypeCase;
    //    NSDictionary *distanceCase;
    //    NSDictionary *priceCase;
    NSDictionary *tempCase;             //正在开启的搜索tableview的条件
    BOOL searchContainerIsOpen;         //查询选项是否开启
    
     NSString       *_lastUpdatedTimeKey;
    int page;
    long pageNum;
    
    float searchHeight;
    
    AFHTTPSessionManager *AFHttpClient;
    NSString *reqUUID;                  //获取商铺网络请求的uuid
    
    int rotateOffset;  //旋转偏移量
    
    BOOL    noNetworkFlag;
    
    //    BMKLocationService *_locService;
}

@property (strong, nonatomic) HCommunityModeClass *communityModel;

@property(strong,nonatomic) NSArray *collectionTitleArray;
@property(strong,nonatomic) NSArray *collectionImageArray;

@property (nonatomic, assign) BOOL ifSetupConstraints;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property(strong,nonatomic) UIView *collectionBakegroundView;

@property(strong,nonatomic) UICollectionView *collectionView;
@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self main];
    _communityModel.hCityId = @"100000";
    
    _lastUpdatedTimeKey =@"Dictrict";

//    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    if (_locService) {
    //        [_locService stopUserLocationService];
    //        _locService.delegate = nil;
    //        _locService = nil;
    //    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    [self mapLocation];
    
    if (![mAppUtils hasConnectivity]) {
        [self creatNoInternetViewWithFlag:YES];
    } else {
        if (noNetworkFlag) {
            [self creatNoInternetViewWithFlag:NO];
        }
    }
}

- (void) initData {
    dataArray = [NSMutableArray new];
    searchArray = [NSMutableArray new];
    categoryArray = [NSMutableArray new];
    distanceArray = [NSMutableArray arrayWithArray:@[@{@"state": @"1000", @"title": @"1000米"},
                                                     @{@"state": @"3000", @"title": @"3000米"},
                                                     @{@"state": @"5000", @"title": @"5000米"},
                                                     @{@"state": @"", @"title": @"全城"}]];
    priceArray = [NSMutableArray arrayWithArray:@[@{@"state": @"05", @"title": @"人均价格(低)"},
                                                  @{@"state": @"07", @"title": @"人均价格(高)"}]];
    _allTypeCase = @{@"state": @"", @"title": @"全部分类"};
    
    
    _distanceCase = distanceArray[distanceArray.count - 1];
    _priceCase = priceArray[0];
    tempCase = _allTypeCase;
    
    
    if (_latitude == nil) {
        _latitude = @"";
        _longitude = @"";
    }
    page = 0;
    pageNum = 10;
    
    rotateOffset = 10;
    _communityModel = [mAppCache cachedObjectForKey:HCurrentCommunityModel];
}

- (void)main {
    [self.view setBackgroundColor:[UIColor redColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.districtTableView = [UITableView new];
    
    [self.view addSubview:self.districtTableView];
    _districtTableView.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight-titleViewH-64);
    
    if ([mAppUtils hasConnectivity]) {
        [self districStorecategoryRequest];
    }
    
    
//    _collectionBakegroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64-50, mScreenWidth, 200)];
//    _collectionBakegroundView.backgroundColor = mRGBColor(249, 249, 249);
    
//    [self.view addSubview:_collectionBakegroundView];
    
   
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = (mScreenWidth-70*4)/5;
    layout.minimumLineSpacing = 10;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.frame = CGRectMake(0, 0, mScreenWidth, 190);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
//    [_collectionBakegroundView addSubview:_collectionView];
    
    _collectionView.frame = CGRectMake(0, 64-50, mScreenWidth, 200);
    _collectionView.backgroundColor = mRGBColor(255, 255, 255);
     [_districtTableView setTableHeaderView:_collectionView];
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:bundle];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    _collectionTitleArray = @[@"最佳零食",@"购物",@"休闲娱乐",@"美食",@"优惠券",@"生活服务",@"丽人",@"全部分类"];
    _collectionImageArray = @[@"snacks",@"shopping",@"entertainment",@"food",@"coupon",@"lifeService",@"beauty",@"whole"];
    
    
    _districtTableView.delegate = self;
    _districtTableView.dataSource = self;
    
//    
//    [_districtTableView addHeaderWithTarget:self action:@selector(districtHeaderRereshing) dateKey:@"Dictrict"];
//    [_districtTableView addFooterWithTarget:self action:@selector(districtFooterRefreshing)];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(districtHeaderRereshing)];
//    header.lastUpdatedTimeKey = _lastUpdatedTimeKey;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(districtFooterRefreshing)];
    footer.hidden = YES;

    [_districtTableView setMj_header:header];
    [_districtTableView setMj_footer:footer];
   
    [_districtTableView setTableFooterView: [UIView new]];
    
    [_districtTableView setSeparatorColor:[UIColor clearColor]];


    [mNotificationCenter addObserver:self selector:@selector(cityHasChanged:) name:HCurrentCityChanged object:nil];
    
//    if ([[AppUtils sharedAppUtilsInstance] hasConnectivity]) {
                [_districtTableView.mj_header beginRefreshing];
//    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {

        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"NewCitySDK.framework" ofType:nil]];
        cell = [[[UINib nibWithNibName:@"CollectionViewCell" bundle:bundle] instantiateWithOwner:self options:nil] lastObject];
    }
    
    //    NSString *titleText = [dic2 objectForKey:@"itemTitle"];
    //    cell.itemImageView.image = [UIImage imageNamed:[dic2 objectForKey:@"itemImageName"]];
    //    cell.itemTitleLb.text = titleText;
    NSInteger index = 0;
    if (indexPath.section == 0) {
        index = indexPath.row;
    }else{
        index = 4+indexPath.row;
    }
    cell.backgroundColor = mRGBColor(255, 255, 255);
    cell.itemImageView.image = [UIImage imageNamed:_collectionImageArray[index]];
    cell.itemTitleLb.text = _collectionTitleArray[index];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, (mScreenWidth-70*4)/5, 10, (mScreenWidth-70*4)/5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70 , 70);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:index];
//    for (int i = 0; i < categoryArray.count; i++) {
//        NSDictionary *dic = categoryArray[i];
//        NSString *title = [dic objectForKey:@"title"];
//        if ([cell.itemTitleLb.text  isEqualToString:title]) {
//            _allTypeCase = categoryArray[i];
//        }
//    }
//    CateGrayDistricViewController *cateGray = [[CateGrayDistricViewController alloc]init];
//    cateGray.allTypeCase = _allTypeCase;
//    cateGray.distanceCase = _distanceCase;
//    cateGray.priceCase = _priceCase;
//    cateGray.latitude = _latitude;
//    cateGray.longitude = _longitude;
//    cateGray.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cateGray animated:YES];
}


#pragma mark - 断网图
- (void)creatNoInternetViewWithFlag:(BOOL)flag{
    //netnotgood
    noNetworkFlag = flag;
//    if (flag) {
//        [_districtTableView showNoData:mLocalization(@"internet_not_good_message") withImage:[UIImage imageNamed:@"netnotgood"] withSize:CGSizeMake(120, 110) withTop:(mScreenHeight - 356) / 2 - 50];
//    }else{
//        [_districtTableView hideNoData];
//    }
    
}



- (void)dealloc
{
    [mNotificationCenter removeObserver:self name:HCurrentCityChanged object:nil];
    
}

- (void)districtHeaderRereshing {
    page = 1;
    [self districListRequest];
}

- (void)districtFooterRefreshing {
    if (_districtTableView.mj_header.isRefreshing) {
        [_districtTableView footerEndRefreshing];
        return;
    }
    page++;
    [self districListRequest];
}

-(void)cityHasChanged:(NSNotification *)sender {
    if (sender.object) {
        HCommunityModeClass *communityModel = [HCommunityModeClass new];
        communityModel.hCityId = sender.object[@"objectId"];
        if (_communityModel != nil && ![_communityModel.hCityId isEqualToString:communityModel.hCityId]) {
            _communityModel = communityModel;
        }
//        if ([self.districtTableView noDataView] && [self.districtTableView noDataView].alpha == 1) {
//            [[[self.districtTableView noDataView] mj_header] beginRefreshing];
//        } else {
            [self.districtTableView headerBeginRefreshing];
//        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}



#pragma mark 分类列表  没有数据
- (void)districStorecategoryRequest
{
    NSArray *array = [NSArray arrayWithObject:@"03"];
    NSArray *keyArray = [NSArray arrayWithObject:@"status"];
    NSArray *cached = [mAppCache cachedObjectForKey:CachePath(SERVICESTORECATEGORY, keyArray)];
    if (cached) {
        [self processCategoryListArray:cached];
    }
    [self showHudInView:self.view hint:STR_COMMON_LOADING];
    [hEncrypt encryptAccountWithNotUdid:array dicKeyArray:keyArray onCompletion:^(NSDictionary *dic) {
        [APIOperation GET:SERVICESTORECATEGORY parameters:dic onCompletion:^(id responseData, NSError *error) {
            DLog(@"商圈分类-----%@",responseData);
            [self hideHud];
            if (!error) {
                NSArray *listArray = [[responseData objectForKey:@"SvcBody"] objectForKey:@"storeCategoryList"];
                [mAppCache storeObject:listArray forKey:CachePath(SERVICESTORECATEGORY, keyArray) block:nil];
                [self processCategoryListArray:listArray];
            } else {
                DLog(@"%@",error);
                mAlertAPIErrorInfo(error);
            }
        }];
    }];
}

-(void) processCategoryListArray: (NSArray *)array {
    [categoryArray removeAllObjects];
    [categoryArray addObject:@{@"state": @"", @"title": @"全部分类"}];
    for (NSDictionary *dic in array) {
        if ([@"0" isEqualToString:[dic objectForKey:@"level"]]) {
//            DisStorecategoryModel *disStoreModel = [DisStorecategoryModel districMoadel:dic];
//            [categoryArray addObject:@{@"state": disStoreModel.storeCategoryId, @"title": disStoreModel.storeCategoryName}];
        }
    }
    
    }

#pragma mark--商家列表
- (void)districListRequest
{
    if (!AFHttpClient) {
        AFHttpClient = [APIOperation getAFHttpClient:SERVICESTORELIST];
    }
    [[AFHttpClient operationQueue] cancelAllOperations];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld", pageNum],[NSString stringWithFormat:@"%d", page], nil];
    NSMutableArray *keyArray = [NSMutableArray arrayWithObjects:@"reqnum",@"pageflag", nil];
    
    [array addObject:_allTypeCase[@"state"]];
    [keyArray addObject:@"category_id"];
    
    [array addObject:_distanceCase[@"state"]];
    [keyArray addObject:@"radius"];
    
    [array addObject:_latitude];
    [keyArray addObject:@"latitude"];
    [array addObject:_longitude];
    [keyArray addObject:@"longitude"];
    
    [array addObject:[_priceCase objectForKey:@"state"]];
    [keyArray addObject:@"sort"];
    
    [array addObject:WholeCountryCode];
    [keyArray addObject:@"storeAddressId"];
    
    [array addObject:@"Y"];
    [keyArray addObject:@"showInCommercialZone"];
    
    reqUUID = [[NSUUID UUID] UUIDString];
    NSString *tempUuid = reqUUID;
    [hEncrypt encryptAccountWithUdid:array dicKeyArray:keyArray onCompletion:^(NSDictionary *dic) {
        [APIOperation GET:AFHttpClient url:SERVICESTORELIST parameters:dic onCompletion:^(id responseData, NSError *error) {
            if (![tempUuid isEqualToString:reqUUID]) {
                return;
            }
#pragma mark - 请求数据
            pageNum = 10;
            [self.districtTableView headerEndRefreshing];
            [self.districtTableView footerEndRefreshing];
            DLog(@"---商家列表---%@",responseData);
            if (!error) {
                NSArray *shopList = responseData[@"SvcBody"][@"shop_list"];
                if (page == 1) {
                    [dataArray removeAllObjects];
                }
                for (NSDictionary *dic in shopList) {
                    DistricModel *disModel = [DistricModel districMoadel:dic];
                    NSString *address = [NSString stringWithFormat:@"%@%@",[[dic objectForKey:@"address"] objectForKey:@"street"],[[dic objectForKey:@"address"] objectForKey:@"address"]];
                    disModel.address = address;
                    [dataArray addObject:disModel];
                }
                NSLog(@"dataArray:  %@",dataArray);
                if (dataArray.count == 0) {
//                    [_districtTableView showNoData:mLocalization(@"district_list_no_data") withImage:[UIImage imageNamed:@"icon-dianpu"] withSize:CGSizeMake(120, 110) withTop:(mScreenHeight - 356) / 2 - 50];
                } else {
//                    [_districtTableView hideNoData];
                    [self.parentViewController setValue:dataArray forKey:@"businessArray"];
                }
                
                if (shopList.count < pageNum) {
                    [_districtTableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [_districtTableView.mj_footer resetNoMoreData];
                }
                page = (int)(dataArray.count % 10 == 0 ? dataArray.count / 10 : dataArray.count / 10 + 1);
                [self.districtTableView reloadData];
            } else {
                DLog(@"%@",error);
                if ([mAppUtils hasConnectivity]) {
                    mAlertAPIErrorInfo(error);
                }
                
            }
        }];
    }];
}

#pragma mark - 设置类别查询
- (void)setCategoryType:(NSString *)type {
    for (NSDictionary *dic in categoryArray) {
        NSString *title = dic[@"title"];
        if ([title isEqualToString:type]) {
            _allTypeCase = dic;
            break;
        }
    }
    
//    if ([self.districtTableView noDataView] && [self.districtTableView noDataView].alpha == 1) {
//        [[[self.districtTableView noDataView] mj_header] beginRefreshing];
//    } else {
//        [self.districtTableView headerBeginRefreshing];
//    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection: %ld",dataArray.count);
    if ([tableView isEqual:_districtTableView]) {//没走啊
        return dataArray.count;//这
    }
    return 0;//searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_districtTableView]) {
        static NSString *districtCell = @"DistrictCellV2";
        DistrictCellV2 *cell = [tableView dequeueReusableCellWithIdentifier:districtCell];
        if (cell == nil) {
            cell = [[DistrictCellV2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:districtCell];
            UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
            backgroundView.backgroundColor = mRGBColor(240, 240, 240);
            cell.selectedBackgroundView = backgroundView;
        }
        DistricModel *model = dataArray[indexPath.row];
        cell.disModel = model;
        cell.avgPriceLabel.text = [NSString stringWithFormat:@"人均:￥ %@",[NSString prodContentString:model.avgPrice]];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //cell.distanceLabel.text = [];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        [cell refreshCouponUI];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_districtTableView]) {
        DistricModel *model = dataArray[indexPath.row];
        
        if ([model hasGoodsList]) {
            return 129;
        }
        return 110;
    }
    return searchItemHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    TestViewController *vc = [[TestViewController alloc]init];
//    vc.view.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
//    if ([tableView isEqual:_districtTableView]) {
        DistricModel *districModel = dataArray[indexPath.row];
        DistrictDetailsViewController *districtDetailsVC = [DistrictDetailsViewController new];
        districtDetailsVC.isBussinessCircle = YES;
        districtDetailsVC.districModel = districModel;
        districtDetailsVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:districtDetailsVC animated:YES];
//    } else {
//        NSDictionary *data = searchArray[indexPath.row];
//        if (tempCase == _allTypeCase) {
//            _allTypeCase = data;
//        } else if (tempCase == _distanceCase) {
//            _distanceCase = data;
//        } else if (tempCase == _priceCase) {
//            _priceCase = data;
//        }
        //      [self refreshSearchContainer];
//        if ([self.districtTableView noDataView] && [self.districtTableView noDataView].alpha == 1) {
//            [[[self.districtTableView noDataView] mj_header] beginRefreshing];
//        } else {
            [self.districtTableView headerBeginRefreshing];
//        }
//    }
}

- (void)updateViewConstraints {
    NSLog(@"updateViewConstraints");
    if (!self.didSetupConstraints) {
        UIView *superView = self.view;
        MASAttachKeys(superView,  self.districtTableView);
        
        
//        [self.districtTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.left.equalTo(superView);
//            make.right.equalTo(superView);
//            make.bottom.equalTo(superView);
//            //            make.bottom.equalTo(superView).offset(@-50);
//        }];
        
        self.didSetupConstraints = YES;
    }
    
    
    
    [super updateViewConstraints];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//   
//    return self.collectionBakegroundView;
//}




@end
