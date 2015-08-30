//
//  DetailViewController.m
//  Food
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "requestTool.h"
#import "DetailMessage.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "GMDCircleLoader.h"
#import "DetailStepViewCell.h"
#import "CommentViewCell.h"
#import "UserLogInController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CHNotices.h"
#define urlstr @"http://api.2meiwei.com/v1/recipe/"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, UITextFieldDelegate>
{
    BOOL haveItem;
    BOOL haveHistory;
    
}



// 存放制作步骤的信息
@property (nonatomic, strong)NSMutableArray *note;
// 存放制作步骤的图片
@property (nonatomic, strong)NSMutableArray *pic;
// 存放用户收藏的菜谱
@property (nonatomic, strong)NSArray *searchArray;
// 存放用户评论信息
@property (nonatomic, strong)NSMutableArray *commentArr;
// 存放用户浏览纪录
@property (nonatomic, strong)NSMutableArray *historyMessages;
// 详细介绍视图
@property (nonatomic, strong)DetailView *dv;
// 评论视图
@property (nonatomic, strong)UITableView *comtv;
// 制作步骤视图
@property (nonatomic, strong)UITableView *tv;
// segment
@property (nonatomic, strong)UISegmentedControl *seg;
// scrollView容器
@property (nonatomic, strong)UIScrollView *sv;
// 存放评论文本框和按钮
@property (nonatomic, strong)UIView *textView;
// 输入框
@property (nonatomic, strong)UITextField *commentText;
// 按钮
@property (nonatomic, strong)UIButton *sendButton;
@property (nonatomic, strong)UITextField *textFiled;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}



// 页面消失前保存历史记录
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    NSFileManager *manager = [[NSFileManager alloc]init];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [manager createDirectoryAtPath:[documentPath stringByAppendingPathComponent:@"DetailMessageHistory"] withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *messagePath = [documentPath stringByAppendingPathComponent:@"DetailMessageHistory/DetailMessageHistory"];
    // 获取历史记录
    if ([manager fileExistsAtPath:messagePath]) {
        self.historyMessages = [NSKeyedUnarchiver unarchiveObjectWithFile:messagePath];
        
    }else{
        self.historyMessages = [NSMutableArray array];
    }
    // 遍历数组，如果已经有重复的就不添加
    haveHistory = NO;
    for (DetailMessage *m in _historyMessages) {
        if ([m.title isEqualToString:_message.title]) {
            haveHistory = YES;
            break;
        }
    }
    if (haveHistory == NO) {
        // 添加对象
        [self.historyMessages addObject:self.message];
        // 写入文件
        BOOL a = [NSKeyedArchiver archiveRootObject:self.historyMessages toFile:messagePath];
        DLog(@"%@  %d", messagePath, a);
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
        [self p_setupView];
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    reach.reachableBlock = ^(Reachability *reach){
        [self p_makeData];
    };
    if (reach.isReachable == YES) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        [self p_makeData];
    }else{
        [GMDCircleLoader setOnView:self.view withTitle:@"网络无连接..." animated:YES];
        // 没有网使用本地缓存数据
        [self.dv.foodImage sd_setImageWithURL:[NSURL URLWithString:_message.cover] placeholderImage:[UIImage imageNamed:@"pic"]];
        [self.dv.photoImage sd_setImageWithURL:[NSURL URLWithString:_message.avatar] placeholderImage:[UIImage imageNamed:@"picholder"]];
        self.dv.author.text = _message.author;
        self.dv.titleLabel.text = _message.title;
        [self.dv setView:_message];
        [self p_makeStepData];
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }

}

// 布局视图
- (void)p_setupView
{
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"制作步骤", @"详细介绍", @"评论" ]];
    [_seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    self.seg.frame = CGRectMake(0, 0, 0, 25);
    self.seg.selectedSegmentIndex = 1;
    self.navigationItem.titleView = _seg;
    
    self.sv = [[UIScrollView alloc]init];
    _sv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    _sv.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height - 64);
    //scroll.showsVerticalScrollIndicator = NO;
    _sv.pagingEnabled = YES;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.tag = 200;
    _sv.delegate = self;
    _sv.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    [self.view addSubview:_sv];
    
    self.tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:(UITableViewStyleGrouped)];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    self.tv.tag = 201;
    [self.tv registerClass:[DetailStepViewCell class] forCellReuseIdentifier:@"cell"];
    self.tv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tv.bounces = NO;
    [_sv addSubview:_tv];
    
    self.dv = [[DetailView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [_sv addSubview:_dv];
    
    self.comtv = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, self.view.frame.size.width, self.view.frame.size.height - 64-40) style:(UITableViewStyleGrouped)];
    self.comtv.delegate = self;
    self.comtv.dataSource = self;
    self.comtv.tag = 202;
    [self.comtv registerClass:[CommentViewCell class] forCellReuseIdentifier:@"comment"];
    self.comtv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.comtv.bounces = NO;
    [_sv addSubview:_comtv];
    
    self.textView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 2, CGRectGetMaxY(_comtv.frame), self.view.frame.size.width, 40)];
    _textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _textView.userInteractionEnabled = YES;
    [_sv addSubview:_textView];
    
    self.commentText = [[UITextField alloc]initWithFrame:CGRectMake(2.5, 2.5, self.view.frame.size.width - 70, 35)];
    _commentText.borderStyle = UITextBorderStyleRoundedRect;
    _commentText.delegate = self;
    _commentText.clearsOnBeginEditing = YES;
    _commentText.clearButtonMode = UITextFieldViewModeAlways;
    [_textView addSubview:_commentText];
    
    self.sendButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentText.frame) + 5, 2.5, 60, 35);
    _sendButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:78/255.0 alpha:1];
    [_sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.cornerRadius = 5;
    [_sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_textView addSubview:_sendButton];

}


