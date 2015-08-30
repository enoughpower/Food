//
//  SearchView.m
//  Cookbook
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 牛清旭. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation SearchView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    self.imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width+100  , self.frame.size.height+100);
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_imageView];
    

    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    


}
-(void)timeAction:(id)sender
{
//    self.imageView = [[UIImageView alloc] init];
//    _imageView.frame = CGRectMake(0, 0, self.frame.size.width+200  , self.frame.size.height+200);
//    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%4+1]];
//    [self addSubview:imageView];
    
    [UIView animateWithDuration:3 animations:^{
        self.imageView.center = CGPointMake(arc4random()%100 + 100, arc4random()%200 + 200);
    }];
}






@end
