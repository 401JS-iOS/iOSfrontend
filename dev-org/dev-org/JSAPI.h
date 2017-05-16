//
//  JSAPI.h
//  dev-org
//
//  Created by Rio Balderas on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"
#import "Developer.h"
#import "User.h"

typedef void(^DevCompletion)(NSArray<Developer *> *allDevs);
typedef void(^NPOCompletion)(NSArray<Organization *> *allOrganizations);

@interface JSAPI : NSObject


+(void)fetchAllDevelopers:(DevCompletion)completion;

+(void)fetchAllOrganizations:(NPOCompletion)completion;


@end
