//
//  JSONSchemaValidator.m
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import "JSONSchemaValidator.h"

@implementation JSONSchemaValidator

+ (SchemaValidationResult *) validate:(NSObject *)object with:(NSDictionary *)schema {
    if([object isKindOfClass:[NSString class]]) {
        return [[self class] validateString:(NSString *)object with:schema];
    }
    if([object isKindOfClass:[NSNumber class]]) {
        return [[self class] validateNumber:(NSNumber *)object with:schema];
    }
    return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Invalid object! Object type cannot be validated with schema."];
}

+ (SchemaValidationResult *) validateString:(NSString *)stringToValidate with:(NSDictionary *)schema {
    if(schema[@"type"] && [schema[@"type"] isKindOfClass:[NSString class]] && [schema[@"type"] isEqualToString:@"string"]) {
        if(schema[@"minLength"] && [schema[@"minLength"] isKindOfClass:[NSString class]] && [stringToValidate length] < [schema[@"minLength"] longValue]) {
            return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Too short!"];
        }
        if(schema[@"maxLength"] && [schema[@"maxLength"] isKindOfClass:[NSString class]] && [stringToValidate length] > [schema[@"maxLength"] longValue]) {
            return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Too long!"];
        }
        if(schema[@"pattern"] && [schema[@"pattern"] isKindOfClass:[NSString class]]) {
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", schema[@"pattern"]];
            if (![predicate evaluateWithObject:stringToValidate]) {
                return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Failed to match regular expression."];
            }
        }
        return [[SchemaValidationResult alloc] initValidResultWithMessage:@"Okay!"];
    }
    return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Invalid string! Type not defined as string in schema!"];
}

+ (SchemaValidationResult *) validateNumber:(NSNumber *)number with:(NSDictionary *)schema {
    if(schema[@"type"] && [schema[@"type"] isEqualToString:@"number"]) {
        if(schema[@"multipleOf"] && [schema[@"multipleOf"] isKindOfClass:[NSNumber class]] && [number integerValue] % [schema[@"multipleOf"] integerValue] != 0) {
            return [[SchemaValidationResult alloc] initInvalidResultWithMessage:[NSString stringWithFormat:@"Number not multiple of %@", schema[@"multipleOf"]]];
        }
        if(schema[@"minimum"] && [schema[@"minimum"] isKindOfClass:[NSNumber class]]) {
            if(schema[@"exclusiveMinimum"] && [schema[@"exclusiveMinimum"] isKindOfClass:[NSNumber class]]) {
                
            }
            else {
                if(number.doubleValue < [schema[@"minimum"] doubleValue]) {
                    
                }
            }
        }
        
        return [[SchemaValidationResult alloc] initValidResultWithMessage:@"Okay!"];
    }
    if(schema[@"type"] && [schema[@"type"] isEqualToString:@"integer"]) {
        if([number integerValue] - [number floatValue] != 0) {
            return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Invalid number! Number must be of type integer!"];
        }
        if(schema[@"multipleOf"] && [number integerValue] % [schema[@"multipleOf"] integerValue] != 0) {
            return [[SchemaValidationResult alloc] initInvalidResultWithMessage:[NSString stringWithFormat:@"Number not multiple of %@", schema[@"multipleOf"]]];
        }
        return [[SchemaValidationResult alloc] initValidResultWithMessage:@"Okay!"];
    }
    return [[SchemaValidationResult alloc] initInvalidResultWithMessage:@"Invalid number! Type not defined as number in schema!"];
}

@end
