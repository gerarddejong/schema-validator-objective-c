//
//  SchemaValidator_Numeric_Tests.m
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONSchemaValidator.h"

@interface SchemaValidator_Number_Tests : XCTestCase

@end

@implementation SchemaValidator_Number_Tests

- (void)testNumberIntegerValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"integer\"}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"integer"};
    
    XCTAssertTrue([[JSONSchemaValidator validate:@42 with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@-1 with:schema] isValid]);
    XCTAssertFalse([[JSONSchemaValidator validate:@3.1415926 with:schema] isValid]); // Floating point numbers are rejected
    XCTAssertFalse([[JSONSchemaValidator validate:@"42" with:schema] isValid]); // Numbers as strings are rejected
}

- (void)testNumberValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"number\"}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"number"};
    
    XCTAssertTrue([[JSONSchemaValidator validate:@42 with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@-1 with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@5.0 with:schema] isValid]); // Simple floating point number
    XCTAssertTrue([[JSONSchemaValidator validate:@2.99792458e8 with:schema] isValid]); // Exponential notation also works
    XCTAssertFalse([[JSONSchemaValidator validate:@"42" with:schema] isValid]); // Numbers as strings are rejected
}

- (void)testNumberMultiplesValidation {
    NSDictionary * schema = @{@"type": @"number",
                              @"multipleOf": @10};
    
    XCTAssertTrue([[JSONSchemaValidator validate:@0 with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@10 with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@20 with:schema] isValid]);
    XCTAssertFalse([[JSONSchemaValidator validate:@23 with:schema] isValid]); // Not a multiple of 10:
}

- (void)testNumberRangeValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"number\"}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"number",
                              @"minimum": @0,
                              @"maximum": @100,
                              @"exclusiveMaximum": @YES};
    
    XCTAssertTrue([[JSONSchemaValidator validate:@-1 with:schema] isValid]); // Less than minimum:
    
}

@end
