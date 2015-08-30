//
//  CollectionViewController.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "CollectionViewController.h"
#import "requestTool.h"
#import "HomeMessage.h"
#import "DetailMessage.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewCell.h"
#import "GMDCircleLoader.h"
#import "Reachability.h"
#import "SDCycleScrollView.h"
#import "DetailViewController.h"
#import "MJRefresh.h"

#define urlhome @"http://api.2meiwei.com/v1/index"
#define urlhome1 @"http://api.2meiwei.com/v1/recipe/list/?&"
@interface CollectionViewController ()<SDCycleScrollViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    int i;
    int num;
}
@property (nonatomic, strong)UICollectionView *collection;
@property (nonatomic, strong)NSMutableArray *imgArray;
@property (nonatomic, strong)NSMutableArray *cellArray;
@end

@implementation CollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        num = 3;
    }else {
        num = 2;
    }
    i = 1;
    
    [self p_setupView];
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    reach.reachableBlock = ^(Reachability *reach){
        [self p_makeData];
        [self p_footerRefresh];
        
    };
    if (reach.isReachable == YES) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        [self p_makeData];
    }else{
        [GMDCircleLoader setOnView:self.view withTitle:@"网络无连接..." animated:YES];
    }
    self.navigationItem.title = @"首页";
    [self p_footerRefresh];

    
    
}


- (void)p_setupView
{
    


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (self.view.bounds.size.width - 4 - (num - 1)*2) / num;
    layout.itemSize = CGSizeMake(width,  width*4 / 3);
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width /16*9);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 2, 2, 2);
    
    

    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 49) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    
    //_collection.bounces = NO;
    _collection.dataSource = self;
    _collection.delegate = self;
    
    [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collection];
    

}

- (void)p_makeData
{

    [requestTool requestWithUrl:urlhome body:nil backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        self.imgArray = [NSMutableArray array];

        NSDictionary *data = dict[@"data"];
        for (NSDictionary *dic in data[@"slider"]) {
                HomeMessage *m = [[HomeMessage alloc]init];
                [m setValuesForKeysWithDictionary:dic];
                [self.imgArray addObject:m];
        }
        for (NSDictionary *dic in data[@"hot"]) {
            HomeMessage *m = [[HomeMessage alloc]init];
            [m setValuesForKeysWithDictionary:dic];
            [self.imgArray addObject:m];
        }
        
        // 加载轮播图
        NSMutableArray *images = [NSMutableArray array];
        NSMutableArray *titles = [NSMutableArray array];
        for (HomeMessage *m in _imgArray) {
            [images addObject:m.ccover];
            [titles addObject:m.title];
        }
        SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width /16*9 - 35) imageURLStringsGroup:images];
        cycle.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycle.delegate = self;
        cycle.titlesGroup = titles;
        cycle.dotColor = [UIColor lightGrayColor];
        cycle.placeholderImage = [UIImage imageNamed:@"picholder"];
        cycle.autoScrollTimeInterval = 2.0;
        [self.collection addSubview:cycle];


        // 加载标题
        UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY(cycle.frame), self.view.bounds.size.width - 10, 35)];
        textlabel.text = @"菜谱排行";
        textlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        textlabel.textColor = [UIColor blackColor];
        //textlabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
        [self.collection addSubview:textlabel];
 

    }];
    // 加载collectionView
    NSString *urlstr = [NSString stringWithFormat:@"%@&idx=%d&size=30&orderby=viewnum", urlhome1, i ++];
    DLog(@"%@", urlstr);
    [requestTool requestWithUrl:urlstr body:nil backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        if (_cellArray == nil) {
            self.cellArray = [NSMutableArray array];
        }
        for (NSDictionary *d in dict[@"list"]) {
            HomeMessage *m = [[HomeMessage alloc]init];
            [m setValuesForKeysWithDictionary:d];
            [_cellArray addObject:m];
            [self.collection reloadData];
            
        }
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
 
    
}

- (void)p_footerRefresh
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {
        self.collection.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            DLog(@"上拉加载");
            //   [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(haha) userInfo:nil repeats:NO];
            [self p_makeData];
            [self.collection.footer endRefreshing];
        }];
        
    }
}


#pragma mark -- dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     HomeMessage*m = _cellArray[indexPath.item];
    cell.myLabel.text = m.title;
    cell.myLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:m.cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
   
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    HomeMessage *m = _cellArray[indexPath.item];
    detail.ID = m.ID;
//    detail.titleStr = m.title;
//    detail.imgStr = m.cover;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    DetailViewController *detail = [[DetailViewController alloc] init];
    HomeMessage *m = _imgArray[index];
    detail.ID = m.objid;
//    detail.titleStr = m.title;
//    detail.imgStr = m.ccover;
    //detail.navigationItem.title = m.title;
    [self.navigationController pushViewController:detail animated:YES];
    

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
