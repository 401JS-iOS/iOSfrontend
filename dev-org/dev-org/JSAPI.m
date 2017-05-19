//
//  JSAPI.m
//  dev-org
//
//  Created by Rio Balderas on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "JSAPI.h"

@implementation JSAPI

+(void)fetchAllDevelopers:(DevCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/devs"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    [[session dataTaskWithURL:databaseURL
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        
        NSLog(@"DEV ROOT OBJECT:%@", rootObject);
        
        NSMutableArray *allDevs = [[NSMutableArray alloc]init];
        
        for (NSDictionary *devDictionary in rootObject) {
            Developer *dev = [[Developer alloc] init];
            [dev setValuesForKeysWithDictionary:devDictionary];
            [allDevs addObject:dev];
        }
            
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([allDevs copy]);
            });
        }
    }] resume];
    
}


+(void)fetchAllOrganizations:(NPOCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/npolist"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    [[session dataTaskWithURL:databaseURL
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                
                NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
                
                NSLog(@"ORG ROOT OBJECT:%@", rootObject);
                
                NSMutableArray *allOrgs = [[NSMutableArray alloc]init];
                
                for (NSDictionary *orgDictionary in rootObject) {
                    Organization *org = [[Organization alloc] init];
                    
                    NSString *orgID = [orgDictionary valueForKey:@"_id"];
                    [org setValue:orgID forKey:@"orgID"];
                    
                    NSString *city = [orgDictionary valueForKey:@"city"];
                    [org setValue:city forKey:@"city"];
                    
                    NSString *orgName = [orgDictionary valueForKey:@"org"];
                    [org setValue:orgName forKey:@"org"];
                    
                    NSString *profilePic = [orgDictionary valueForKey:@"profilePic"];
                    [org setValue:profilePic forKey:@"profilePic"];
                    
                    NSString *projects = [orgDictionary valueForKey:@"projects"];
                    [org setValue:projects forKey:@"projects"];
                    
                    NSString *state = [orgDictionary valueForKey:@"state"];
                    [org setValue:state forKey:@"state"];
                    
                    NSString *userID = [orgDictionary valueForKey:@"userID"];
                    [org setValue:userID forKey:@"userID"];
                    
                    NSString *websites = [orgDictionary valueForKey:@"websites"];
                    [org setValue:websites forKey:@"websites"];

                    [allOrgs addObject:org];
                }
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion([allOrgs copy]);
                    });
                }
            }] resume];
}

+(void)fetchProjects:(ProjectCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/projectlist"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    [[session dataTaskWithURL:databaseURL
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                
                NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
                NSLog(@"Project ROOT: %@", rootObject);
                
                NSMutableArray *allProjects = [[NSMutableArray alloc]init];
                
                for (NSDictionary *projectsDictionary in rootObject) {
                    Project *project = [[Project alloc] init];
                    
                    NSString *projectID = [projectsDictionary valueForKey:@"_id"];
                    [project setValue:projectID forKey:@"projectID"];
                    
                    NSString *projectDescription = [projectsDictionary valueForKey:@"desc"];
                    [project setValue:projectDescription forKey:@"projectDescription"];
                    
                    NSString *npoID = [projectsDictionary valueForKey:@"npoID"];
                    [project setValue:npoID forKey:@"orgID"];
                    
                    NSString *projectStatus = [projectsDictionary valueForKey:@"projStatus"];
                    [project setValue:projectStatus forKey:@"projStatus"];
                    
                    NSString *reviews = [projectsDictionary valueForKey:@"reviews"];
                    [project setValue:reviews forKey:@"reviews"];
                    
                    NSString *service = [projectsDictionary valueForKey:@"service"];
                    [project setValue:service forKey:@"service"];
                    
                    NSString *userID = [projectsDictionary valueForKey:@"userID"];
                    [project setValue:userID forKey:@"userID"];
                    [allProjects addObject:project];
                }
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion([allProjects copy]);
                    });
                }
            }] resume];
}

+(void)fetchReview:(ReviewCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/review"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    [[session dataTaskWithURL:databaseURL
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                
                NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
                Review *review = [[Review alloc] init];
                [review setValuesForKeysWithDictionary:rootObject];
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(review);
                    });
                }
            }] resume];
}

@end
