//
//  ClassifyDetailShowController.h
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyDetailShowController : UIViewController
@property(nonatomic,copy)NSString *IDString;

// 传值给detail的导航栏的title
@property(nonatomic,copy)NSString *PassValuetitle;
@end
