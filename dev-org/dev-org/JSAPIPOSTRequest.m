//
//  JSAPIPOSTRequest.m
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "JSAPIPOSTRequest.h"

@implementation JSAPIPOSTRequest

+(void)postProject:(ProjectPOSTCompletion)completion{
    
    //    {
    //        "devs": [
    //                 {
    //                     "devID": "devs._id"
    //                 }
    //                 ],
    //        "npoId": {
    //            "npo": {
    //                "address": "742 Evergreen Terrace",
    //                "city": "Springfield",
    //                "email": "someorg@org.org",
    //                "org": "somthing give money",
    //                "phone": "555-5465",
    //                "profilePic": "/logo.png",
    //                "projects": [
    //                             {
    //                                 "projectID": "3475457"
    //                             }
    //                             ],
    //                "state": "Ohhimod",
    //                "userID": "users._id",
    //                "username": "something"
    //            }
    //        },
    //        "projectDescription": "I need a single page app for my NPO",
    //        "reviews": [
    //                    {
    //                        "reviewID": {
    //                            "dateEnd": "5-6-33",
    //                            "dateStart": "5-15-16",
    //                            "desc": "this dev really devs hard",
    //                            "devID": "245254",
    //                            "npoID": "4535655",
    //                            "projectID": "3463246",
    //                            "stars": 4
    //                        }
    //                    }
    //                    ],
    //        "service": "single page app"
    //    }
    
}

+ (void)postUser:(User *)user withCompletion:(UserPOSTCompletion)completion{
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/signup"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    NSDictionary *userDictionary = @{@"email":user.email, @"username":user.username, @"password":user.password, @"isDev":user.isDev};
    NSError *error = nil;
    NSData *userData =[NSJSONSerialization dataWithJSONObject:userDictionary
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[databaseURL standardizedURL]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:userData];
    
    
    
    if (!error) {
        
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            NSString *token = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Token:%@", token);
                    completion(token);
                });
            }
        }] resume];
        
        
        
    }
}

@end
