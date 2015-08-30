//
//  SearchTableViewCell.m
//  Cookbook
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 牛清旭. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    
    // 图片
    self.classifyImage = [[UIImageView alloc] init];
    _classifyImage.frame = CGRectMake(8, 8, self.frame.size.width / 3, self.frame.size.height - 16);
    _classifyImage.layer.cornerRadius = 10;
    _classifyImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_classifyImage];
    
    // 标题（菜名）
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_classifyImage.frame) + 5, CGRectGetMinY(_classifyImage.frame), self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 20, CGRectGetHeight(_classifyImage.frame) / 3);
    [self.contentView addSubview:_titleLabel];
    
    // 介绍
    self.detailLabel = [[UILabel alloc] init];
    _detailLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame) + 5, self.frame.size.width - CGRectGetWidth(_classifyImage.frame), CGRectGetHeight(_titleLabel.frame) * 2);
    _detailLabel.numberOfLines = 0;
    //  = [UIColor cyanColor];
    [self.contentView addSubview:_detailLabel];
    

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _classifyImage.frame = CGRectMake(8, 8, self.frame.size.width / 3, self.frame.size.height - 16);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_classifyImage.frame) + 5, CGRectGetMinY(_classifyImage.frame), self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 20, CGRectGetHeight(_classifyImage.frame) / 3);
    
    _detailLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame) + 5, self.frame.size.width - CGRectGetWidth(_classifyImage.frame) - 25, CGRectGetHeight(_titleLabel.frame) *2 );
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
