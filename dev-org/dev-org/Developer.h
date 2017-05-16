//
//  Developer.h
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "User.h"

@interface Developer : User

@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSArray *services;
@property (nonatomic) Boolean isAvailable;
@property (strong, nonatomic) NSString *radius;
@property (strong, nonatomic) NSArray *projects;

@end
