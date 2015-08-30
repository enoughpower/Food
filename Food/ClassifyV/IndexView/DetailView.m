//
//  DetailView.m
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailView.h"
#import "DetailViewController.h"
#import "DetailMessage.h"
@interface DetailView ()
@property (nonatomic, strong)NSArray *arr1;
@property (nonatomic, strong)NSArray *arr2;
@property (nonatomic, strong)NSArray *arr3;

@property (nonatomic, strong)UIView *myView;
@property (nonatomic, strong)UIView *myView1;
@property (nonatomic, strong)UIView *myView2;
@property (nonatomic, strong)UIView *myView3;

@property (nonatomic, strong)UILabel *lab1;
@property (nonatomic, strong)UILabel *lab2;

@property (nonatomic, strong)UILabel *tips;


@end


@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dc_setupView];
        
    }
    return self;
}

- (void)dc_setupView
{
    self.bounces = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    
    self.foodImage = [[UIImageView alloc]init];
    _foodImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [self addSubview:_foodImage];
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width , 40);
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _titleLabel.alpha = 0.6;
    [_foodImage addSubview:_titleLabel];
    
    self.photoImage = [[UIImageView alloc]init];
    _photoImage.frame = CGRectMake(0, 0, 50, 50);
    _photoImage.center = CGPointMake(40, CGRectGetMaxY(_foodImage.frame) + 5);
    _photoImage.layer.masksToBounds = YES;
    _photoImage.layer.cornerRadius = 25;
    _photoImage.layer.borderWidth = 2;
    _photoImage.layer.borderColor = [UIColor whiteColor].CGColor;
    //_photoImage.backgroundColor = [UIColor blueColor];
    [self addSubview:_photoImage];
    
    
    
    self.author = [[UILabel alloc]init];
    _author.frame = CGRectMake(CGRectGetMaxX(_photoImage.frame) + 10, CGRectGetMaxY(_foodImage.frame) + 10, 150, 15);
    _author.font = [UIFont systemFontOfSize:14.f];
    _author.textColor = [UIColor orangeColor];
    [self addSubview:_author];
    
    self.messageLabel = [[UILabel alloc]init];
    _messageLabel.frame = CGRectMake(20, CGRectGetMaxY(_photoImage.frame) + 10, CGRectGetWidth(self.frame) - 40, 200);
    _messageLabel.numberOfLines = 0;
    [self addSubview:_messageLabel];
    
    

    
    
}

