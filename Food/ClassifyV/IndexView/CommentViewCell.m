//
//  CommentViewCell.m
//  Food
//
//  Created by lanou3g on 15/8/4.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "CommentViewCell.h"

@implementation CommentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.PhotoImage = [[UIImageView alloc]init];
        //_PhotoImage.backgroundColor =[UIColor blackColor];
        _PhotoImage.frame = CGRectMake(10, 10, 60, 60);
        _PhotoImage.layer.masksToBounds = YES;
        _PhotoImage.layer.cornerRadius = 30;
        _PhotoImage.image = [UIImage imageNamed:@"userphoto.jpg"];
        [self.contentView addSubview:_PhotoImage];
        
        self.userName = [[UILabel alloc] init];
        //_userName.backgroundColor = [UIColor blueColor];
        _userName.frame = CGRectMake(CGRectGetMaxX(_PhotoImage.frame) + 10, CGRectGetMinY(_PhotoImage.frame), CGRectGetWidth(self.frame) - 60 - 30, 20);
        _userName.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_userName];
        
        self.userComment = [[UILabel alloc] init];
        //_userComment.backgroundColor = [UIColor blueColor];
        _userComment.frame = CGRectMake(CGRectGetMinX(_userName.frame), CGRectGetMaxY(_userName.frame) + 10, CGRectGetWidth(self.frame) - 60 - 30, 30);
        _userComment.numberOfLines = 0;
        [self.contentView addSubview:_userComment];
        
        self.date = [[UILabel alloc] init];
        //_date.backgroundColor = [UIColor blueColor];
        _date.frame = CGRectMake(CGRectGetWidth(self.frame) - 90, CGRectGetMaxY(_userComment.frame) + 10, 80, 20);
        _date.textColor = [UIColor grayColor];
        _date.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_date];
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _userName.frame = CGRectMake(CGRectGetMaxX(_PhotoImage.frame) + 10, CGRectGetMinY(_PhotoImage.frame), CGRectGetWidth(self.frame) - 60 - 30, 20);
    //_userComment.frame = CGRectMake(CGRectGetMinX(_userName.frame), CGRectGetMaxY(_userName.frame) + 10, CGRectGetWidth(self.frame) - 60 - 30, 30);
    _date.frame = CGRectMake(CGRectGetWidth(self.frame) - 90, CGRectGetMaxY(_userComment.frame) + 5, 80, 20);
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
