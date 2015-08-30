//
//  UserFavViewController.m
//  Food
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserFavViewController.h"
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CHNotices.h"
@interface UserFavViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
     int num;
}
@property (nonatomic, assign)NSIndexPath *indexPath;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UICollectionView *collection;
@end

@implementation UserFavViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    AVUser *user = [AVUser currentUser];
    AVQuery *querty = [AVQuery queryWithClassName:@"favorite"];
    [querty selectKeys:@[@"messageid", @"img", @"title",@"username"]];
    [querty whereKey:@"username" containsString:user.username];
    DLog(@"%@", user.username);
    [querty findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dataArray = objects.mutableCopy;
        [self.collection reloadData];
    }];
    
}


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
    
    self.navigationItem.title = @"我的收藏";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.dataArray = [NSMutableArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (self.view.bounds.size.width - 4 - (num - 1)*2) / num;
    layout.itemSize = CGSizeMake(width,  width*4 / 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 2, 2, 2);
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    
    _collection.bounces = NO;
    _collection.dataSource = self;
    _collection.delegate = self;
    
    [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collection];
    
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.collection addGestureRecognizer:longPress];
    
    
    
}

// 长按手势
- (void)longPressGestureRecognized:(id)sender {
    // 通过检测触摸在collectionView上的位置，得出indexPath
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    CGPoint location = [longPress locationInView:self.collection];
    self.indexPath = [self.collection indexPathForItemAtPoint:location];
    // indexPath 可能为空（如果触摸到headView或者没有cell的空白处）
    // LongPressGestur 会走多次，这里我们只需要他走一次，即只用Begin的这一个事件
    if ((state == UIGestureRecognizerStateBegan) && (_indexPath)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除该条么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        //DLog(@"%ld", _indexPath.item);
    }
    
}

// alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            // 通过id找到对应要删的那条记录
            NSString *objcStr = self.dataArray[self.indexPath.item][@"objectId"];
            AVQuery *querty = [AVQuery queryWithClassName:@"favorite"];
            AVObject *obj = [querty getObjectWithId:objcStr];
            [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [CHNotices noticesWithTitle:@"删除成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                    [self.dataArray removeObjectAtIndex:_indexPath.item];
                    [self.collection deleteItemsAtIndexPaths:@[_indexPath]];
                }else{
                    [CHNotices noticesWithTitle:@"删除失败" Time:1 View:self.view Style:CHNoticesStyleFail];
                }
            }];
            //DLog(@"删除第%ld个菜谱", _indexPath.item);
            break;
        }
        default:
            break;
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *img = self.dataArray[indexPath.item][@"img"];
    NSString *title = self.dataArray[indexPath.item][@"title"];
    //DLog(@"%@", _dataArray);
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.myLabel.text = title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *messageID = self.dataArray[indexPath.row][@"messageid"];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.ID = messageID;
    //DLog(@"%@", _dataArray[indexPath.item][@"objectId"]);
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
