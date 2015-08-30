//
//  SearchTableViewController.m
//  Cookbook
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 牛清旭. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchTableViewCell.h"
#import "RequestTool.h"
#import "SearchMessage.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DetailViewController.h"

#define url @"http://api.2meiwei.com/v1/recipe/search/?"
@interface SearchTableViewController ()

// 搜索字段
@property(nonatomic ,strong)NSString *searchText;
// 存储url
@property(nonatomic ,strong)NSString *urlStr;
// 存储数据
@property(nonatomic ,strong)NSMutableArray *dataArray;
// 索引页
@property(nonatomic ,assign)NSInteger idx;


@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.idx = 2;
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.navigationItem.title = @"搜索";
    // 重注册
    [self.tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self makeData];
    
    //============== 刷新===========
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 进入刷新状态会自动调用这个block
        DLog(@"刷新");
        
        [self.tableView.header endRefreshing];
    }];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    // 忽略掉底部inset
    self.tableView.footer.ignoredScrollViewContentInsetTop = 30;
}

#pragma mark -- 上拉加载
-(void)loadMoreData
{
    DLog(@"上拉刷新");
    NSString *urlstr = [NSString stringWithFormat:@"%@idx=%ld&key=%@&size=10",url,_idx,self.searchText];
    
    NSString *newurlStr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DLog(@"%@",newurlStr);
    
    [requestTool requestWithUrl:newurlStr body:nil backValue:^(NSData *value) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *d in dict[@"list"]) {
            
            SearchMessage *m  =[[SearchMessage alloc] init];
            
            [m setValuesForKeysWithDictionary:d];
            [self.dataArray addObject:m];
            
        }
        DLog(@"%@",_dataArray);
        [self.tableView reloadData];
        
        _idx++;
    }];

    
    [self.tableView.footer endRefreshing];
    
}

#pragma mark -- 解析数据
-(void)makeData
{
    // 接收传值
    self.urlStr = self.aString;
    self.searchText = self.searchWord;
    DLog(@"%@",self.urlStr);
    
    [requestTool requestWithUrl:self.urlStr body:nil backValue:^(NSData *value) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *d in dict[@"list"]) {
            
            SearchMessage *m  =[[SearchMessage alloc] init];
            
            [m setValuesForKeysWithDictionary:d];
            [self.dataArray addObject:m];
            
        }
        DLog(@"%@",_dataArray);
        [self.tableView reloadData];
        
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // 判断数据如果是否为空
    if (_dataArray.count  != 0) {
        return _dataArray.count;

    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_dataArray.count != 0) {
        SearchMessage *m = _dataArray[indexPath.row];
        
        cell.titleLabel.text = m.title;
        cell.detailLabel.text = m.message;
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
        cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
        
       self.tableView.separatorStyle  =UITableViewCellSeparatorStyleSingleLine;
     
        [cell.classifyImage sd_setImageWithURL:[NSURL URLWithString:m.cover]];
        [cell.classifyImage sd_setImageWithURL:[NSURL URLWithString:m.cover] placeholderImage:[UIImage imageNamed:@"112.jpg"]];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchMessage *m = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.ID = m.ID;
    detail.navigationItem.title = m.title;
    [self.navigationController pushViewController:detail animated:YES];
    

    
    
}

// ================ 我是分割线 =============================







//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    
//    
//    
//    if (scrollView.contentOffset.y+self.tableView.frame.size.height> self.dataArray.count*120) {
//        NSString *urlstr = [NSString stringWithFormat:@"%@idx=%ld&key=%@&size=10",url,_idx++,self.searchText];
//        
//        NSString *newurlStr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@",newurlStr);
//        
//        [RequestTool requestWithUrl:newurlStr body:nil backValue:^(NSData *value) {
//            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
//            
//            for (NSDictionary *d in dict[@"list"]) {
//                
//                SearchMessage *m  =[[SearchMessage alloc] init];
//                
//                [m setValuesForKeysWithDictionary:d];
//                [self.dataArray addObject:m];
//                
//            }
//            NSLog(@"%@",_dataArray);
//            [self.tableView reloadData];
//            
//
//        }];
//        
//        
//    }
//
//}
//
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
