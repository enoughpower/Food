//
//  UserLogInController.m
//  dd
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserLogInController.h"
#import "UserLogInView.h"
#import "UserRegisterController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CHNotices.h"
@interface UserLogInController ()<UITextFieldDelegate>
{
    UIAlertView *baseAlert;
}
@property (nonatomic, strong)UserLogInView *usv;
@end

@implementation UserLogInController

- (void)loadView
{
    self.usv = [[UserLogInView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _usv;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightAction:)];
    [self.usv.logInButton addTarget:self action:@selector(logInButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.title = @"登录";
    _usv.userNameText.delegate = self;
    _usv.userPassWordText.delegate = self;
    
}

// 登陆按钮
- (void)logInButtonAction:(UIButton *)sender
{
    [AVUser logInWithUsernameInBackground:self.usv.userNameText.text password:self.usv.userPassWordText.text block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            [CHNotices noticesWithTitle:@"登录成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
            [self performSelector:@selector(leftAction:) withObject:self afterDelay:1];
        }else{
            [CHNotices noticesWithTitle:@"登录失败" Time:1 View:self.view Style:CHNoticesStyleFail];
            DLog(@"登陆失败");
        }
    }];
}
// 返回按钮
- (void)leftAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 注册按钮
- (void)rightAction:(UIBarButtonItem *)sender
{
    UserRegisterController *registerVC = [[UserRegisterController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}




#pragma mark -- UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    self.usv.backView.frame = CGRectMake(150, CGRectGetHeight(self.view.frame) - 200 - height, CGRectGetWidth(self.view.frame) - 300, 169);
    }else {
    self.usv.backView.frame = CGRectMake(20, CGRectGetHeight(self.view.frame) - 200 - height, CGRectGetWidth(self.view.frame) - 40, 169);
    }

    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    self.usv.backView.frame = CGRectMake(150, CGRectGetHeight(self.view.frame) - 200, CGRectGetWidth(self.view.frame) - 300, 169);
    }else {
    self.usv.backView.frame = CGRectMake(20, CGRectGetHeight(self.view.frame) - 200, CGRectGetWidth(self.view.frame) - 40, 169);
    }

}

@end
