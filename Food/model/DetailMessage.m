//
//  DetailMessage.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailMessage.h"

@implementation DetailMessage
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    [super setValue:value forKey:key];
    
}

/*
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

 
*/

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_ID forKey:@"p_ID"];
    [aCoder encodeObject:_title forKey:@"p_title"];
    [aCoder encodeObject:_level forKey:@"p_level"];
    [aCoder encodeObject:_during forKey:@"p_during"];
    [aCoder encodeObject:_cuisine forKey:@"p_cuisine"];
    [aCoder encodeObject:_technics forKey:@"p_technics"];
    [aCoder encodeObject:_mainingredient forKey:@"p_mainingredient"];
    [aCoder encodeObject:_message forKey:@"p_message"];
    [aCoder encodeObject:_tips forKey:@"p_tips"];
    [aCoder encodeObject:_ingredient forKey:@"p_ingredient"];
    [aCoder encodeObject:_ingredient1 forKey:@"p_ingredient1"];
    [aCoder encodeObject:_ingredient2 forKey:@"p_ingredient2"];
    [aCoder encodeObject:_ingredient3 forKey:@"p_ingredient3"];
    [aCoder encodeObject:_author forKey:@"p_author"];
    [aCoder encodeObject:_avatar forKey:@"p_avatar"];
    [aCoder encodeObject:_cover forKey:@"p_cover"];
    [aCoder encodeObject:_stepcount forKey:@"p_stepcount"];
    [aCoder encodeObject:_steps forKey:@"p_steps"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ID = [aDecoder decodeObjectForKey:@"p_ID"];
        self.title = [aDecoder decodeObjectForKey:@"p_title"];
        self.level = [aDecoder decodeObjectForKey:@"p_level"];
        self.during = [aDecoder decodeObjectForKey:@"p_during"];
        self.cuisine = [aDecoder decodeObjectForKey:@"p_cuisine"];
        self.technics = [aDecoder decodeObjectForKey:@"p_technics"];
        self.mainingredient = [aDecoder decodeObjectForKey:@"p_mainingredient"];
        self.message = [aDecoder decodeObjectForKey:@"p_message"];
        self.tips = [aDecoder decodeObjectForKey:@"p_tips"];
        self.ingredient = [aDecoder decodeObjectForKey:@"p_ingredient"];
        self.ingredient1 = [aDecoder decodeObjectForKey:@"p_ingredient1"];
        self.ingredient2 = [aDecoder decodeObjectForKey:@"p_ingredient2"];
        self.ingredient3 = [aDecoder decodeObjectForKey:@"p_ingredient3"];
        self.author = [aDecoder decodeObjectForKey:@"p_author"];
        self.avatar = [aDecoder decodeObjectForKey:@"p_avatar"];
        self.cover = [aDecoder decodeObjectForKey:@"p_cover"];
        self.stepcount = [aDecoder decodeObjectForKey:@"p_stepcount"];
        self.steps = [aDecoder decodeObjectForKey:@"p_steps"];
    }
    return self;
}

@end
