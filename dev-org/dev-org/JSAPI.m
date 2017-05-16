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
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/npos"];
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
                    [org setValuesForKeysWithDictionary:orgDictionary];
                    [allOrgs addObject:org];
                }
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion([allOrgs copy]);
                    });
                }
            }] resume];
}

+(void)fetchProject:(ProjectCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/project"];
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
                Project *project = [[Project alloc] init];
                [project setValuesForKeysWithDictionary:rootObject];
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(project);
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
