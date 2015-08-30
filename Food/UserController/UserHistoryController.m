//
//  UserHistoryController.m
//  Food
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "UserHistoryController.h"
#import "ClassifyCell.h"
#import "UIImageView+WebCache.h"
#import "DetailMessage.h"
#import "DetailViewController.h"
#import "CHNotices.h"
@interface UserHistoryController ()
@property (nonatomic, strong)NSMutableArray *history;
@end

@implementation UserHistoryController
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
    NSFileManager *manager = [[NSFileManager alloc]init];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *messagePath = [documentPath stringByAppendingPathComponent:@"DetailMessageHistory/DetailMessageHistory"];
    if ([manager fileExistsAtPath:messagePath]) {
        self.history = [NSKeyedUnarchiver unarchiveObjectWithFile:messagePath];
        
    }else{
        self.history = [NSMutableArray array];
    }
    [self.tableView reloadData];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"最近浏览";
    [self.tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"clear"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clearAction:)];
    
}

- (void)clearAction:(UIBarButtonItem *)sender
{
    NSFileManager *manager = [[NSFileManager alloc]init];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *messagePath = [documentPath stringByAppendingPathComponent:@"DetailMessageHistory/DetailMessageHistory"];
    BOOL creat = [manager removeItemAtPath:messagePath error:nil];
    if (creat == YES) {
        self.history = nil;
        [CHNotices noticesWithTitle:@"删除成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
        [self.tableView reloadData];
    }else{
        [CHNotices noticesWithTitle:@"删除失败" Time:1 View:self.view Style:CHNoticesStyleFail];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DetailMessage *m = _history[indexPath.row];
    [cell.classifyImage sd_setImageWithURL:[NSURL URLWithString:m.cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.titleLabel.text = m.title;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:20.f];
    }else {
        cell.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.f];
        cell.detailLabel.font = [UIFont systemFontOfSize:13.f];
    }
    cell.detailLabel.alpha = 0.7;
    cell.detailLabel.text = [self handleStringWithString:m.message];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return 150;
    }else {
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailMessage *m = _history[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.message = m;
    detail.ID = m.ID;
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
