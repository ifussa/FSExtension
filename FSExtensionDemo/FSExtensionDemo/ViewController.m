//
//  ViewController.m
//  FSExtensionDemo
//
//  Created by Fussa on 2019/10/28.
//  Copyright © 2019 Fussa. All rights reserved.
//

#import "ViewController.h"
#import "FSHeader.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:label];
    label.text = @"DEMO";
    label.textAlignment = NSTextAlignmentCenter;


    self.view.backgroundColor = [UIColor fs_randomColorWithAlpha:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD fs_showSuccess:@"SUCCESS"];
    });

}


@end
