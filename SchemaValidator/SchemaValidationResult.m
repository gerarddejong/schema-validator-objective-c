//
//  SchemaValidationResult.m
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import "SchemaValidationResult.h"

@implementation SchemaValidationResult

- (instancetype)initValidResultWithMessage:(NSString *)message {
    self = [super init];
    if (self) {
        [self setIsValid:YES];
        [self setMessage:message];
    }
    return self;
}

- (instancetype)initInvalidResultWithMessage:(NSString *)message {
    self = [super init];
    if (self) {
        [self setIsValid:NO];
        [self setMessage:message];
    }
    return self;
}

@end
