//
//  ViewController.m
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "ViewController.h"
#import "SREmptyDataView.h"
#import "UIScrollView+SREmptyData.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self requestData];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    
    _tableView.sr_emptyDataView = [SREmptyDataView sr_emptyDataViewWithIcon:@"no_data" title:@"No data title" detail:@"No data detail infomation" btnTitle:@"Retry button" btnBlock:^{
        [self.tableView sr_startLoadingData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.datas addObjectsFromArray:@[@"Test data", @"Test data", @"Test data"]];
            [self.tableView reloadData];
            [self.tableView sr_endLoadingData];
        });
    }];
    _tableView.sr_emptyDataView.autoManagement = NO; // 手动管理空白视图的显示和隐藏
}

- (void)requestData {
    [self.tableView sr_startLoadingData]; // 加载数据前调用此方法, 隐藏空白视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.datas addObjectsFromArray:@[@"Test data", @"Test data", @"Test data"]];
        [self.tableView reloadData];
        [self.tableView sr_endLoadingData]; // 加载数据完成后调用此方法, 根据列表是否有数据来决定是否显示空白视图
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addData:(id)sender {
    [self.datas addObject:@"Test data"];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    if (self.tableView.sr_emptyDataView.autoManagement == NO) {
        [self.tableView sr_hideEmptyDataView];
    }
}

- (IBAction)removeData:(id)sender {
    if (self.datas.count > 0) {
        [self.datas removeObjectAtIndex:0];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        if (self.tableView.sr_emptyDataView.autoManagement == NO && self.datas.count == 0) {
            [self.tableView sr_showEmptyDataView];
        }
    }
}

@end
