//
//  NPODetailsViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/18/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "NPODetailsViewController.h"

@interface NPODetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *NPOImage;

@property (weak, nonatomic) IBOutlet UILabel *NPOName;
@property (weak, nonatomic) IBOutlet UILabel *NPOCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOPhoneLabel;
@end

@implementation NPODetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *ImageURL = self.organization.profilePic;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    
    self.NPOName.text = self.organization.org;
//    self.NPOImage.image = [UIImage imageWithData:imageData];
    self.NPOCityLabel.text = self.organization.city;
    self.NPOStateLabel.text = self.organization.state;
    self.NPOEmailLabel.text = self.organization.email;
    self.NPOPhoneLabel.text = self.organization.phone;

}

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)swippedDown:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
