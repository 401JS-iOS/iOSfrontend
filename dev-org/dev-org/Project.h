//
//  Project.h
//  dev-org
//
//  Created by Robert Hatfield on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"
#import "Review.h"

@interface Project : NSObject

@property (strong, nonatomic) Organization *npoId;
@property (strong, nonatomic) NSString *service;
@property (strong, nonatomic) NSArray *devs;
@property (strong, nonatomic) NSArray<Review *> *reviews;
@property (strong, nonatomic) NSString *projectDescription;

@end
