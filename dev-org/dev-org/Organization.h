//
//  Organization.h
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "User.h"

@interface Organization : User

@property (strong, nonatomic) NSString* org;
@property (strong, nonatomic) NSArray* projects;

@end
