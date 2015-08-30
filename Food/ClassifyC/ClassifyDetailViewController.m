//
//  ClassifyDetailViewController.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyDetailViewController.h"
#import "ClassifyCollectionCell.h"
#import "requestTool.h"
#import "UIImageView+WebCache.h"
#import "ClassifyModel.h"
#import "Reachability.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#define Kurl @"http://api.2meiwei.com/v1/collect/"
@interface ClassifyDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collection;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger idx;
@end

@implementation ClassifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _idx = 2;
    [self p_setupLayout];
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
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self p_makeData];
        [self.collection.header endRefreshing];
    }];
}
// 上拉加载
- (void)p_footerRefresh
{
    self.collection.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
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
             [self.collection reloadData];
         }];
        [self.collection.footer endRefreshing];
        
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
    DLog(@"%@", string);
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
         [self.collection reloadData];
     }];
}




#pragma mark --布局
- (void)p_setupLayout
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - 6) / 2, (self.view.bounds.size.width - 6) / 2 + 90);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 2, 2, 2);
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [self.view addSubview:_collection];
    [_collection registerClass:[ClassifyCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
}


#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ClassifyModel *model = _dataArray[indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.label.text = model.title;
    cell.label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
    cell.message.text = model.message;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyModel *m = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.ID = m.ID;
//    detail.imgStr = m.cover;
//    detail.titleStr = m.title;
    [self.navigationController pushViewController:detail animated:YES];
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
