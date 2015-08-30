//
//  DetailViewController.h
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailMessage;
@interface DetailViewController : UIViewController
@property (nonatomic, copy)NSString *ID;
//@property (nonatomic, copy)NSString *titleStr;
//@property (nonatomic, copy)NSString *imgStr;
@property (nonatomic, strong)DetailMessage *message;


@end
