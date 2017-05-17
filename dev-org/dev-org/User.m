//
//  User.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "User.h"

@interface User () <NSCoding>

@end

@implementation User

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_userID forKey:@"userID"];
    [coder encodeObject:_username forKey:@"username"];
    [coder encodeObject:_email forKey:@"email"];
    [coder encodeObject:_address forKey:@"address"];
    [coder encodeObject:_city forKey:@"city"];
    [coder encodeObject:_state forKey:@"state"];
    [coder encodeObject:_phone forKey:@"phone"];
    [coder encodeObject:_profilePic forKey:@"profilePic"];
    [coder encodeObject:_websites forKey:@"websites"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _userID = [decoder decodeObjectForKey:@"userID"];
    _username = [decoder decodeObjectForKey:@"username"];
    _email = [decoder decodeObjectForKey:@"email"];
    _address = [decoder decodeObjectForKey:@"address"];
    _city = [decoder decodeObjectForKey:@"city"];
    _state = [decoder decodeObjectForKey:@"state"];
    _phone = [decoder decodeObjectForKey:@"phone"];
    _profilePic = [decoder decodeObjectForKey:@"profilePic"];
    _websites = [decoder decodeObjectForKey:@"websites"];

    return self;
}

@end
