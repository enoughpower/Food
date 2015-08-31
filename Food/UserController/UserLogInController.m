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
@property (nonatomic, strong)UserLogInView *usv;
@property (nonatomic, strong)UIAlertController *alert1;
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
    [self.usv.findPasswordButton addTarget:self action:@selector(findPasswordButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
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
            [self userError:error];
        }
    }];
}

// 找回密码按钮
- (void)findPasswordButtonAction:(UIButton *)sender
{
    self.alert1 = [UIAlertController alertControllerWithTitle:@"找回密码" message:@"请确保输入的邮箱账号是注册时填写的账号并且可以访问" preferredStyle:UIAlertControllerStyleAlert];
    [_alert1 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"邮箱号码";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction*action){
        UITextField *text = _alert1.textFields[0];
        [AVUser requestPasswordResetForEmailInBackground:text.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [CHNotices noticesWithTitle:@"已发送链接至你的邮箱" Time:2 View:self.view Style:CHNoticesStyleSuccess];
            } else {
                [self userError:error];
            }
        }];
    }];
    
    [_alert1 addAction:action1];
    [_alert1 addAction:action2];
    [self presentViewController:_alert1 animated:YES completion:nil];
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

- (void)userError:(NSError *)error
{
    if (error.code == 210) {
        [CHNotices noticesWithTitle:@"密码错误" Time:1 View:self.view Style:CHNoticesStyleFail];
    }else if (error.code == 211) {
        [CHNotices noticesWithTitle:@"用户名不存在" Time:1 View:self.view Style:CHNoticesStyleFail];
    }else if (error.code == -1009) {
        [CHNotices noticesWithTitle:@"网络不给力" Time:1 View:self.view Style:CHNoticesStyleFail];
    }else if (error.code == 205) {
        [CHNotices noticesWithTitle:@"邮箱不存在" Time:1 View:self.view Style:CHNoticesStyleFail];
    }
    DLog(@"%ld  %@", error.code, error.localizedDescription);
    
    
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
    self.usv.backView.frame = CGRectMake(150, CGRectGetHeight(self.view.frame) - 190 - height, CGRectGetWidth(self.view.frame) - 300, 179);
    }else {
    self.usv.backView.frame = CGRectMake(20, CGRectGetHeight(self.view.frame) - 190 - height, CGRectGetWidth(self.view.frame) - 40, 179);
    }

    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    self.usv.backView.frame = CGRectMake(150, CGRectGetHeight(self.view.frame) - 190, CGRectGetWidth(self.view.frame) - 300, 179);
    }else {
    self.usv.backView.frame = CGRectMake(20, CGRectGetHeight(self.view.frame) - 190, CGRectGetWidth(self.view.frame) - 40, 179);
    }

}

@end
