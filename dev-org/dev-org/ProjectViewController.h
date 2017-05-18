//
//  ProjectViewController.h
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"

@interface ProjectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;

@property(strong, nonatomic) Organization *organization;
@end
