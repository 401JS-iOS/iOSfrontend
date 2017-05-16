//
//  ViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [JSAPI fetchAllDevelopers:^(NSArray<Developer *> *allDevs) {
        NSLog(@"Developers: %@", allDevs);
        if (allDevs[0].isAvailable) {
            NSLog(@"Developer is available");
        } else {
            NSLog(@"Developer is NOT available");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
