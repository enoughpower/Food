//
//  RootViewController.m
//  Cookbook
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 牛清旭. All rights reserved.
//

#import "RootViewController.h"
#import "SearchView.h"
#import "SearchTableViewController.h"
@interface RootViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *history;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *urlStr;
@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation RootViewController



- (void)viewWillAppear:(BOOL)animated
{

    [self p_openFile];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self p_setupView];
    //[self p_openFile];

    
    
}

// 布局
- (void)p_setupView
{
    
    UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    back.frame = self.view.bounds;
    back.userInteractionEnabled = YES;
    back.alpha = 0.3;
    [self.view addSubview:back];

    self.searchBar = [[UISearchBar alloc]init];
    self.navigationItem.titleView = _searchBar;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入搜索的内容";
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    
    self.history = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _history.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_history];
    self.history.dataSource = self;
    self.history.delegate = self;
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"清除记录" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(action:) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(0, 0, 200, 50);
    
    
    
    
    
    [self.history setTableFooterView:button];
    // 注册
    [self.history registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}

// 清除搜索记录
- (void)action:(UIButton *)sender
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *historyPath = [documentPath stringByAppendingPathComponent:@"searchHistory.plist"];
    NSFileManager *manager = [[NSFileManager alloc]init];
    [manager removeItemAtPath:historyPath error:nil];
    self.dataArray = nil;
    [self.history reloadData];
    [self p_openFile];

}
// 储存搜索关键字
- (void)p_storeWord
{

    [self.dataArray addObject:self.searchBar.text];
    //DLog(@"%@", _dataArray);
    // 获取文件路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *historyPath = [documentPath stringByAppendingPathComponent:@"searchHistory.plist"];
    // 写入文件
    [_dataArray writeToFile:historyPath atomically:YES];
    //DLog(@"%@", historyPath);
    [self.history reloadData];
    

}

// 获取历史记录
- (void)p_openFile
{
    // 获取文件路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *historyPath = [documentPath stringByAppendingPathComponent:@"searchHistory.plist"];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if ([manager fileExistsAtPath:historyPath]) {
        self.dataArray = [NSMutableArray arrayWithContentsOfFile:historyPath];
        //DLog(@"-%@", _dataArray);
        [self.history reloadData];
    }else{
        self.dataArray = [NSMutableArray array];
    }
    
    


    
}




#pragma mark -- searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *str = searchBar.text;
    self.urlStr = [NSString stringWithFormat:@"%@idx=1&key=%@&size=10",url,str];
    NSString *newurlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //DLog(@"%@",newurlStr);
    SearchTableViewController *searchVC = [[SearchTableViewController alloc] init];
    //传值
    searchVC.aString = newurlStr;
    searchVC.searchWord = self.searchBar.text;
    //储存搜索字段
    [self p_storeWord];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _dataArray[indexPath.row];
    self.urlStr = [NSString stringWithFormat:@"%@idx=1&key=%@&size=10",url,str];
    NSString *newurlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //DLog(@"%@",newurlStr);
    SearchTableViewController *searchVC = [[SearchTableViewController alloc] init];
    //传值
    searchVC.aString = newurlStr;
    searchVC.searchWord = str;
    [self.navigationController pushViewController:searchVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
