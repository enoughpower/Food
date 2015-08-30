//
//  UserRegisterController.m
//  Food
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserRegisterController.h"
#import "UserRegisterView.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CHNotices.h"
#import "UserPrivateAgreementControllerViewController.h"
@interface UserRegisterController ()<UITextFieldDelegate>
{
    BOOL isSelect;
}
@property (nonatomic, strong)UserRegisterView *urv;
@end

@implementation UserRegisterController

- (void)loadView
{
    self.urv = [[UserRegisterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _urv;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    // 设置代理
    self.urv.userNameText.delegate = self;
    self.urv.userPassWordText.delegate = self;
    self.urv.userPassWordText1.delegate = self;
    self.urv.userEmailText.delegate = self;
    isSelect = NO;
    // 给按钮添加事件
    [self.urv.registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.urv.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.urv.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.urv.privateButton addTarget:self action:@selector(privateButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

    
}
- (void)registerButtonAction:(UIButton *)sender
{
    AVUser *user = [AVUser user];
    if (([self.urv.userNameText.text  isEqual: @""])||([self.urv.userPassWordText.text  isEqual: @""])) {
        [CHNotices noticesWithTitle:@"用户名或密码不能为空" Time:1 View:self.view Style:CHNoticesStyleFail];
        DLog(@"用户名或密码不能为空");
    }else if (!isSelect) {
        [CHNotices noticesWithTitle:@"请阅读并同意隐私协议" Time:1 View:self.view Style:CHNoticesStyleFail];
    }else if (![self.urv.userPassWordText.text isEqualToString:self.urv.userPassWordText1.text]) {
        [CHNotices noticesWithTitle:@"两次输入的密码不一致" Time:1 View:self.view Style:CHNoticesStyleFail];
        DLog(@"两次密码不一致");
    }else if ([self.urv.userPassWordText.text length] < 6) {
        [CHNotices noticesWithTitle:@"密码少于6位" Time:1 View:self.view Style:CHNoticesStyleFail];
        DLog(@"密码少于6位");
    }else if( ([self.urv.userPhoneNumberText.text length] != 11) && (![self.urv.userPhoneNumberText.text isEqualToString:@""])){
        [CHNotices noticesWithTitle:@"手机号码不足11位" Time:1 View:self.view Style:CHNoticesStyleFail];
        DLog(@"手机号码不足11位");
    }
    else{
        user.username = self.urv.userNameText.text;
        user.password = self.urv.userPassWordText.text;
        if (![self.urv.userEmailText.text isEqualToString:@""]) {
            user.email = self.urv.userEmailText.text;
        }
        if (![self.urv.userPhoneNumberText.text isEqualToString:@""]) {
            user.mobilePhoneNumber = self.urv.userPhoneNumberText.text;
        }
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error == nil) {
                [CHNotices noticesWithTitle:@"注册成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                [self performSelector:@selector(cancelButtonAction:) withObject:self afterDelay:1.0f];
            }else{
                [self userError:error];
            }
        }];
    }
}
- (void)cancelButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)userError:(NSError *)error
{
    NSString *errorStr = error.localizedDescription;
    if ([errorStr isEqualToString:@"Username has already been taken"]) {
        [CHNotices noticesWithTitle:@"用户名已被注册" Time:1 View:self.view Style:CHNoticesStyleFail];
    }else{
        [CHNotices noticesWithTitle:@"注册失败" Time:1 View:self.view Style:CHNoticesStyleFail];
        DLog(@"注册失败");
        DLog(@"%@", errorStr);
    }

}

- (void)selectButtonAction:(UIButton *)sender
{
    
    if (isSelect) {
        [self.urv.selectButton setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:(UIControlStateNormal)];
        isSelect = NO;
    }else {
        [self.urv.selectButton setBackgroundImage:[UIImage imageNamed:@"select"] forState:(UIControlStateNormal)];
        isSelect = YES;
    }
}

- (void)privateButtonAction:(UIButton *)sender
{
    UserPrivateAgreementControllerViewController *agree = [[UserPrivateAgreementControllerViewController alloc]init];
    [self.navigationController pushViewController:agree animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