#pragma mark -- 获取数据
// 获取详细介绍数据
- (void)p_makeData
{

    NSString *url = [NSString stringWithFormat:@"%@%@/", urlstr, self.ID];
    //DLog(@"%@", url);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"favorite"] style:(UIBarButtonItemStyleBordered) target:self action:@selector(favAction:)];
    [requestTool requestWithUrl:url body:nil backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        self.message = [[DetailMessage alloc]init];
        [_message setValuesForKeysWithDictionary:dict];
        // 返回主队列更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [self.dv.foodImage sd_setImageWithURL:[NSURL URLWithString:_message.cover] placeholderImage:[UIImage imageNamed:@"pic"]];
            [self.dv.photoImage sd_setImageWithURL:[NSURL URLWithString:_message.avatar] placeholderImage:[UIImage imageNamed:@"picholder"]];
            self.dv.author.text = _message.author;
            self.dv.titleLabel.text = _message.title;
            [self.dv setView:_message];
            [self p_makeStepData];
            //[self p_makeCommentMessage];
            [self.tv reloadData];
            [GMDCircleLoader hideFromView:self.view animated:YES];
        });
    }];
}
// 获取制作步骤数据
- (void)p_makeStepData
{

    self.note = [NSMutableArray array];
    self.pic = [NSMutableArray array];
    for (NSDictionary *dic in self.message.steps) {
        NSString *note = dic[@"note"];
        NSString *pic = dic[@"pic"];
        [_note addObject:note];
        [_pic addObject:pic];
    }
    //DLog(@"%@", _pic);
    //DLog(@"%@", _note);
}

// 获取评论信息
- (void)p_makeCommentMessage
{
    //DLog(@"%@", user.username);
    [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    AVQuery *querty = [AVQuery queryWithClassName:@"comment"];
    [querty selectKeys:@[@"messageid", @"commenttext", @"title",@"username"]];
    [querty whereKey:@"messageid" containsString:self.ID];
    [querty addDescendingOrder:@"createdAt"];
    [querty findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.commentArr = [NSMutableArray arrayWithArray:objects];
        //DLog(@"%@", _commentArr);
        [self.comtv reloadData];
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];


}




#pragma mark -- 按钮触发方法
// segment 触发事件
- (void)segAction:(UISegmentedControl *)sender
{
    [self.commentText resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.sv.contentOffset = CGPointMake(0, 0);
                break;
            case 1:
                self.sv.contentOffset = CGPointMake(self.view.frame.size.width, 0);
                break;
            case 2:
                self.sv.contentOffset = CGPointMake(self.view.frame.size.width * 2, 0);
                [self p_makeCommentMessage];
            default:
                break;
        }
    }];
}


// 评价发送按钮
- (void)sendButtonAction:(UIButton *)sender
{
    
    AVUser *user = [AVUser currentUser];
    if (user) {
        if ([self.commentText.text isEqualToString:@""]) {
            [CHNotices noticesWithTitle:@"你还没有写字哦" Time:1 View:self.view Style:CHNoticesStyleFail];
        }else{
            AVObject *obj = [AVObject objectWithClassName:@"comment"];
            [obj setObject:self.message.title forKey:@"title"];
            [obj setObject:self.ID forKey:@"messageid"];
            [obj setObject:user.username forKey:@"username"];
            [obj setObject:self.commentText.text forKey:@"commenttext"];
            [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self.commentArr insertObject:obj atIndex:0];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.comtv insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
                    [CHNotices noticesWithTitle:@"发送成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                    [self textFieldShouldReturn:self.commentText];
                }else{
                    [CHNotices noticesWithTitle:@"发送失败" Time:1 View:self.view Style:CHNoticesStyleFail];
                }
            }];
        }
    }else
    {
        UserLogInController *sign = [[UserLogInController alloc]init];
        UINavigationController *signNC = [[UINavigationController alloc]initWithRootViewController:sign];
        [self presentViewController:signNC animated:YES completion:nil];
        
    }
    
    
    //    DLog(@"%@", _commentText.text);
}


