//
//  ClassifyTableViewController.m
//  Food
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyTableViewController.h"
#import "ClassifyCell.h"
#import "ClassifyModel.h"
#import "RequestTool.h"
#import "UIImageView+WebCache.h"
#import "ClassifyDetailShowController.h"
#import "Reachability.h"
#import "MJRefresh.h"
#import "GMDCircleLoader.h"
#define Kurl @"http://api.2meiwei.com/v1/collect/list/?idx=1&type=5&size=10"

@interface ClassifyTableViewController ()

// 存储数据
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger i;

@end

@implementation ClassifyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _i = 2;
    
    [self.tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.title  =@"分类";

    // 判断网络
    [self p_reachNetwork];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor cyanColor]];
    
    [self p_headerRefresh];
    
    [self p_footerRefresh];
    
}

#pragma mark --MJRefresh

- (void)p_headerRefresh
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {
        //[GMDCircleLoader hideFromView:self.view animated:YES];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLog(@"下拉刷新");
        //   [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(haha) userInfo:nil repeats:NO];
        [self p_makeData];
        [self.tableView.header endRefreshing];
    }];
    
    }
}

- (void)p_footerRefresh
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    }
}

- (void)loadMoreData
{
    DLog(@"上拉加载");
    
    
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN)
    {
        [requestTool requestWithUrl:[NSString stringWithFormat:@"http://api.2meiwei.com/v1/collect/list/?idx=%ld&type=5&size=10", _i] body:nil backValue:^(NSData *value)
         {
             // 解析Json
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
             NSArray *list = dict[@"list"];
             // 将数据存入模型
             for (NSDictionary *d in list)
             {
                 ClassifyModel *m = [[ClassifyModel alloc] init];
                 [m setValuesForKeysWithDictionary:d];
                 [_dataArray addObject:m];
             }
             // 刷新界面
             [self.tableView reloadData];
             _i ++;
         }];
        [self.tableView.footer endRefreshing];
    
    }
    
}

#pragma mark -网络判断
- (void)p_reachNetwork
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    [ability startNotifier];
    ability.reachableBlock = ^(Reachability *reach){
        [GMDCircleLoader hideFromView:self.view animated:YES];
        [self p_reachNetwork];
        [self p_headerRefresh];
        [self p_footerRefresh];
    };
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        // [self p_makeData];
        [requestTool requestWithUrl:Kurl body:nil backValue:^(NSData *value)
         {
             
             // 初始化数组
             self.dataArray = [NSMutableArray array];
             
             // 解析Json
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
             NSArray *list = dict[@"list"];
             // 将数据存入模型
             for (NSDictionary *d in list)
             {
                 ClassifyModel *m = [[ClassifyModel alloc] init];
                 [m setValuesForKeysWithDictionary:d];
                 [_dataArray addObject:m];
             }
             // 刷新界面
             [self.tableView reloadData];
             [GMDCircleLoader hideFromView:self.view animated:YES];
         }];

        DLog(@"有网络");
    }
    else
    {
        [GMDCircleLoader setOnView:self.view withTitle:@"网络无连接..." animated:YES];
        DLog(@"没有网");
    }

    
}

#pragma mark -解析数据
- (void)p_makeData
{
    // 请求数据
    [requestTool requestWithUrl:Kurl body:nil backValue:^(NSData *value)
    {
        // 初始化数组
        self.dataArray = [NSMutableArray array];
            // 解析Json
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            //DLog(@"------->%@",dict);
            NSArray *list = dict[@"list"];
            // 将数据存入模型
            for (NSDictionary *d in list)
            {
                ClassifyModel *m = [[ClassifyModel alloc] init];
                [m setValuesForKeysWithDictionary:d];
                [_dataArray addObject:m];
            }
            // 刷新界面
            [self.tableView reloadData];
    }];
}

#pragma mark --刷新
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    
//    if ((self.tableView.contentOffset.y + self.tableView.frame.size.height) > (_dataArray.count * 90))
//    {
//        [RequestTool requestWithUrl:[NSString stringWithFormat:@"http://api.2meiwei.com/v1/collect/list/?idx=%d&type=5&size=10", _i] body:nil backValue:^(NSData *value)
//        {
//            // 解析Json
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
//            NSArray *list = dict[@"list"];
//            // 将数据存入模型
//            for (NSDictionary *d in list)
//            {
//                ClassifyModel *m = [[ClassifyModel alloc] init];
//                [m setValuesForKeysWithDictionary:d];
//                [_dataArray addObject:m];
//            }
//            // 刷新界面
//            [self.tableView reloadData];
//            _i ++;
//        }];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
// #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ClassifyModel *model = _dataArray[indexPath.row];
    // 将请求下来的数据赋值给cell
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:20.f];
    }else {
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:13.f];
    }
    // 菜名
    cell.titleLabel.text = model.title;
    // 介绍
    cell.detailLabel.text = model.message;
    cell.detailLabel.alpha = 0.7;
    [cell.classifyImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"picholder"] ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return 150;
    }else {
        return 90;
    }
    
}

#pragma mark -- 测试 需要完善的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyDetailShowController *classifyDSC = [[ClassifyDetailShowController alloc] init];
    // 根据点击的分类，将ID传过去
    ClassifyModel *model = _dataArray[indexPath.row];
    classifyDSC.IDString = model.ID;
    // 将分类的title传过去
    classifyDSC.PassValuetitle = model.title;
    [self.navigationController pushViewController:classifyDSC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
