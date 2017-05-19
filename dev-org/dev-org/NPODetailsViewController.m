//
//  NPODetailsViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/18/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "NPODetailsViewController.h"

@interface NPODetailsViewController ()

@end

@implementation NPODetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)swippedDown:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
