//
//  UserRegisterView.h
//  Food
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegisterView : UIView
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIImageView *userNameImage;
@property (nonatomic, strong)UITextField *userNameText;

@property (nonatomic, strong)UIImageView *userPassWordImage;
@property (nonatomic, strong)UITextField *userPassWordText;

@property (nonatomic, strong)UIImageView *userPassWordImage1;
@property (nonatomic, strong)UITextField *userPassWordText1;

@property (nonatomic, strong)UIImageView *userEmailImage;
@property (nonatomic, strong)UITextField *userEmailText;

@property (nonatomic, strong)UIImageView *userPhoneNumber;
@property (nonatomic, strong)UITextField *userPhoneNumberText;

@property (nonatomic, strong)UIButton *registerButton;

@property (nonatomic, strong)UIButton *cancelButton;

@property (nonatomic, strong)UIButton *selectButton;
@property (nonatomic, strong)UIButton *privateButton;

@end
