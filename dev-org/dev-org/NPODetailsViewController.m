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
    *NPOImage;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *NPONameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *NPOCityLabel;
    @property (weak, nonatomic) IBOutlet UILabel *NPOStateLabel;
    @property (weak, nonatomic) IBOutlet UILabel *NPOEmailLabel;
    @property (weak, nonatomic) IBOutlet UILabel *NPOPhoneLabel;

}
- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)swippedDown:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
