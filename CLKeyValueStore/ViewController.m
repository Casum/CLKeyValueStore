//
//  ViewController.m
//  CLKeyValueStore
//
//  Created by Casum Leung on 16/1/21.
//  Copyright © 2016年 Casum. All rights reserved.
//

#import "ViewController.h"
#import "CLKeyValueStore.h"

NSString *const kSpaceName = @"Test";
NSString *const kKey = @"Key";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SET_CACHEOBJ(@"Test..Test", kKey, kSpaceName)
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *result = CACHE_OBJ(kKey, kSpaceName)
    NSLog(@"Cache Object: %@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
