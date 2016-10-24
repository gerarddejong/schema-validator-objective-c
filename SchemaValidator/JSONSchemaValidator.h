//
//  JSONSchemaValidator.h
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import "SchemaValidator.h"

@interface JSONSchemaValidator : NSObject <SchemaValidator>

+ (SchemaValidationResult *) validate:(NSObject *)object with:(NSDictionary *)schema;

@end
