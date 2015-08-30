//
//  ClassifyCollectionCell.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyCollectionCell.h"
#import "UIImageView+WebCache.h"
@implementation ClassifyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetWidth(self.frame) - 10);
    _imageView.backgroundColor = [UIColor yellowColor];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 10;
    
    [self.contentView addSubview:_imageView];
    
    self.label = [[UILabel alloc] init];
    _label.frame = CGRectMake(5, CGRectGetMaxY(_imageView.frame), CGRectGetWidth(self.frame) - 10, 30);
    //_label.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_label];
    
    self.message = [[UILabel alloc] init];
    _message.frame = CGRectMake(5, CGRectGetMaxY(_label.frame), CGRectGetWidth(self.frame) - 10, 60);
    _message.numberOfLines = 0;
    _message.font = [UIFont systemFontOfSize:13];
    _message.alpha = 0.7;
    //_message.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_message];
}



@end
