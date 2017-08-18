//
//  DistricStoreIntroduceViewController.m
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "DistricStoreIntroduceViewController.h"
#import "BaseTableViewCell.h"
#import "DistrictLogoTableViewCell.h"
#import "DistrictDetailStoreNameCell.h"
#import "DistrictIntroTableViewCell.h"
#import "DistrictFeatureTableViewCell.h"
#import "DistrictStopInfoCell.h"
#import "DistrictBusStationInfoCell.h"

@interface DistricStoreIntroduceViewController (){
    
    
    UITableView *storeIntroduceTable;
    
    NSArray *storeIntriduceDataArray;
    
    NSString  *cellId;
}

@end

@implementation DistricStoreIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initLeftButton];
    [self initTitleLabel];
    
    storeIntroduceTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:storeIntroduceTable];
    storeIntroduceTable.delegate = self;
    
    storeIntroduceTable.dataSource = self;
    storeIntriduceDataArray = [[NSArray alloc]initWithObjects:
                               [[NSDictionary alloc] initWithObjectsAndKeys:@"bsDetailImage",@"id",@"DistrictLogoTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:180],@"cell_heigt",nil],
                               [[NSDictionary alloc] initWithObjectsAndKeys:@"storeName",@"id",@"DistrictDetailStoreNameCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:45],@"cell_height",@"toStoreInfoView:",@"click_event",nil],
                               [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"introduceInfo",@"id",@"DistrictIntroTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",[NSNumber numberWithInt:65],@"cell_height",@"storeIntroduceCellClickEvent",@"click_event",nil],
                               [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"specialInfo",@"id",@"DistrictFeatureTableViewCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",
                                [NSNumber numberWithInt:65],@"cell_height", nil],
                               [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"stopInfo",@"id",@"DistrictStopInfoCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",
                                [NSNumber numberWithInt:65],@"cell_height", nil],
                               [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"busStationInfo",@"id",@"DistrictBusStationInfoCell",@"cell_class",[NSNumber numberWithInt:1],@"count",[NSNumber numberWithInt:UITableViewCellSelectionStyleNone],@"selection_style",
                                [NSNumber numberWithInt:65],@"cell_height", nil],nil];
    
    // NSLog(@"%lu",(unsigned long)_bsDetailSectionDataArray.count);
    
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];
    for (NSDictionary *dic in storeIntriduceDataArray) {
       
        
        cellId = [dic objectForKey:@"cell_class"];
        [storeIntroduceTable registerNib:[UINib nibWithNibName:cellId bundle:bundle] forCellReuseIdentifier:cellId];
    }
}

-(void)initTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 72.0, 32.0)];
    titleLabel.center = CGPointMake(mScreenWidth/2, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"门店介绍";
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return storeIntriduceDataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *para = storeIntriduceDataArray[indexPath.row];
//    DLog(@"%ld",(long)indexPath.row);
    NSString *identify = para[@"id"];
    NSString *cellClass = para[@"cell_class"];
    NSNumber *selectionStyle = para[@"selection_style"];
    //  NSString *cellClass = nil;
    
    if (indexPath.row == 0) {
        cellClass = @"DistrictLogoTableViewCell";
    }
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"NewCitySDK.framework" ofType:nil]];
    
    BaseTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (cell == nil) {
        cell = [[bundle loadNibNamed:cellClass owner:self options:nil] lastObject];
    }
    if ([@"bsDetailImage" isEqualToString:identify]) {
        DistrictLogoTableViewCell *logoCell = (DistrictLogoTableViewCell *)cell;
        logoCell.bottomBlackView.hidden = YES;
    }
    
    if ([@"storeName" isEqualToString:identify]) {
        DistrictDetailStoreNameCell *storeNameCell = (DistrictDetailStoreNameCell *)cell;
        storeNameCell.accessoryType = UITableViewCellAccessoryNone;
        storeNameCell.bottomLineHeight.constant = 4;
    }
    
    if ([@"introduceInfo" isEqualToString:identify]) {
        DistrictIntroTableViewCell *disInfoCell = (DistrictIntroTableViewCell *)cell;
        disInfoCell.iconImage.image = [UIImage imageNamed:@"DistricStore_points2"];
        disInfoCell.titleLabel.text = @"门店简介";
        disInfoCell.middleLine.hidden = YES;
        disInfoCell.bottomLine.hidden = NO;
        disInfoCell.bottomLineLeft.constant = 7;
        disInfoCell.descTopConstraints.constant = 0;
    }
    
    if ([@"specialInfo" isEqualToString:identify]) {
        DistrictFeatureTableViewCell *disFeatureCell = (DistrictFeatureTableViewCell *)cell;
        disFeatureCell.iconImage.image = [UIImage imageNamed:@"DistricStore_points2"];
    }
    [cell setData:self.dataDic];
    cell.selectionStyle = selectionStyle.integerValue;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *para = storeIntriduceDataArray[indexPath.row];
    float height = [para[@"cell_height"] floatValue];
    //  NSLog(@"%f",height);
    NSString *identify = para[@"id"];
    if (indexPath.row == 0) {
        return 180;
    }else if ([@"introduceInfo" isEqualToString:identify]){
        return [DistrictIntroTableViewCell measuredHeight:self.dataDic[@"desc"]];
    }else if ([@"specialInfo" isEqualToString:identify]){
        return [DistrictFeatureTableViewCell measuredHeight:self.dataDic[@"special"]];
    }else if ([@"stopInfo" isEqualToString:identify]){
        return [DistrictStopInfoCell measuredHeight:self.dataDic[@"parking"]];
    }else if ([@"busStationInfo" isEqualToString:identify]){
        return [DistrictBusStationInfoCell measuredHeight:self.dataDic[@"busInfo"]];
    }else if ([@"storeName" isEqualToString:identify]){
        return [DistrictDetailStoreNameCell getStoreNameStringHeight:self.dataDic[@"name"]];
    }
    
    return height;
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
