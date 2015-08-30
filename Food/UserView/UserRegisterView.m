//
//  UserRegisterView.m
//  Food
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserRegisterView.h"

@implementation UserRegisterView
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
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    backImage.frame = self.bounds;
    [self addSubview:backImage];
    
    self.backView = [[UIView alloc]init];
    _backView.frame = CGRectMake(20, 100, CGRectGetWidth(self.frame) - 40, 330);
    _backView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
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
    _userNameText.clearsOnBeginEditing = NO;
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
    
    
    
    self.userPassWordImage1 = [[UIImageView alloc] init];
    _userPassWordImage1.frame = CGRectMake(CGRectGetMinX(_userNameImage.frame), CGRectGetMaxY(line1.frame) + 10, CGRectGetWidth(_userNameImage.frame), CGRectGetHeight(_userNameImage.frame));
    _userPassWordImage1.image = [UIImage imageNamed:@"password"];
    [_backView addSubview:_userPassWordImage1];
    
    self.userPassWordText1 = [[UITextField alloc] init];
    _userPassWordText1.frame = CGRectMake(CGRectGetMinX(_userNameText.frame), CGRectGetMinY(_userPassWordImage1.frame), CGRectGetWidth(_userNameText.frame), CGRectGetHeight(_userPassWordImage1.frame));
    
    _userPassWordText1.keyboardType = UIKeyboardTypeASCIICapable;
    _userPassWordText1.secureTextEntry = YES;
    _userPassWordText1.placeholder = @"确认密码";
    _userPassWordText1.clearsOnBeginEditing = YES;
    [_backView addSubview:_userPassWordText1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_userPassWordText1.frame), CGRectGetMaxY(_userPassWordImage1.frame) + 2, CGRectGetWidth(_userPassWordText1.frame), 1)];
    line2.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line2];
    
    self.userEmailImage = [[UIImageView alloc]init];
    _userEmailImage.frame = CGRectMake(CGRectGetMinX(_userPassWordImage1.frame), CGRectGetMaxY(line2.frame) + 10, CGRectGetWidth(_userPassWordImage1.frame), CGRectGetHeight(_userPassWordImage1.frame));
    _userEmailImage.image = [UIImage imageNamed:@"email"];
    [_backView addSubview:_userEmailImage];
    
    self.userEmailText = [[UITextField alloc] init];
    _userEmailText.frame = CGRectMake(CGRectGetMinX(_userPassWordText1.frame), CGRectGetMinY(_userEmailImage.frame), CGRectGetWidth(_userPassWordText1.frame), CGRectGetHeight(_userPassWordText1.frame));
    _userEmailText.keyboardType = UIKeyboardTypeASCIICapable;
    _userEmailText.placeholder = @"邮箱";
    _userEmailText.clearsOnBeginEditing = NO;
    [_backView addSubview:_userEmailText];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userEmailText.frame), CGRectGetMaxY(_userEmailText.frame) + 2, CGRectGetWidth(_userEmailText.frame), 1)];
    line3.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line3];
    
    self.userPhoneNumber = [[UIImageView alloc] init];
    _userPhoneNumber.frame = CGRectMake(CGRectGetMinX(_userEmailImage.frame), CGRectGetMaxY(line3.frame) + 10, CGRectGetWidth(_userEmailImage.frame), CGRectGetHeight(_userEmailImage.frame));
    _userPhoneNumber.image = [UIImage imageNamed:@"telephone"];
    [_backView addSubview:_userPhoneNumber];
    
    self.userPhoneNumberText = [[UITextField alloc] init];
    _userPhoneNumberText.frame = CGRectMake(CGRectGetMinX(_userEmailText.frame), CGRectGetMinY(_userPhoneNumber.frame), CGRectGetWidth(_userPassWordText1.frame), CGRectGetHeight(_userPassWordText1.frame));
    _userPhoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    _userPhoneNumberText.placeholder = @"手机号";
    _userPhoneNumberText.clearsOnBeginEditing = NO;
    [_backView addSubview:_userPhoneNumberText];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_userPhoneNumberText.frame), CGRectGetMaxY(_userPhoneNumberText.frame) + 2, CGRectGetWidth(_userPhoneNumberText.frame), 1)];
    line4.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line4];
    
    self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _selectButton.frame = CGRectMake(CGRectGetMinX(_userPhoneNumber.frame) + 10, CGRectGetMaxY(_userPhoneNumberText.frame) + 14, 20, 20);
    [_selectButton setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:(UIControlStateNormal)];
    [_backView addSubview:_selectButton];
    
    self.privateButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _privateButton.frame = CGRectMake(CGRectGetMaxX(_selectButton.frame) + 10, CGRectGetMinY(_selectButton.frame), 200, 20);
    //_privateButton.backgroundColor = [UIColor yellowColor];
    [_privateButton setTitle:@"我同意《用户注册隐私协议》" forState:(UIControlStateNormal)];
    [_backView addSubview:_privateButton];
    
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _registerButton.frame = CGRectMake(CGRectGetMinX(_userPhoneNumber.frame), CGRectGetMaxY(_selectButton.frame) + 14, (CGRectGetWidth(_backView.frame) - 30) / 2, 50);
    _registerButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
    [_registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _registerButton.layer.masksToBounds = YES;
    _registerButton.layer.cornerRadius = 5;
    [_backView addSubview:_registerButton];

    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _cancelButton.frame = CGRectMake(CGRectGetMaxX(_registerButton.frame) + 10, CGRectGetMinY(_registerButton.frame), CGRectGetWidth(_registerButton.frame), CGRectGetHeight(_registerButton.frame));
    _cancelButton.backgroundColor = [UIColor grayColor];
    [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _cancelButton.layer.masksToBounds = YES;
    _cancelButton.layer.cornerRadius = 5;
    [_backView addSubview:_cancelButton];
    
    
    
    
}

@end
