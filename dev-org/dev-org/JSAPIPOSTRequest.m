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

+(void)postUser:(UserPOSTCompletion)completion{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/users"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[databaseURL standardizedURL]];
    [request setHTTPMethod:@"POST"];
    
//    NSString *postData = @"email=%@&username=%@&password=%@&isDev=%@", *self.email, self.username,self.password, self.isDev;
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
 
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  

//    "email": "email",
//    "isDev": true,
//    "password": "passwords",
//    "username": "someuser"
    
}

@end
