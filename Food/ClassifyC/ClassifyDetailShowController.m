//
//  ClassifyDetailShowController.m
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassifyDetailShowController.h"
#import "ClassifyDetailViewController.h"
#import "ClassifyDetailController.h"
@interface ClassifyDetailShowController ()
{
    BOOL _isShowList;
}

@property(nonatomic,strong)ClassifyDetailController *detail;
@property(nonatomic,strong)ClassifyDetailViewController *show;

@end

@implementation ClassifyDetailShowController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ex.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.title = self.PassValuetitle;
    
    
    
    _detail = [[ClassifyDetailController alloc] init];
    _detail.IDString = self.IDString;
    _detail.PassValuetitle = self.PassValuetitle;
    _detail.view.frame = self.view.bounds;
    [self addChildViewController:_detail];
    
    _show = [[ClassifyDetailViewController alloc] init];
    _show.IDString = self.IDString;
    _show.PassValuetitle = self.PassValuetitle;
    _show.view.frame = self.view.bounds;
    [self addChildViewController:_show];
 
    _isShowList = NO;
    [self.view addSubview:_detail.view];
    
    
}

- (void)rightAction:(UIBarButtonItem *)sender
{
    if (_isShowList == NO) {
        
        [UIView transitionFromView:_detail.view toView:_show.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromRight ) completion:nil];
        
    }
    else
    {
        [UIView transitionFromView:_show.view toView:_detail.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft ) completion:nil];
       
    }
    _isShowList = !_isShowList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