// 收藏按钮
- (void)favAction:(UIBarButtonItem *)sender
{
    haveItem = NO;
    AVUser *user = [AVUser currentUser];
    if (user) {
        AVQuery *querty = [AVQuery queryWithClassName:@"favorite"];
        [querty selectKeys:@[@"objectId", @"messageid", @"img", @"title",@"username"]];
        [querty whereKey:@"username" containsString:user.username];
        [querty findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.searchArray = [NSArray arrayWithArray:objects];
            for (NSDictionary *dic in _searchArray) {
                if ([self.ID isEqualToString:dic[@"messageid"]]) {
                    haveItem = YES;
                    [CHNotices noticesWithTitle:@"您已经收藏过了" Time:1 View:self.view Style:CHNoticesStyleFail];;
                    break;
                }
            }
            if (haveItem == NO) {
                AVObject *obj = [AVObject objectWithClassName:@"favorite"];
                [obj setObject:_message.title forKey:@"title"];
                [obj setObject:_message.cover forKey:@"img"];
                [obj setObject:self.ID forKey:@"messageid"];
                [obj setObject:user.username forKey:@"username"];
                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [CHNotices noticesWithTitle:@"收藏成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                    }else{
                        [CHNotices noticesWithTitle:@"收藏失败" Time:1 View:self.view Style:CHNoticesStyleFail];
                    }
                }];
            }
        }];
//        DLog(@"%@", _searchArray);
    }else{
        UserLogInController *sign = [[UserLogInController alloc]init];
        UINavigationController *signNC = [[UINavigationController alloc]initWithRootViewController:sign];
        [self presentViewController:signNC animated:YES completion:nil];

    }
}

#pragma mark -- scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = CGPointMake (self.view.frame.size.width * 2, 0);
    CGPoint currentPoint = scrollView.contentOffset;
    if ((scrollView.tag == 200) && (point.x == currentPoint.x)) {
        [self p_makeCommentMessage];
        
    }
    [self.view endEditing:YES];
    self.seg.selectedSegmentIndex = self.sv.contentOffset.x / self.view.frame.size.width;
}
#pragma mark -- textFiled代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}


- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.textView.frame = CGRectMake(self.view.frame.size.width * 2, CGRectGetMaxY(_comtv.frame)-height, self.view.frame.size.width, 40);
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.textView.frame = CGRectMake(self.view.frame.size.width * 2, CGRectGetMaxY(_comtv.frame), self.view.frame.size.width, 40);
}



#pragma mark --tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 201:
            return _note.count;
        case 202:
            return _commentArr.count;
            
    }
    return 0;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (tableView.tag) {
        case 201:
        {
            DetailStepViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.num.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1] ;
            [cell.myImage sd_setImageWithURL:[NSURL URLWithString:_pic[indexPath.row]] placeholderImage:[UIImage imageNamed:@"pic"]];
            cell.myLabel.text = [self handleStringWithString:_note[indexPath.row]];               
            //DLog(@"%@", cell.myLabel.text);
            cell.myLabel.frame = CGRectMake(40, 5, self.view.bounds.size.width - 50,  [self heightForLabel:cell.myLabel.text Width:self.view.bounds.size.width - 50]);
            return cell;
        }
        case 202:
        {
            CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
            AVObject *obj = _commentArr[indexPath.row];
            cell.userName.text = obj[@"username"];
            cell.userComment.text = obj[@"commenttext"];
            cell.userComment.frame =  CGRectMake(80, 40, CGRectGetWidth(self.view.frame) - 60 - 30, [self heightForLabel:cell.userComment.text Width:self.view.bounds.size.width - 90]);
            cell.date.text = [self p_date:obj.createdAt];
            //DLog(@"%@",obj[@"commenttext"]);
            return cell;
        }
    }
    return nil;

}


- (CGFloat)heightForLabel:(NSString *)aString Width:(CGFloat)width
{
    CGRect d = [aString boundingRectWithSize:CGSizeMake(width, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil] ;
    return d.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 201:
            return [self heightForLabel:_note[indexPath.row] Width:self.view.bounds.size.width - 50] + ((self.view.bounds.size.width - 40) /4*3) + 15;
        case 202:
            return [self heightForLabel:_commentArr[indexPath.row][@"commenttext"] Width:self.view.bounds.size.width - 90] + 70;
        default:
            return 20;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSString *)p_date:(NSDate *)date
{
    NSDate *currentdate = [NSDate date];
    NSTimeInterval time = [currentdate timeIntervalSinceDate:date];
    //DLog(@"%.2f", time);
    if (time <= 60) {
        return [NSString stringWithFormat:@"%.f秒前", time +1];
    }
    else if (time >60 && time <= 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", (time + 1)/60];
    }
    else if (time >3600 && time <= 3600 * 24) {
        return [NSString stringWithFormat:@"%.f小时前", (time + 1)/3600];
    }else{
        return [NSString stringWithFormat:@"%.f天前", (time + 1)/(3600*24)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    // Dispose of any resources that can be recreated.
}




@end
