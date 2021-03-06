//
//  JSAPIPOSTRequest.m
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "JSAPIPOSTRequest.h"

@implementation JSAPIPOSTRequest

+(void)postProject:(Project *)project withToken:(NSString *)userToken andCompletion:(ProjectPOSTCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/npo/%@/project", project.orgID];
    //npoID/project
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    if (!project.dev) {
        project.dev = @"";
    }
    NSDictionary *projectDictionary = @{@"dev":project.dev, @"desc": project.projectDescription, @"service": project.service};
    
    NSError *error = nil;
    NSData *userData =[NSJSONSerialization dataWithJSONObject:projectDictionary
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[databaseURL standardizedURL]];
    request.HTTPMethod = @"POST";
//    NSString *userToken = [NSString stringWithFormat:@"Bearer %@",org.userToken];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:userToken forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:userData];
    
    
    
    if (!error) {
        
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            
            NSDictionary *projectObject = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Project:%@", projectObject);
                    completion(projectObject);
                });
            }
        }] resume];
    }

    
        
}

+ (void)postUser:(User *)user withCompletion:(UserPOSTCompletion)completion{
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/signup"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    NSDictionary *userDictionary = @{@"email":user.email, @"username":user.username, @"password":user.password, @"isDev":[NSNumber numberWithBool:user.isDev]};
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

+ (void)postNPO:(Organization *)user withCompletion:(NPOPOSTCompletion)completion{
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/npo"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSDictionary *NPODictionary = @{@"org": user.org, @"city": user.city, @"state": user.state, @"phone": user.phone, @"websites": user.websites, @"orgDesc": user.orgDesc};
    
    NSError *error = nil;
    NSData *userData =[NSJSONSerialization dataWithJSONObject:NPODictionary
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[databaseURL standardizedURL]];
    request.HTTPMethod = @"POST";
    NSString *userToken = [NSString stringWithFormat:@"Bearer %@",user.userToken];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:userToken forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:userData];
    
    if (!error) {
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            NSLog(@"response: %@", response);
            NSDictionary *orgObject = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions
                                                                        error:nil];
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"orgObject:%@", orgObject);
                    completion(orgObject);
                });
            }
        }] resume];
    }
}

+ (void)postDev:(Developer *)user withCompletion:(DevPOSTCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"https://d3volunteers.herokuapp.com/api/dev"];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    int randomNumber = (int)arc4random_uniform(3);
    NSString *firstLanguage = [[NSString alloc] init];
    switch (randomNumber) {
        case 0:
            firstLanguage = @"HTML";
            break;
        case 1:
            firstLanguage = @"JavaScript";
            break;
        case 2:
            firstLanguage = @"Objective-C";
            break;
        default:
            firstLanguage = @"Swift 3.0";
            break;
    }
    
    NSArray *languages = [NSArray arrayWithObjects:firstLanguage, nil];
    
    NSDictionary *devDictionary = @{@"city": user.city, @"state": user.state, @"phone": user.phone, @"websites": user.websites, @"services":user.services, @"languages": languages};


    NSError *error = nil;
    NSData *userData =[NSJSONSerialization dataWithJSONObject:devDictionary
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[databaseURL standardizedURL]];
    request.HTTPMethod = @"POST";
    NSString *userToken = [NSString stringWithFormat:@"Bearer %@",user.userToken];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:userToken forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:userData];
    
    
    
    if (!error) {
        
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            
            NSString *stringForm = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"String: %@", stringForm);
            
            NSDictionary *devObject = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:nil];
            NSLog(@"data: %@", data);
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"devObject:%@", devObject);
                    completion(devObject);
                });
            }
        }] resume];
    }

}

@end
