//
//  NewRequestViewController.h
//  dev-org
//
//  Created by Robert Hatfield on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Developer.h"
#import "Organization.h"

@interface NewRequestViewController : UIViewController

@property (strong, nonatomic) Organization *organization;
@property (strong, nonatomic) Developer *developer;

@end
