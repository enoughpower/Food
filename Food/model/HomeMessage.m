//
//  HomeMessage.m
//  Food
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "HomeMessage.h"

@implementation HomeMessage
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}
@end
