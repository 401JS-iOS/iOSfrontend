//
//  NPODetailsViewController.h
//  dev-org
//
//  Created by Rio Balderas on 5/18/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPODetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NPOImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NPONameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *NPOPhoneLabel;

@end
