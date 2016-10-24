//
//  SchemaRenderable.h
//  SchemaValidator
//
//  Created by Gerard de Jong on 2016/09/30.
//  Copyright © 2016 Gerard de Jong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SchemaValidator <NSObject>

@required

@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString * title;

@optional

@property (strong, nonatomic) NSString * description;
@property (strong, nonatomic) NSObject * defaultValue;
@property (strong, nonatomic) NSObject * enumeration;

@end

