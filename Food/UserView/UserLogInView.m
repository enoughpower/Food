//
//  UserLogInView.m
//  dd
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserLogInView.h"

@implementation UserLogInView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dc_setupView];
        
    }
    return self;
}

- (void)dc_setupView
{
    //self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    backImage.frame = self.bounds;
    [self addSubview:backImage];
    
    self.backView = [[UIView alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        _backView.frame = CGRectMake(150, CGRectGetHeight(self.frame) - 190, CGRectGetWidth(self.frame) - 300, 179);
    }else {
        _backView.frame = CGRectMake(20, CGRectGetHeight(self.frame) - 190, CGRectGetWidth(self.frame) - 40, 179);
    }
    _backView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.8];
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    [self addSubview:_backView];
    
    self.userNameImage = [[UIImageView alloc]init];
    _userNameImage.frame = CGRectMake(10, 10, 32, 32);
    _userNameImage.image = [UIImage imageNamed:@"username"];
    [_backView addSubview:_userNameImage];
    
    self.userNameText = [[UITextField alloc] init];
    _userNameText.frame = CGRectMake(CGRectGetMaxX(_userNameImage.frame) + 10, CGRectGetMinY(_userNameImage.frame), CGRectGetWidth(_backView.frame) - 32 - 30, CGRectGetHeight(_userNameImage.frame));
    
    _userNameText.placeholder = @"用户名";
    _userNameText.clearsOnBeginEditing = YES;
    [_backView addSubview:_userNameText];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_userNameText.frame), CGRectGetMaxY(_userNameText.frame) + 2, CGRectGetWidth(_userNameText.frame) + 2, 1)];
    line.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line];
    
    self.userPassWordImage = [[UIImageView alloc] init];
    _userPassWordImage.frame = CGRectMake(CGRectGetMinX(_userNameImage.frame), CGRectGetMaxY(line.frame) + 10, CGRectGetWidth(_userNameImage.frame), CGRectGetHeight(_userNameImage.frame));
    _userPassWordImage.image = [UIImage imageNamed:@"password"];
    [_backView addSubview:_userPassWordImage];
    
    self.userPassWordText = [[UITextField alloc] init];
    _userPassWordText.frame = CGRectMake(CGRectGetMinX(_userNameText.frame), CGRectGetMinY(_userPassWordImage.frame), CGRectGetWidth(_userNameText.frame), CGRectGetHeight(_userPassWordImage.frame));
    
    _userPassWordText.keyboardType = UIKeyboardTypeASCIICapable;
    _userPassWordText.secureTextEntry = YES;
    _userPassWordText.placeholder = @"密码";
    _userPassWordText.clearsOnBeginEditing = YES;
    [_backView addSubview:_userPassWordText];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_userPassWordText.frame), CGRectGetMaxY(_userPassWordText.frame) + 2, CGRectGetWidth(_userPassWordText.frame), 1)];
    line1.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line1];
    
    self.findPasswordButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _findPasswordButton.frame = CGRectMake(CGRectGetMaxX(line1.frame) - 80, CGRectGetMaxY(line1.frame) + 5, 80, 20);
    [_findPasswordButton setTitle:@"忘记密码？" forState:(UIControlStateNormal)];
    [_backView addSubview:_findPasswordButton];
    
    self.logInButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _logInButton.frame = CGRectMake(CGRectGetMinX(_userPassWordImage.frame), CGRectGetMaxY(_findPasswordButton.frame) + 5, CGRectGetWidth(_backView.frame) - 20, 50);
    _logInButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
    [_logInButton setTitle:@"登录" forState:(UIControlStateNormal)];
    [_logInButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _logInButton.layer.masksToBounds = YES;
    _logInButton.layer.cornerRadius = 5;
    [_backView addSubview:_logInButton];
    
    
    
}


@end
