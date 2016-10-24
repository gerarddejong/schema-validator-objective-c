//
//  SchemaValidator.h
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchemaValidationResult.h"

@protocol SchemaValidator <NSObject>

+ (SchemaValidationResult *) validate:(NSObject *)object with:(NSDictionary *)schema;

@end
