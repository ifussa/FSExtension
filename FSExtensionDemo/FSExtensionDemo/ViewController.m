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
}


@end
