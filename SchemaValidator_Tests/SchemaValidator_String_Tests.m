//
//  SchemaValidator_Tests.m
//  SchemaValidator_Tests
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONSchemaValidator.h"

@interface SchemaValidator_String_Tests : XCTestCase

@end

@implementation SchemaValidator_String_Tests {
    id<SchemaValidator> validator;
}

-(void)setUp {
    validator = [[JSONSchemaValidator alloc] init];
}

//- (void)setUp {
//    
//}

- (void)testStringValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"string\"}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"string"};
    
    XCTAssertTrue([[validator validate:@"This is a string" with:schema] isValid]);
    XCTAssertTrue([[validator validate:@"Déjà vu" with:schema] isValid]); // Unicode characters
    XCTAssertTrue([[validator validate:@"42" with:schema] isValid]);
    XCTAssertFalse([[validator validate:@42 with:schema] isValid]);
}

- (void)testStringLengthValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"string\", \"minLength\": 2, \"maxLength\": 3}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"string",
                              @"minLength": @2,
                              @"maxLength": @3};
    
    XCTAssertFalse([[JSONSchemaValidator validate:@"A" with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@"AB" with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@"ABC" with:schema] isValid]);
    XCTAssertFalse([[JSONSchemaValidator validate:@"ABCD" with:schema] isValid]);
}

- (void)testStringRegularExpressionValidation {
    //NSDictionary * schema = [NSJSONSerialization JSONObjectWithData:[@"{\"type\": \"string\", \"pattern\": \"^(\\\\([0-9]{3}\\\\))?[0-9]{3}-[0-9]{4}$\"}" dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary * schema = @{@"type": @"string",
                              @"pattern": @"^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"};
    
    XCTAssertTrue([[JSONSchemaValidator validate:@"555-1212" with:schema] isValid]);
    XCTAssertTrue([[JSONSchemaValidator validate:@"(888)555-1212" with:schema] isValid]);
    XCTAssertFalse([[JSONSchemaValidator validate:@"(888)555-1212 ext. 532" with:schema] isValid]);
    XCTAssertFalse([[JSONSchemaValidator validate:@"(800)FLOWERS" with:schema] isValid]);
}

@end
