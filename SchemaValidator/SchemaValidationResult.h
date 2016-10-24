//
//  SchemaValidationResult.h
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchemaValidationResult : NSObject

@property (nonatomic) BOOL isValid;
@property (strong, nonatomic) NSString * message;

- (instancetype)initValidResultWithMessage:(NSString *)message;
- (instancetype)initInvalidResultWithMessage:(NSString *)message;

@end
