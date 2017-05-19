//
//  OrgHomeViewController.h
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSAPI.h"
#import "DevCell.h"
#import "Developer.h"
#import "DevProfileViewController.h"
#import "Organization.h"

@interface OrgHomeViewController : UIViewController

@property (strong, nonatomic) Organization *org;
@end

