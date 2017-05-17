//
//  Developer.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "Developer.h"

@interface Developer () <NSCoding>

@end

@implementation Developer

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    //    [super encodeWithCoder];
    [coder encodeObject:_languages forKey:@"languages"];
    [coder encodeObject:_services forKey:@"services"];
    [coder encodeBool:_isAvailable forKey:@"isAvailable"];
    [coder encodeObject:_radius forKey:@"radius"];
    [coder encodeObject:_projects forKey:@"projects"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _languages = [decoder valueForKey:@"languages"];
    _services = [decoder valueForKey:@"services"];
    _isAvailable = [decoder decodeBoolForKey:@"isAvailable"];
    _radius = [decoder valueForKey:@"radius"];
    _projects = [decoder valueForKey:@"projects"];
    
    return self;
}

@end
