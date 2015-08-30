//
//  TabBarViewController.m
//  Food
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TabBarViewController.h"
#import "CollectionViewController.h"
#import "RootViewController.h"
#import "ClassifyTableViewController.h"
#import "UserViewController.h"
//#import "UserViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CollectionViewController *collectionVC = [[CollectionViewController alloc]init];
    UINavigationController *collectionNC = [[UINavigationController alloc]initWithRootViewController:collectionVC];
 
    collectionNC.tabBarItem.title = @"主页";
    collectionNC.tabBarItem.image = [UIImage imageNamed:@"index"];
    
    
     ClassifyTableViewController*cltVC = [[ClassifyTableViewController alloc]init];
   UINavigationController *cltNC = [[UINavigationController alloc]initWithRootViewController:cltVC];
    cltNC.tabBarItem.title = @"分类";
    cltNC.tabBarItem.image = [UIImage imageNamed:@"class"];

    
    RootViewController *serVC = [[RootViewController alloc]init];
    UINavigationController *serNC = [[UINavigationController alloc]initWithRootViewController:serVC];
    serNC.tabBarItem.image = [UIImage imageNamed:@"search"];
    serNC.tabBarItem.title = @"搜索";

    UserViewController *userVC = [[UserViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
    UINavigationController *userNC = [[UINavigationController alloc]initWithRootViewController:userVC];
    userNC.tabBarItem.image = [UIImage imageNamed:@"user"];
    userNC.tabBarItem.title = @"我的";
    
    
    self.selectedIndex = 2;
    self.tabBar.tintColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.viewControllers = @[collectionNC, cltNC, serNC, userNC];
    
    
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
