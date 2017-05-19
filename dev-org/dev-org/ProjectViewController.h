//
//  ProjectViewController.h
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"
#import "Project.h"

@interface ProjectViewController : UIViewController


@property(strong, nonatomic) Organization *organization;
@property (strong, nonatomic) Project *project;
@end
