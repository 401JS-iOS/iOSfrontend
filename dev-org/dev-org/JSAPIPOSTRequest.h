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

typedef void(^ProjectPOSTCompletion)(Project *project);
typedef void(^UserPOSTCompletion)(User *user);

@property(strong, nonatomic) NSURLConnection *connection;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *password;
@property(nonatomic) Boolean *isDev;


+(void)postProject:(ProjectPOSTCompletion)completion;
+(void)postUser:(UserPOSTCompletion)completion;

@end
