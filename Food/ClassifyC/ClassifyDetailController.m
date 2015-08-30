//
//  ClassifyDetailController.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyDetailController.h"
#import "ClassifyCell.h"
#import "requestTool.h"
#import "UIImageView+WebCache.h"
#import "ClassifyModel.h"
#import "Reachability.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#define Kurl @"http://api.2meiwei.com/v1/collect/"
//2882487/?idx=1&id=2882487&size=10"

@interface ClassifyDetailController ()

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger idx;

@end

@implementation ClassifyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _idx = 2;
    
    [self.tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"cell"];
    

    
    [self p_reachNetwork];
    

    [self p_headerRefresh];
    [self p_footerRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--MJRefresh
// 下拉刷新
- (void)p_headerRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self p_makeData];
        [self.tableView.header endRefreshing];
    }];
}
// 上拉加载
- (void)p_footerRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
}
// 上拉加载方法
- (void)loadMoreDate
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWWAN || ability.currentReachabilityStatus == ReachableViaWiFi)
    {
        [requestTool requestWithUrl:[NSString stringWithFormat:@"%@%@/?idx=%ld&id=%@&size=10",Kurl, _IDString, _idx, _IDString] body:nil backValue:^(NSData *value)
         {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
             for (NSDictionary *d in dict[@"list"])
             {
                 ClassifyModel *model = [[ClassifyModel alloc] init];
                 [model setValuesForKeysWithDictionary:d];
                 [_dataArray addObject:model];
             }
             _idx ++;
             [self.tableView reloadData];
         }];
        [self.tableView.footer endRefreshing];
    
     }

}

#pragma mark --网络判断
- (void)p_reachNetwork
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN)
    {
        [self p_makeData];
    }
    else
    {
        DLog(@"没有网");
    }
}

#pragma mark -私有方法
- (void)p_makeData
{
    
    // 拼接字符串
    NSString *string = [NSString stringWithFormat:@"%@%@/?idx=1&id=%@&size=10",Kurl, _IDString, _IDString];
    DLog(@"%@", _IDString);
    [requestTool requestWithUrl:string body:nil backValue:^(NSData *value)
    {
        self.dataArray = [NSMutableArray array];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *d in dict[@"list"])
        {
            ClassifyModel *model = [[ClassifyModel alloc] init];
            [model setValuesForKeysWithDictionary:d];
            [_dataArray addObject:model];
        }
        [self.tableView reloadData];
    }];
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
    // 照片
    [cell.classifyImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"picholder"] ];
    // 菜名
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:20.f];
    }else {
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:13.f];
    }
    cell.titleLabel.text = model.title;
    // 介绍
    cell.detailLabel.text = model.message;
    cell.detailLabel.alpha = 0.7;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyModel *m = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.ID = m.ID;
//    detail.imgStr = m.cover;
//    detail.titleStr = m.title;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return 150;
    }else {
        return 90;
    }
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
