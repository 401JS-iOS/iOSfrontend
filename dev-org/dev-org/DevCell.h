//
//  DevCell.h
//  dev-org
//
//  Created by Rio Balderas on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *devProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *devProjectTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *devUsernameLabel;

@end
