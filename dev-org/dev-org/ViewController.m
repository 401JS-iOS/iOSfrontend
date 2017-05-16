//
//  ViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *allDevs;
@property (strong, nonatomic) NSArray *allOrgs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [JSAPI fetchAllDevelopers:^(NSArray<Developer *> *allDevs) {
        self.allDevs = allDevs;
        NSLog(@"Developers: %@", self.allDevs);
    }];

    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        self.allOrgs = allOrganizations;
        NSLog(@"Organizations: %@", self.allOrgs);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
