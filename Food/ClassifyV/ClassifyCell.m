//
//  ClassifyCell.m
//  Food
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyCell.h"

@implementation ClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self p_setupView];
    }
    return self;
}

// 分类界面布局
- (void)p_setupView
{
//    self.backgroundImageview = [[UIImageView alloc] init];
//    self.backgroundImageview.frame = CGRectMake(0, 0, self.frame.size.width, 90);
//   // self.backgroundImageview.image = [UIImage imageNamed:@"四角边框.jpg"];
//    [self.contentView addSubview:_backgroundImageview];
    
    // 图片
    self.classifyImage = [[UIImageView alloc] init];
    _classifyImage.frame = CGRectMake(8, 8, self.frame.size.width / 4, self.frame.size.height - 16);
    // _classifyImage.backgroundColor = [UIColor cyanColor];
    _classifyImage.layer.masksToBounds = YES;
    _classifyImage.layer.cornerRadius = 5;
    [self.contentView addSubview:_classifyImage];
    // 标题（菜名）
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_classifyImage.frame) + 5, CGRectGetMinY(_classifyImage.frame), self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 20, CGRectGetHeight(_classifyImage.frame) /3);
     //_titleLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_titleLabel];
    // 介绍
    self.detailLabel = [[UILabel alloc] init];
    _detailLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame) + 5, self.frame.size.width - CGRectGetWidth(_classifyImage.frame), CGRectGetHeight(_titleLabel.frame) * 2);
    _detailLabel.numberOfLines = 0;
     //_detailLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_detailLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // self.backgroundImageview.frame = CGRectMake(0, 0, self.frame.size.width, 90);
    _classifyImage.frame = CGRectMake(8, 8, self.frame.size.width / 4, self.frame.size.height - 16);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_classifyImage.frame) + 5, CGRectGetMinY(_classifyImage.frame), self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 20, CGRectGetHeight(_classifyImage.frame) / 3);
    _detailLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame) + 5, self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 25, CGRectGetHeight(_titleLabel.frame) * 2);
    
}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
