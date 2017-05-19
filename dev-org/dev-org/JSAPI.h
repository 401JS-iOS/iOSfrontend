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
#import "Project.h"
#import "Review.h"

typedef void(^DevCompletion)(NSArray<Developer *> *allDevs);
typedef void(^NPOCompletion)(NSArray<Organization *> *allOrganizations);
typedef void(^ProjectCompletion)(NSArray<Project *> *projects);
typedef void(^ReviewCompletion)(Review *review);
typedef void(^SignInCompletion)(NSString *token);

@interface JSAPI : NSObject


+(void)signInWithUsername:(NSString*)username password:(NSString*)password andCompletion:(SignInCompletion)completion;

+(void)fetchAllDevelopers:(DevCompletion)completion;

+(void)fetchAllOrganizations:(NPOCompletion)completion;

+(void)fetchProjects:(ProjectCompletion)completion;

+(void)fetchReview:(ReviewCompletion)completion;


@end
