//
//  DetailStepViewController.m
//  Food
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "DetailStepViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailStepViewCell.h"
@interface DetailStepViewController ()
@property (nonatomic, strong)NSMutableArray *note;
@property (nonatomic, strong)NSMutableArray *pic;
@end

@implementation DetailStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.note = [NSMutableArray array];
    self.pic = [NSMutableArray array];
    for (NSDictionary *dic in self.step) {
        NSString *note = dic[@"note"];
        NSString *pic = dic[@"pic"];
        [_note addObject:note];
        [_pic addObject:pic];
    }
    //DLog(@"%@", _pic);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DetailStepViewCell class] forCellReuseIdentifier:@"cell"];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _note.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailStepViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.num.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1] ;
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:_pic[indexPath.row]] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.myLabel.text = _note[indexPath.row];
    //DLog(@"%@", cell.myLabel.text);
    cell.myLabel.frame = CGRectMake(40, 5, self.view.bounds.size.width - 50,  [self heightForLabel:cell.myLabel.text]);
    
    
    
    
    return cell;
}


- (CGFloat)heightForLabel:(NSString *)aString
{
    CGRect d = [aString boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 50, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil] ;
    return d.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForLabel:_note[indexPath.row]] + ((self.view.bounds.size.width - 40) /4*3) + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
