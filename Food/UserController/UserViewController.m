//
//  UserViewController.m
//  Food
//
//  Created by lanou3g on 15/7/31.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserViewController.h"
#import "SDImageCache.h"
#import "UserLogInController.h"
#import "UserFavViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CHNotices.h"
#import "UserHistoryController.h"
#import "UserAboutController.h"
@interface UserViewController ()
{
    int i ;
}
@property(nonatomic,strong)NSArray *cellArray;
@property (nonatomic, strong)UILabel *mylabel;
@property (nonatomic, strong)UILabel *userName;
@property (nonatomic, strong)NSArray *searchArray;
@property (nonatomic, strong)UIImageView *backImage;
@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    AVUser *user = [AVUser currentUser];
    DLog(@"%@", user);
    if (user) {
        self.userName.text = user.username;
        //DLog(@"当前用户：%@", user.username);
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:(UIBarButtonItemStyleDone) target:self action:@selector(tapAction:)];
    self.tableView.bounces = NO;
    self.cellArray = [NSArray array];
    _cellArray = @[@"我的收藏", @"最近浏览",@"清除缓存",@"关于我们", @"注销"];
    [self p_setupView];
    i = 1;
    
    

}

- (void)p_setupView
{
    // 背景图
    self.backImage = [[UIImageView alloc]init];
    _backImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    //myImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
    _backImage.backgroundColor = [UIColor grayColor];
    _backImage.alpha = 1;
    [self.tableView setTableHeaderView:_backImage];
    
    // 头像
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.frame = CGRectMake(0, 0, 80, 80);
    photoView.center = _backImage.center;
    photoView.backgroundColor = [UIColor cyanColor];
    photoView.layer.borderWidth = 3;
    photoView.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor;
    photoView.layer.cornerRadius = 40;
    photoView.layer.masksToBounds = YES;
    photoView.image = [UIImage imageNamed:@"userphoto.jpg"];
    //添加手势
    photoView.userInteractionEnabled = YES;
    _backImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [photoView addGestureRecognizer:tap];
    [_backImage addSubview:photoView];
    
    // 用户id
    self.userName = [[UILabel alloc]init];
    _userName.frame = CGRectMake(0, 0, 100, 20);
    _userName.center = CGPointMake(photoView.center.x, CGRectGetMaxY(photoView.frame) + 15);
    _userName.textColor = [UIColor whiteColor];
    _userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _userName.text = @"未登录";
    _userName.textAlignment = NSTextAlignmentCenter;
    [_backImage addSubview:_userName];
    
    
    



}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    if ([_userName.text isEqualToString:@"未登录"]) {
        UserLogInController *sign = [[UserLogInController alloc]init];
        UINavigationController *signNC = [[UINavigationController alloc]initWithRootViewController:sign];
        [self presentViewController:signNC animated:YES completion:nil];

    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经登录,请先注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _cellArray[indexPath.row];
    
    if (indexPath.row == 2) {
        if (self.mylabel == nil) {
            //定义一个在cell最右边显示的mylabel
            self.mylabel = [[UILabel alloc] init];
            _mylabel.font = [UIFont boldSystemFontOfSize:14];
            _mylabel.text = @"Dark0921";
            [_mylabel sizeToFit];
            _mylabel.backgroundColor = [UIColor clearColor];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                _mylabel.frame =CGRectMake(self.view.frame.size.width - _mylabel.frame.size.width - 22,
                                         12, _mylabel.frame.size.width, _mylabel.frame.size.height);
            } else {
                _mylabel.frame =CGRectMake(self.view.frame.size.width - _mylabel.frame.size.width - 20,
                                         12, _mylabel.frame.size.width, _mylabel.frame.size.height);
            }
            
            _mylabel.backgroundColor = [UIColor clearColor];
            _mylabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_mylabel];
        }
        CGFloat s = [[SDImageCache sharedImageCache] checkTmpSize];
        _mylabel.text = [NSString stringWithFormat:@"%.2fMB",s];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
           UserFavViewController *fav = [[UserFavViewController alloc]init];
           [self.navigationController pushViewController:fav animated:YES];
            break;
        }
        case 1:
        {
            UserHistoryController *his = [[UserHistoryController alloc]init];
            [self.navigationController pushViewController:his animated:YES];
            break;
        }
        case 2:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清除缓存么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除", nil];
            alert.tag = 100;
            [alert show];
            break;
            
        }
        case 3:
        {
            UserAboutController *about = [[UserAboutController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
            break;
        }
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定注销当前账户?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 101;
            [alert show];
            break;
        }
        default:
            break;
    }
}



#pragma mark -- AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
            {
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [CHNotices noticesWithTitle:@"删除成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                    [self.tableView reloadData];
                }];
                break;
            }
            default:
                break;
        }
    } else if (alertView.tag == 101) {
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
            {
                AVUser *user = [AVUser currentUser];
                if (user) {
                    [AVUser logOut];
                     [CHNotices noticesWithTitle:@"注销成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                    self.userName.text = @"未登录";
                }else{
                    [CHNotices noticesWithTitle:@"注销失败" Time:1 View:self.view Style:CHNoticesStyleFail];
                }
                break;
            }
            default:
                break;
        }
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
