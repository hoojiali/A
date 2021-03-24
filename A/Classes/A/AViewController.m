//
//  AViewController.m
//  MainProject
//
//  Created by hoojiali on 2021/3/24.
//

#import "AViewController.h"
#import "CTMediator+B.h"

// #import "BViewController.h"

// 由于我们这次组件化实施的目的仅仅是将A业务线抽出来，
// BViewController是属于B业务线的，所以我们没必要把B业务也从主工程里面抽出来。
// 为了能够让A工程编译通过，我们需要提供一个B_Category来使得A工程可以调度到B，同时也能够编译通过

static NSString *const kCellIdf = @"CellIdf";

@interface AViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"A_ViewC";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableFooterView = [UIView new];
        [_table registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:kCellIdf];
    }
    return _table;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@0, @1, @2, @3];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdf forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource[indexPath.row] stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 到此为止主工程就改完了，现在跑主工程点击这个按钮跳不到A页面是正常的，因为我们还没有在A工程中实现Target-Action
    // 而且此时主工程中关于A业务的改动就全部结束了，后面的组件化实施过程中，就不会再有针对A业务线对主工程的改动了。
    UIViewController *vc = [CT() B_viewControllerWithContentText:@"hello"];
    NSLog(@"show tempA: %@", vc);
    if (vc && [vc isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
#if 0
    BViewController *bvc = [[BViewController alloc] init];
    bvc.info = [self.dataSource[indexPath.row] stringValue];
    [self.navigationController pushViewController:bvc animated:YES];
#endif
    
}

@end
