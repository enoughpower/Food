//
//  DetailView.h
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailMessage;

@interface DetailView : UIScrollView

@property (nonatomic, strong)UIImageView *myImage;
@property (nonatomic, strong)UIImageView *foodImage;
@property (nonatomic, strong)UIImageView *photoImage;
@property (nonatomic, strong)UILabel *author;
@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic, strong)UILabel *levelLabel;
@property (nonatomic, strong)UILabel *duringLabel;
@property (nonatomic, strong)UILabel *cuisineLabel;
@property (nonatomic, strong)UILabel *technicsLabel;
- (void)setView:(DetailMessage *)message;

@end
