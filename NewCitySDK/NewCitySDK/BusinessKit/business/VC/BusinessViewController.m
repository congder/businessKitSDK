//
//  BusinessViewController.m
//  BusinessKit
//
//  Created by cc on 2017/8/8.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import "BusinessViewController.h"
#import "Masonry.h"
#import "MacroDefine.h"
#import "UIView+BBAutoLayout.h"
#import "DistrictViewController.h"
#import "PreferentialViewController.h"
#import "MainView.h"
#import "HEncryptClass.h"
#import "APIOperation.h"
#import "NetworkAPI.h"
#import "UIViewController+HUD.h"
#import "DistricModel.h"
@interface BusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) DistrictViewController *businessCircleCtrl;
@property (strong, nonatomic) PreferentialViewController *preferentialCtrl;
//@property (strong, nonatomic) NavTitleView *titleView;
//@property (strong, nonatomic) UIViewController *nowVC;
//@property (strong,nonatomic) UIView *segmentView;
//@property (strong,nonatomic) UIView *segmentMoveLineView;

@property(nonatomic,strong)NSArray*businessArray;

@property (strong,nonatomic) NSArray *rightButtonArray;
@property (strong,nonatomic) NSArray *aroundStringArray; // 全城
@property (strong,nonatomic) NSArray *priceStringArray;  // 价格

/***筛选列表***/
@property (strong,nonatomic) UITableView *searchTableView;
/***蒙板***/
@property (strong,nonatomic) UIView *blackMaskView;

//@property (strong, nonatomic) BMKGeoCodeSearch   *searcher;

@property(strong,nonatomic) UIButton *locationButton;
@property (weak, nonatomic) MainView *mainview;
@end

@implementation BusinessViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"===:%@",self.view);
//    [self.view setBackgroundColor:[UIColor yellowColor]];
//    [self.mainview setBackgroundColor:[UIColor cyanColor]];
    NSLog(@"===:%@",self.mainview);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"商圈";
    self.view.backgroundColor =mRGBColor(249, 249, 249);

    [self  createVc ];
    [self cratNavBar];
    
    self.aroundStringArray = [NSMutableArray arrayWithArray:@[@{@"state": @"1000", @"title": @"1000米"},
                                                              @{@"state": @"3000", @"title": @"3000米"},
                                                              @{@"state": @"5000", @"title": @"5000米"},
                                                              @{@"state": @"", @"title": @"全城"}]];
    self.priceStringArray = [NSMutableArray arrayWithArray:@[@{@"state": @"05", @"title": @"人均价格(低)"},
                                                             @{@"state": @"07", @"title": @"人均价格(高)"}]];
}


