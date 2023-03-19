//
//  Query.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "Query.h"

@implementation Query {
    
    NSString* _sqlShortQuery;
    NSString* _sqlFullQuery;
    NSArray* _firstRecord;
    NSString* _name;
    NSString* _error;
    Connection* _connection;
    SQLClient* _sqlClient;
    
}

-(void) setSqlShortQuery: (NSString*) val {
    self->_sqlShortQuery = val;
}

-(NSString*) sqlShortQuery {
    return self->_sqlShortQuery;
}

-(void) setSqlFullQuery: (NSString*) val {
    self->_sqlFullQuery = val;
}

-(NSString*) sqlFullQuery {
    return self->_sqlFullQuery;
}

-(void) setFirstRecord: (NSArray*) val {
    self->_firstRecord = val;
}

-(NSArray*) firstRecord {
    return self->_firstRecord;
}

-(void) setName: (NSString*) val {
    self->_name = val;
}

-(NSString*) name {
    return self->_name;
}

-(void) setError: (NSString*) val {
    self->_error = val;
}

-(NSString*) error {
    return self->_error;
}

-(void) setConnection:(Connection *)val {
    self->_connection = val;
}

-(Connection*) connection {
    return self->_connection;
}

-(void) setClient:(SQLClient *)val {
    self->_sqlClient = val;
}

-(SQLClient*) client {
    return self->_sqlClient;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_sqlShortQuery forKey:@"sqlShortQuery"];
    [coder encodeObject:_sqlFullQuery forKey:@"sqlFullQuery"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_connection forKey:@"connection"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _sqlShortQuery = [coder decodeObjectForKey:@"sqlShortQuery"];
        _sqlFullQuery = [coder decodeObjectForKey:@"sqlFullQuery"];
        _name = [coder decodeObjectForKey:@"name"];
        _connection = [coder decodeObjectForKey:@"connection"];
    }
    return self;
}

@end
