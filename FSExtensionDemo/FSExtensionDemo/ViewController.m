//
//  ViewController.m
//  FSExtensionDemo
//
//  Created by Fussa on 2019/10/28.
//  Copyright © 2019 Fussa. All rights reserved.
//

#import "ViewController.h"
#import "FSHeader.h"
#import "FSGlobal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer fs_scheduledTimerWithTimeInterval:3.0 block:^(NSTimer *timer) {
        self.view.backgroundColor = [UIColor fs_randomColor];
    } repeats:YES];
}


@end
