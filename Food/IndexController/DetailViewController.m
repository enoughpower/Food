//
//  DetailViewController.m
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "requestTool.h"
#import "DetailMessage.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "GMDCircleLoader.h"
#import "DetailStepViewController.h"
#define urlstr @"http://api.2meiwei.com/v1/recipe/"
@interface DetailViewController ()
@property (nonatomic, strong)DetailView *dv;
@property (nonatomic, strong)DetailMessage *message;
@end

@implementation DetailViewController

-(void)loadView
{
    self.dv= [[DetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _dv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    reach.reachableBlock = ^(Reachability *reach){
        [self p_makeData];
    };
    if (reach.isReachable == YES) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        [self p_makeData];
    }else{
        [GMDCircleLoader setOnView:self.view withTitle:@"网络无连接..." animated:YES];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"步骤" style:(UIBarButtonItemStylePlain) target:self action:@selector(buttonAction:)];
    


    
    

}



- (void)p_makeData
{
    NSString *url = [NSString stringWithFormat:@"%@%@/", urlstr, self.ID];
    DLog(@"%@", url);
    [requestTool requestWithUrl:url body:nil backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        self.message = [[DetailMessage alloc]init];
        [_message setValuesForKeysWithDictionary:dict];
        [self.dv.foodImage sd_setImageWithURL:[NSURL URLWithString:_message.cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
        [self.dv.photoImage sd_setImageWithURL:[NSURL URLWithString:_message.avatar] placeholderImage:[UIImage imageNamed:@"picholder"]];
        self.dv.author.text = _message.author;
        [self.dv setView:_message];
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    }];
    
}

- (void)buttonAction:(UIBarButtonItem *)sender
{
    DetailStepViewController *dsVC = [[DetailStepViewController alloc]initWithStyle:(UITableViewStylePlain)];
    dsVC.step = self.message.steps;
    dsVC.navigationItem.title = @"详细步骤";
    //DLog(@"%@", dsVC.step);
    [self.navigationController pushViewController:dsVC animated:YES];
    
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
