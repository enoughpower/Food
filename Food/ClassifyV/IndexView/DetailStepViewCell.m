//
//  DetailStepViewCell.m
//  Food
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailStepViewCell.h"

@implementation DetailStepViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.num = [[UILabel alloc]init];
        _num.frame = CGRectMake(5, 5, 30, 20);
        _num.textColor = [UIColor orangeColor];
        _num.font = [UIFont systemFontOfSize:18.f];
        _num.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_num];
        
        self.myLabel = [[UILabel alloc]init];
        _myLabel.frame = CGRectMake(CGRectGetMaxX(_num.frame) + 5, CGRectGetMinX(_num.frame), self.bounds.size.width - 50, 200);
        _myLabel.numberOfLines = 0;
        //_myLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_myLabel];
        
        self.myImage = [[UIImageView alloc]init];
        _myImage.frame = CGRectMake(CGRectGetMinX(_myLabel.frame), CGRectGetMaxY(_myLabel.frame) + 5, self.bounds.size.width - 50, (self.bounds.size.width - 50) /4*3 );
        _myImage.layer.masksToBounds = YES;
        _myImage.layer.cornerRadius = 10;
        [self.contentView addSubview:_myImage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //_myLabel.frame = CGRectMake(CGRectGetMaxX(_num.frame) + 5, CGRectGetMinX(_num.frame), self.bounds.size.width - 50, 200);
    _myImage.frame = CGRectMake(CGRectGetMinX(_myLabel.frame), CGRectGetMaxY(_myLabel.frame) + 5, self.bounds.size.width - 50, (self.bounds.size.width - 50) /4*3 );
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
