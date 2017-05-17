//
//  Review.h
//  dev-org
//
//  Created by Robert Hatfield on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (strong, nonatomic) NSString *projectID;
@property (strong, nonatomic) NSString *devID;
@property (strong, nonatomic) NSString *npoID;
@property (nonatomic) int stars;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *dateStart;
@property (strong, nonatomic) NSString *dateEnd;

@end
