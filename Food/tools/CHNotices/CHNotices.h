//
//  CHNotices.h
//  notices
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CHNoticesStyle) {
    CHNoticesStyleSuccess  = 0,
    CHNoticesStyleFail     = 1,
};
@interface CHNotices : UIView

+(void)noticesWithTitle:(NSString *)title Time:(NSTimeInterval)time View:(UIView *)view Style:(CHNoticesStyle)style;
@end
