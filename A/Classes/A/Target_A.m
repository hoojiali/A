//
//  Target_A.m
//  A_Example
//
//  Created by hoojiali on 2021/3/24.
//  Copyright © 2021 hoojiali. All rights reserved.
//

#import "Target_A.h"
#import "AViewController.h"

@implementation Target_A

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    // Target在A的命名域中,可随意import A业务线中的任何头文件
    AViewController *viewController = [[AViewController alloc] init];
    return viewController;
}

@end
