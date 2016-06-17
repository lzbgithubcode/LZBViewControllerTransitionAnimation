//
//  ViewController.m
//  转场动画
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "OnePresentViewController.h"
#import "OneViewController.h"
#import "oneCustomModalViewContoller.h"
#import "oneQQPhoneViewController.h"
#import "oneBubbleViewController.h"
#import "onePageViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <UIViewController *>*animationTypeVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择转场动画效果";
    self.tableView.backgroundColor =[UIColor whiteColor];
    self.animationTypeVC = @[[[OnePresentViewController alloc]initWithTitle:@"modal模态转场动画"],[[OneViewController alloc] initWithTitle:@"push导航转场动画"],[[oneCustomModalViewContoller alloc]initWithTitle:@"自定义modal"],[[oneQQPhoneViewController alloc]initWithTitle:@"高仿QQ电话启动"],[[oneBubbleViewController alloc]initWithTitle:@"气泡转场效果"],[[onePageViewController alloc]initWithTitle:@"翻页转场效果"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animationTypeVC.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellID = @"UITableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellID];
    }
    UIViewController *vc = self.animationTypeVC[indexPath.row];
    cell.textLabel.text = vc.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:self.animationTypeVC[indexPath.row] animated:YES];
}



- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
