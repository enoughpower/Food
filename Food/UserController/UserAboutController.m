//
//  UserAboutController.m
//  Food
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserAboutController.h"
#define VERSION @"V1.0"
#define EMAIL @"baidudc@126.com"
@interface UserAboutController ()

@end

@implementation UserAboutController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    backImage.frame = self.view.bounds;
    backImage.alpha = 0.4;
    
    [self.view addSubview:backImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    label.text = @"用自己的智慧，创造美味的生活";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.view addSubview:label];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    version.center = CGPointMake(self.view.center.x, CGRectGetMaxY(label.frame) + 10);
    version.text = VERSION;
    version.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:version];
    
    UILabel *contactUs = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 20)];
    contactUs.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    contactUs.textAlignment = NSTextAlignmentCenter;
    contactUs.text = [NSString stringWithFormat:@"联系我们：%@", EMAIL];
    [self.view addSubview:contactUs];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 1)];
    line.center = CGPointMake(self.view.center.x, CGRectGetMaxY(contactUs.frame) + 3);
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
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
