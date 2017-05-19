//
//  DevProfileViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "DevProfileViewController.h"
#import "NewRequestViewController.h"

@interface DevProfileViewController ()

@end

@implementation DevProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.devDetailProfileImage.image = self.developer.profilePicture;
   
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.devDetailUsernameLabel.text = self.developer.username;
    
    NSString *firstLanguage = [self.developer.languages objectAtIndex:0];
    self.devDetailLanguagesLabel.text = firstLanguage;
    self.devDetailCityLabel.text = self.developer.city;
    self.devDetailStateLabel.text = self.developer.state;
    self.devDetailEmailLabel.text = self.developer.email;
    self.devDetailPhoneLabel.text = self.developer.phone;
    
    
NSLog(@"email%@",self.developer.email);
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"createNewRequest"]) {
        NewRequestViewController *requestVC = segue.destinationViewController;
        requestVC.developer = self.developer;
        requestVC.organization = self.organization;
    }
}


@end