- (void)setView:(DetailMessage *)message
{
    
    self.messageLabel.text = [self handleStringWithString:message.message];
    self.messageLabel.frame = [self adjustLabel:self.messageLabel];
    
    self.myView = [[UIView alloc]init];
    _myView.frame = CGRectMake(5, CGRectGetMaxY(_messageLabel.frame) + 5, CGRectGetWidth(self.frame) - 10, 55);
    _myView.backgroundColor = [UIColor whiteColor];
    _myView.layer.masksToBounds = YES;
    _myView.layer.cornerRadius = 5;
    [self addSubview:_myView];
    
    self.levelLabel = [[UILabel alloc]init];
    _levelLabel.frame = CGRectMake(50, 5, (CGRectGetWidth(_myView.frame) - 140) / 2, 20);
    //_levelLabel.backgroundColor = [UIColor blueColor];
    _levelLabel.font = [UIFont systemFontOfSize:14.f];
    //_levelLabel.textAlignment = NSTextAlignmentCenter;
    [_myView addSubview:_levelLabel];
    
    self.duringLabel = [[UILabel alloc]init];
    _duringLabel.frame = CGRectMake(CGRectGetMaxX(_levelLabel.frame) + 40, CGRectGetMinY(_levelLabel.frame), CGRectGetWidth(_levelLabel.frame), CGRectGetHeight(_levelLabel.frame));
    //_duringLabel.backgroundColor = [UIColor yellowColor];
    _duringLabel.font = [UIFont systemFontOfSize:14.f];
    //_duringLabel.textAlignment = NSTextAlignmentCenter;
    [_myView addSubview:_duringLabel];
    
    self.cuisineLabel = [[UILabel alloc]init];
    _cuisineLabel.frame = CGRectMake(CGRectGetMinX(_levelLabel.frame), CGRectGetMaxY(_levelLabel.frame) + 5, CGRectGetWidth(_levelLabel.frame), CGRectGetHeight(_levelLabel.frame));
    //_cuisineLabel.backgroundColor = [UIColor blueColor];
    _cuisineLabel.font = [UIFont systemFontOfSize:14.f];
    //_cuisineLabel.textAlignment = NSTextAlignmentCenter;
    [_myView addSubview:_cuisineLabel];
    
    self.technicsLabel = [[UILabel alloc]init];
    _technicsLabel.frame = CGRectMake(CGRectGetMinX(_duringLabel.frame), CGRectGetMinY(_cuisineLabel.frame), CGRectGetWidth(_levelLabel.frame), CGRectGetHeight(_levelLabel.frame));
    //_technicsLabel.backgroundColor = [UIColor blueColor];
    _technicsLabel.font = [UIFont systemFontOfSize:14.f];
    //_technicsLabel.textAlignment = NSTextAlignmentCenter;
    [_myView addSubview:_technicsLabel];

    self.levelLabel.text = [NSString stringWithFormat:@"难度：%@", message.level];
    self.duringLabel.text = [NSString stringWithFormat:@"时间：%@", message.during];
    self.cuisineLabel.text = [NSString stringWithFormat:@"口味：%@", message.cuisine];
    self.technicsLabel.text = [NSString stringWithFormat:@"工艺：%@", message.technics];
    
    self.lab1 = [[UILabel alloc]init];
    _lab1.frame = CGRectMake(20, CGRectGetMaxY(_myView.frame) + 10, 100, 50);
    _lab1.textColor= [UIColor colorWithRed:100/255.0 green:43/255.0 blue:40/255.0 alpha:1];
    _lab1.text = @"用料";
    _lab1.font = [UIFont systemFontOfSize:20];
    
    
    //==========================主料===========================
    
    if (message.ingredient1.count == 0) {
        self.myView1 = [[UIView alloc]init];
        _myView1.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_lab1.frame), 1, 1);
        //_myView1.backgroundColor = [UIColor yellowColor];
        [self addSubview:_myView1];
    }else{
        [self addSubview:_lab1];
        self.arr1 = [message.ingredient1 allKeys];
        self.myView1 = [[UIView alloc]init];
        _myView1.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_lab1.frame), self.bounds.size.width - 40, 30 +20*_arr1.count);
        //_myView1.backgroundColor = [UIColor redColor];
        [self addSubview:_myView1];
        
        
        UILabel *zhuliao = [[UILabel alloc]init];
        zhuliao.frame = CGRectMake(0, 0, CGRectGetWidth(_myView1.frame), 20);
        zhuliao.textAlignment = NSTextAlignmentCenter;
        zhuliao.text = @"主料";
        zhuliao.textColor = [UIColor colorWithRed:100/255.0 green:43/255.0 blue:40/255.0 alpha:1];
        [_myView1 addSubview:zhuliao];
        
        for (int i = 0; i < [_arr1 count]; i ++) {
            UILabel *label1 = [[UILabel alloc]init ];
            UILabel *label2 = [[UILabel alloc] init];
            label1.frame = CGRectMake(0, 30 + 20*i, (self.bounds.size.width - 42) / 2, 18);
            label2.frame = CGRectMake(CGRectGetMaxX(label1.frame) + 2, CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
            label1.text = _arr1[i];
            label2.text = message.ingredient1[_arr1[i]];
            label1.backgroundColor = [UIColor whiteColor];
            label2.backgroundColor = [UIColor whiteColor];
            label2.textColor = [UIColor grayColor];
            [_myView1 addSubview:label1];
            [_myView1 addSubview:label2];
        }
    }
    
    //==========================配料===========================
    if (message.ingredient2.count == 0) {
        self.myView2 = [[UIView alloc]init];
        _myView2.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_myView1.frame), 1, 1);
        //_myView2.backgroundColor = [UIColor yellowColor];
        [self addSubview:_myView2];
    }else{
        self.arr2 = [message.ingredient2 allKeys];
        self.myView2 = [[UIView alloc]init];
        _myView2.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_myView1.frame) + 5, self.bounds.size.width - 40, 30 +20*_arr2.count);
        //_myView1.backgroundColor = [UIColor redColor];
        [self addSubview:_myView2];
        
        
        UILabel *peiliao = [[UILabel alloc]init];
        peiliao.frame = CGRectMake(0, 0, CGRectGetWidth(_myView2.frame), 20);
        peiliao.textAlignment = NSTextAlignmentCenter;
        peiliao.text = @"配料";
        peiliao.textColor = [UIColor colorWithRed:100/255.0 green:43/255.0 blue:40/255.0 alpha:1];
        [_myView2 addSubview:peiliao];
        
        for (int i = 0; i < [_arr2 count]; i ++) {
            UILabel *label1 = [[UILabel alloc]init ];
            UILabel *label2 = [[UILabel alloc] init];
            label1.frame = CGRectMake(0, 30 + 20*i, (self.bounds.size.width - 42) / 2, 18);
            label2.frame = CGRectMake(CGRectGetMaxX(label1.frame) + 2, CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
            label1.text = _arr2[i];
            label2.text = message.ingredient2[_arr2[i]];
            label1.backgroundColor = [UIColor whiteColor];
            label2.backgroundColor = [UIColor whiteColor];
            label2.textColor = [UIColor grayColor];
            [_myView2 addSubview:label1];
            [_myView2 addSubview:label2];
        }
    }
    //==========================辅料===========================
    if (message.ingredient3.count == 0) {
        self.myView3 = [[UIView alloc]init];
        _myView3.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_myView2.frame), 1, 1);
        //_myView3.backgroundColor = [UIColor yellowColor];
        [self addSubview:_myView3];
    }else{
        self.arr3 = [message.ingredient3 allKeys];
        self.myView3 = [[UIView alloc]init];
        _myView3.frame = CGRectMake(CGRectGetMinX(_lab1.frame), CGRectGetMaxY(_myView2.frame) + 5, self.bounds.size.width - 40, 30 +20*_arr3.count);
        //_myView1.backgroundColor = [UIColor redColor];
        [self addSubview:_myView3];
        
        
        UILabel *fuliao = [[UILabel alloc]init];
        fuliao.frame = CGRectMake(0, 0, CGRectGetWidth(_myView3.frame), 20);
        fuliao.textAlignment = NSTextAlignmentCenter;
        fuliao.text = @"辅料";
        fuliao.textColor = [UIColor colorWithRed:100/255.0 green:43/255.0 blue:40/255.0 alpha:1];
        [_myView3 addSubview:fuliao];
        
        for (int i = 0; i < [_arr3 count]; i ++) {
            UILabel *label1 = [[UILabel alloc]init ];
            UILabel *label2 = [[UILabel alloc] init];
            label1.frame = CGRectMake(0, 30 + 20*i, (self.bounds.size.width - 42) / 2, 18);
            label2.frame = CGRectMake(CGRectGetMaxX(label1.frame) + 2, CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
            label1.text = _arr3[i];
            label2.text = message.ingredient3[_arr3[i]];
            label1.backgroundColor = [UIColor whiteColor];
            label2.backgroundColor = [UIColor whiteColor];
            label2.textColor = [UIColor grayColor];
            [_myView3 addSubview:label1];
            [_myView3 addSubview:label2];
        }
    }
    self.lab2 = [[UILabel alloc]init];
    _lab2.frame = CGRectMake(20, CGRectGetMaxY(_myView3.frame) + 10, 100, 50);
    _lab2.textColor= [UIColor colorWithRed:100/255.0 green:43/255.0 blue:40/255.0 alpha:1];
    _lab2.text = @"烹饪技巧";
    _lab2.font = [UIFont systemFontOfSize:20];
    
    
    
    if (![message.tips isEqualToString:@""]) {
        
        self.tips = [[UILabel alloc] init];
        _tips.frame = CGRectMake(20, CGRectGetMaxY(_lab2.frame) + 10, self.bounds.size.width - 40, 10);
        _tips.text = [self handleStringWithString:message.tips];
        
        _tips.numberOfLines = 0;
        //_tips.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        _tips.frame = [self adjustLabel:_tips];
        
        [self addSubview:_lab2];
        [self addSubview:_tips];
    }else{
        self.tips = [[UILabel alloc]init];
        _tips.frame = CGRectMake(20, CGRectGetMaxY(_lab2.frame) - 30, self.bounds.size.width - 40, 1);
        [self addSubview:_tips];
    }
    
    
    self.contentSize = CGSizeMake(self.bounds.size.width, CGRectGetMaxY(_tips.frame) + 20);
    

    
}

-(NSString *)handleStringWithString:(NSString *)str{
    if (str != nil) {
        NSMutableString * muStr = [NSMutableString stringWithString:str];
        while (1) {
            NSRange range = [muStr rangeOfString:@"<"];
            NSRange range1 = [muStr rangeOfString:@">"];
            if (range.location != NSNotFound) {
                NSInteger loc = range.location;
                NSInteger len = range1.location - range.location;
                [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
                
            }else{
                break;
            }
        }
        //return muStr;
        // 去除字符串里面的 “&nbsp;”
         return [muStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }else{
        NSMutableString * muStr = [NSMutableString string];
        //return muStr;
         return [muStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }
}






- (CGFloat)heightForLabel:(NSString *)aString
{
    CGRect d = [aString boundingRectWithSize:CGSizeMake(self.bounds.size.width - 40, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil] ;
    return d.size.height;
}

- (CGRect)adjustLabel:(UILabel *)aLabel
{
    CGRect tmp = aLabel.frame;
    tmp.size.height = [self heightForLabel:aLabel.text];
    return tmp;
    
}



@end
