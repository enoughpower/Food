//
//  CollectionViewCell.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

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
    self.backgroundColor = [UIColor whiteColor];
    self.myImageView = [[UIImageView alloc] init];
    _myImageView.frame = CGRectMake(5, 5, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.width - 10);
    _myImageView.layer.masksToBounds = YES;
    _myImageView.layer.cornerRadius = 10;
    [self addSubview:_myImageView];
    
    self.myLabel = [[UILabel alloc]init];
    _myLabel.frame = CGRectMake(5, CGRectGetMaxY(_myImageView.frame) + 10, self.bounds.size.width - 10, self.contentView.bounds.size.height - CGRectGetHeight(_myImageView.frame) - 15);
    _myLabel.alpha = 1;
    _myLabel.numberOfLines = 0;
    //_myLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:_myLabel];
    
}

@end
