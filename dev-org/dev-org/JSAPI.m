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
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/dev"];

    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@", session);
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"ROOT OBJECT:%@", rootObject);
        
        NSMutableArray *allDevs = [[NSMutableArray alloc]init];
        // Commenting out until object properties match JSON returned
//        Developer *dev = [[Developer alloc] init];
//        [dev setValuesForKeysWithDictionary:rootObject];
//        [allDevs addObject:dev];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([allDevs copy]);
            });
        }
    }] resume];
    
}


+(void)fetchAllOrganizations:(NPOCompletion)completion{
    
}

@end
