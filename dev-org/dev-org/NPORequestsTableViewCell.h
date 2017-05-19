//
//  DevRequestsTableViewCell.h
//  dev-org
//
//  Created by Rio Balderas on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"

@interface NPORequestsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *orgImage;

@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) Organization *organization;

@end
