//
//  CommentViewCell.h
//  Food
//
//  Created by lanou3g on 15/8/4.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *PhotoImage;
@property (nonatomic, strong)UILabel *userName;
@property (nonatomic, strong)UILabel *userComment;
@property (nonatomic, strong)UILabel *date;
@end
