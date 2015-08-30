//
//  SearchView.h
//  Cookbook
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 牛清旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#define url @"http://api.2meiwei.com/v1/recipe/search/?"
#import "RequestTool.h"
@interface SearchView : UIView<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)UIButton *searchButton;


@end
