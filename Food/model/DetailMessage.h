//
//  DetailMessage.h
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailMessage : NSObject<NSCoding>
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *during;
@property (nonatomic, copy)NSString *cuisine;
@property (nonatomic, copy)NSString *technics;
@property (nonatomic, copy)NSString *mainingredient;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, copy)NSString *tips;
@property (nonatomic, copy)NSString *ingredient;
@property (nonatomic, strong)NSMutableDictionary *ingredient1;
@property (nonatomic, strong)NSMutableDictionary *ingredient2;
@property (nonatomic, strong)NSMutableDictionary *ingredient3;
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *cover;
@property (nonatomic, copy)NSString *stepcount;
@property (nonatomic, strong)NSMutableArray *steps;




@end
