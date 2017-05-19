//
//  ProjectViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "ProjectViewController.h"
#import "JSAPI.h"
#import "Project.h"


@interface ProjectViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *orgImage;
@property (weak, nonatomic) IBOutlet UILabel *projectDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeLabel;
@property (strong, nonatomic) Project *currProject;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *ImageURL = self.organization.profilePic;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    
    self.orgNameLabel.text = self.organization.org;
    self.orgImage.image = [UIImage imageWithData:imageData];
    self.serviceTypeLabel.text = self.project.service;
    self.projectDescriptionLabel.text = self.project.projectDescription;
}
- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    
    UIStoryboard *storyboard = self.storyboard;
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NPODetailsViewController"];
    [self presentViewController:vc animated:YES completion:nil];

}

- (IBAction)applybuttonPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Status"
                                message:@"Project request Accepted"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Ok was pressed");
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)slideToLeftWithGestureRecognizer:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NPODetailsViewController" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NPODetailsViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
