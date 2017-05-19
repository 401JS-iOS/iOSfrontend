//
//  Organization.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "Organization.h"

@interface Organization () <NSCoding>

@end

@implementation Organization

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:_orgID forKey:@"orgID"];
    [coder encodeObject:_org forKey:@"org"];
    [coder encodeObject:_projects forKey:@"projects"];
    [coder encodeObject:_orgDesc forKey:@"orgDesc"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    
    _orgID = [decoder decodeObjectForKey:@"orgID"];
    _org = [decoder decodeObjectForKey:@"org"];
    _projects = [decoder decodeObjectForKey:@"projects"];
    _orgDesc = [decoder decodeObjectForKey:@"orgDesc"];
    
    return self;
}

@end
