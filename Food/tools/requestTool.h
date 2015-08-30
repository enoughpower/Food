//
//  requestTool.h
//  Tool
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^backValue) (NSData *value);

@interface requestTool : NSObject

+ (void)requestWithUrl:(NSString *)urlStr body:(NSString *)bodyStr backValue:(backValue)bv;







@end
