//
//  ClassifyModel.h
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ClassifyModel : NSObject

// 菜id
@property(nonatomic,copy)NSString *ID;
// 图片链接
@property(nonatomic,copy)NSString *cover;
// 介绍链接
@property(nonatomic,copy)NSString *message;
// title链接
@property(nonatomic,copy)NSString *title;


@end
