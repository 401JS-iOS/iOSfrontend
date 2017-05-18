//
//  JSAPIPOSTRequest.h
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"
#import "Developer.h"
#import "User.h"
#import "Project.h"
#import "Review.h"

@interface JSAPIPOSTRequest : NSObject

typedef void(^ProjectPOSTCompletion)(NSDictionary *project);
typedef void(^UserPOSTCompletion)(NSString *identifier);
typedef void(^NPOPOSTCompletion)(NSDictionary *user);
typedef void(^DevPOSTCompletion)(NSDictionary *user);


+(void)postProject:(Project *)project :(User *)user withCompletion:(ProjectPOSTCompletion)completion;
+ (void)postUser:(User *)user withCompletion:(UserPOSTCompletion)completion;
+ (void)postNPO:(Organization *)user withCompletion:(NPOPOSTCompletion)completion;
+ (void)postDev:(Developer *)user withCompletion:(DevPOSTCompletion)completion;

@end
