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
@interface RootViewController ()
@property(nonatomic ,strong)SearchView *sv;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *urlStr;


@end

@implementation RootViewController

-(void)loadView
{
    self.sv = [[SearchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _sv;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"搜索";
    
    self.navigationItem.titleView = _sv.searchTF;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:(UIBarButtonItemStyleDone) target:self action:@selector(searchButtonAction:)];
//    [self.sv.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}
-(void)searchButtonAction:(UIButton *)sender
{
    NSString *str = self.sv.searchTF.text;
    
    self.urlStr = [NSString stringWithFormat:@"%@idx=1&key=%@&size=10",url,str];
    
    NSString *newurlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DLog(@"%@",newurlStr);
    
    
    SearchTableViewController *searchVC = [[SearchTableViewController alloc] init];
    
    //传值
    searchVC.aString = newurlStr;
    searchVC.searchWord = self.sv.searchTF.text;
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
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