#pragma mark - 筛选的按钮
-(void)cratNavBar{
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(0, 0, 110, 30);
    [right1 setImage:[UIImage imageNamed:@"triangle_more"] forState:UIControlStateNormal];
    right1.imageEdgeInsets = UIEdgeInsetsMake(right1.frame.size.height/4, right1.frame.size.width-10, right1.frame.size.height/4, 0);
    right1.titleLabel.font = [UIFont systemFontOfSize:13];
    [right1 setTitle:@"全城" forState:UIControlStateNormal];
    [right1 setTitle:@"全城" forState:UIControlStateSelected];
    [right1 setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    right1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    right1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [right1 addTarget:self action:@selector(aroundButtonClicked:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:right1];
    
    
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(0, 0, 100, 30);
    right2.titleLabel.font = [UIFont systemFontOfSize:13];
    right2.titleLabel.frame = CGRectMake(0, 0, 80, 30);
    [right2 setImage:[UIImage imageNamed:@"triangle_more"] forState:UIControlStateNormal];
    right2.imageEdgeInsets = UIEdgeInsetsMake(right2.frame.size.height/4, right2.frame.size.width-10, right2.frame.size.height/4, 0);
    [right2 setTitle:@"人均价格(低)" forState:UIControlStateNormal];
    [right2 setTitle:@"人均价格(低)" forState:UIControlStateSelected];
    
    right2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    right2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [right2 setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    [right2 addTarget:self action:@selector(priceButtonClicked:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:right2];
    
    self.rightButtonArray = @[right2,right1];
    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
}
#pragma mark - 商圈，特惠

- (void)createVc {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DistrictViewController *district = [[DistrictViewController alloc] init];
    
    PreferentialViewController *preferent = [[PreferentialViewController alloc] init];//他?红
    
    [self addChildViewController:district];
    [self addChildViewController:preferent];
    
    MainView *main = [[MainView alloc] init];
    [self.view addSubview:main];
    main.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height-64);
    
    self.mainview = main;
    main.btnViewHeight = 40;
    
    main.btnLineHeight = 2;
    
    main.btnFont       = 14;
    
    main.viewControllers = @[district,preferent];
    
    main.titleArray = @[@"商圈",@"特惠"];
}



#pragma mark - tableViewDeleagte
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //价格按钮
    UIButton *button1 = [self.rightButtonArray objectAtIndex:0];
    //全城按钮
    UIButton *button2 = [self.rightButtonArray objectAtIndex:1];
    
    if (button1.selected) {
        return  self.priceStringArray.count;
    }else if (button2.selected){
        return self.aroundStringArray.count;
    }else{
        return 0;
    }
    return  0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    //价格按钮
    UIButton *button1 = [self.rightButtonArray objectAtIndex:0];
    //全城按钮
    UIButton *button2 = [self.rightButtonArray objectAtIndex:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = hTitleTextColor;
    if (button1.selected == YES) {
        cell.textLabel.text = [self.priceStringArray[indexPath.row] objectForKey:@"title"];
    }else if(button2.selected == YES){
        cell.textLabel.text = [self.aroundStringArray[indexPath.row] objectForKey:@"title"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIButton *button1 = self.rightButtonArray[1];
    
    UIButton *button2 = self.rightButtonArray[0];
    
    
    
    NSString *titleString ;
    
    if (button1.selected == YES) {
        //距离
        titleString = [self.aroundStringArray[indexPath.row] objectForKey:@"title"];
        [button1 setTitle:titleString forState:UIControlStateNormal];
        [button1 setTitle:titleString forState:UIControlStateSelected];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        button1.titleLabel.font = [UIFont systemFontOfSize:13];
        [self aroundButtonClicked:button1];
        self.businessCircleCtrl.distanceCase = self.aroundStringArray[indexPath.row];
        
    }else if (button2.selected == YES){
        titleString = [self.priceStringArray[indexPath.row] objectForKey:@"title"];
        [button2 setTitle:titleString forState:UIControlStateNormal];
        [button2 setTitle:titleString forState:UIControlStateSelected];
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        button2.titleLabel.font = [UIFont systemFontOfSize:13];
        [self priceButtonClicked:button2];
        self.businessCircleCtrl.priceCase = self.priceStringArray[indexPath.row];
    }
//    [self.businessCircleCtrl.districtTableView headerBeginRefreshing];
    [self.businessCircleCtrl districtHeaderRereshing];
}


#pragma mark -  全城  人均价格低  点击事件
-(void)aroundButtonClicked:(UIButton *)button{
    UIButton *button1 = self.rightButtonArray[0];
    button1.selected = NO;
    [button1 setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    
    button.selected = !button.selected;
    [button setTitleColor:hButtonSeleDefaultColor forState:UIControlStateSelected];
    [button setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    [self changeButtonSelected:button];
}

-(void)priceButtonClicked:(UIButton *)button{
    UIButton *button1 = self.rightButtonArray[1];
    button1.selected = NO;
    [button1 setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    
    button.selected = !button.selected;
    [button setTitleColor:hButtonSeleDefaultColor forState:UIControlStateSelected];
    [button setTitleColor:hTitleTextColor forState:UIControlStateNormal];
    [self changeButtonSelected:button];
}

-(void)changeButtonSelected:(UIButton *)seleButton{
    NSString *titleText = seleButton.titleLabel.text;
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *dic in _aroundStringArray) {
        [array1 addObject:[dic objectForKey:@"title"]];
    }
    for (NSDictionary *dic in _priceStringArray) {
        [array2 addObject:[dic objectForKey:@"title"]];
    }
    
    if ([titleText isEqualToString:@"全城"]) {
        CGFloat tableHeight;
        CGFloat  maskHeight;
        if(seleButton.selected){
            tableHeight = self.aroundStringArray.count * 50 ;
            maskHeight = mScreenHeight-64;
        }else
        {
            tableHeight = 0;
            maskHeight = 0;
        }
//        seleButton.selected ==YES? tableHeight = self.aroundStringArray.count * 50 : tableHeight = 0;
//        seleButton.selected == YES? maskHeight = mScreenHeight-64:maskHeight = 0;
        self.searchTableView.frame = CGRectMake(10, 66, mScreenWidth-20, tableHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.blackMaskView.frame = CGRectMake(0, 64, mScreenWidth, maskHeight);
            
            [self.searchTableView reloadData];
        }];
    }else if([titleText isEqualToString:@"人均价格(低)"]){
        CGFloat tableHeight;
        CGFloat  maskHeight;
        if(seleButton.selected){
            tableHeight = self.aroundStringArray.count * 50 ;
            maskHeight = mScreenHeight-64;
        }else
        {
            tableHeight = 0;
            maskHeight = 0;
        }
        self.searchTableView.frame = CGRectMake(10, 66, mScreenWidth-20, tableHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.blackMaskView.frame = CGRectMake(0, 64, mScreenWidth, maskHeight);
            
            [self.searchTableView reloadData];
        }];
    }else if([array1 containsObject:titleText]){
        CGFloat tableHeight;
        CGFloat  maskHeight;
        if(seleButton.selected){
            tableHeight = self.aroundStringArray.count * 50 ;
            maskHeight = mScreenHeight-64;
        }else
        {
            tableHeight = 0;
            maskHeight = 0;
        }
        self.searchTableView.frame = CGRectMake(10, 66, mScreenWidth-20, tableHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.blackMaskView.frame = CGRectMake(0, 64, mScreenWidth, maskHeight);
            
            [self.searchTableView reloadData];
        }];
    }else if ([array2 containsObject:titleText]){
        CGFloat tableHeight;
        CGFloat  maskHeight;
        if(seleButton.selected){
            tableHeight = self.aroundStringArray.count * 50 ;
            maskHeight = mScreenHeight-64;
        }else
        {
            tableHeight = 0;
            maskHeight = 0;
        }
        self.searchTableView.frame = CGRectMake(10, 66, mScreenWidth-20, tableHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.blackMaskView.frame = CGRectMake(0, 64, mScreenWidth, maskHeight);
            
            [self.searchTableView reloadData];
        }];
    }
}
#pragma mark - 加载数据
-(NSArray*)businessArray{
    if (_businessArray==nil) {
        _businessArray=@[];
    }
    return _businessArray;
}
-(void)requestBusinessAndDisplay{
    NSMutableArray*array=[NSMutableArray arrayWithObjects:@"10",@"1", nil];
    NSMutableArray*keyArray=[NSMutableArray arrayWithObjects:@"reqnum",@"pageflag", nil];
    
    [array addObject:@""];
    [keyArray addObject:@"category_id"];
    [array addObject:@""];
    [keyArray addObject:@"radius"];
    [array addObject:@""];
    [keyArray addObject:@"latitude"];
    [array addObject:@""];
    [keyArray addObject:@"longitude"];
    [array addObject:@"05"];
    [keyArray addObject:@"sort"];
//    HCommunityModeClass*communityModel=[mAppCache cachedObjectForKey:HCurrentCommunityModel];
    [array addObject:@100000];
    [keyArray addObject:@"storeAddressID"];
    
    
    [[HEncryptClass sharedHEncryptClassInstance] encryptAccountWithUdid:array dicKeyArray:keyArray onCompletion:^(NSDictionary *dic) {
        
        [APIOperation GET:SERVICESTORELIST parameters:dic onCompletion:^(id responseData, NSError *error) {
            [self hideHud];
            if (!error) {
                NSMutableArray*dataArray=[NSMutableArray array];
                DistricModel*_disModel=[DistricModel new];
                for (NSDictionary*dic in responseData[@"SvcBody"][@"shop_list"]) {
                    _disModel=[DistricModel districMoadel:dic];
                    NSString*address=[NSString stringWithFormat:@"%@%@",[[dic objectForKey:@"address"] objectForKey:@"street"],[[dic objectForKey:@"address"] objectForKey:@"address"]];
                    _disModel.address=address;
                    [dataArray addObject:_disModel];
                    
                }
                self.businessArray=dataArray;
                if (dataArray.count==0) {
                    [self showHint:@"暂无数据"];
                }else{
//                    [self initMapBtn ];
                }
            }
        }];
    }];
    
}


@end
