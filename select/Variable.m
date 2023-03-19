//
//  Variable.m
//  Select
//
//  Created by Бобер on 06.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import "Variable.h"

@implementation Variable {
    NSString* _value;
    NSString* _name;
    bool _found;
}

-(void) setValue: (NSString*) val {
    self->_value = val;
}

-(NSString*) value {
    return self->_value;
}

-(void) setName: (NSString*) val {
    self->_name = val;
}

-(NSString*) name {
    return self->_name;
}

-(void) setFound: (bool) val {
    self->_found = val;
}

-(bool) found {
    return self->_found;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_value forKey:@"value"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _name = [coder decodeObjectForKey:@"name"];
        _value = [coder decodeObjectForKey:@"value"];
    }
    return self;
}

@end
