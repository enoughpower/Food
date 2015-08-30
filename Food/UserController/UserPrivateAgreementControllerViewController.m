//
//  UserPrivateAgreementControllerViewController.m
//  Food
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserPrivateAgreementControllerViewController.h"

@interface UserPrivateAgreementControllerViewController ()
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIButton *button;
@end

@implementation UserPrivateAgreementControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.navigationItem.title = @"用户注册隐私协议";
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height)];
    //self.scroll.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_scroll];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, 200)];
    _textLabel.numberOfLines = 0;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"privateAgreement.txt" ofType:nil];
    _textLabel.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //self.textLabel.backgroundColor = [UIColor blueColor];
    CGRect tmp = _textLabel.frame;
    tmp.size.height = [self heightForLabel:_textLabel.text];
    _textLabel.frame = tmp;
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, tmp.size.height + 50);
    [self.scroll addSubview:_textLabel];
    
    
    
}

- (CGFloat)heightForLabel:(NSString *)aString
{
    CGRect d = [aString boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 10, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil] ;
    return d.size.height;
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
