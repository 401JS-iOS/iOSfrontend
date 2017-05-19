//
//  DevProfileViewController.h
//  dev-org
//
//  Created by Rio Balderas on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Developer.h"
#import "Organization.h"

@interface DevProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *devDetailProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *devDetailUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *devDetailLanguagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *devDetailCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *devDetailStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *devDetailEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *devDetailPhoneLabel;

@property(strong, nonatomic) Developer *developer;
@property(strong, nonatomic) Organization *organization;

@end
