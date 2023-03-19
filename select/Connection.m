//
//  Connection.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "Connection.h"

@implementation Connection {
    
    NSString* _server;
    NSString* _login;
    NSString* _password;
    NSString* _database;
    
}

-(void) setServer: (NSString*) val {
    self->_server = val;
}

-(NSString*) server {
    return self->_server;
}

-(void) setLogin: (NSString*) val {
    self->_login = val;
}

-(NSString*) login {
    return self->_login;
}

-(void) setPassword: (NSString*) val {
    self->_password = val;
}

-(NSString*) password {
    return self->_password;
}

-(void) setDatabase: (NSString*) val {
    self->_database = val;
}

-(NSString*) database {
    return self->_database;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_server forKey:@"server"];
    [coder encodeObject:_login forKey:@"login"];
    [coder encodeObject:_password forKey:@"password"];
    [coder encodeObject:_database forKey:@"database"];

}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _server = [coder decodeObjectForKey:@"server"];
        _login = [coder decodeObjectForKey:@"login"];
        _password = [coder decodeObjectForKey:@"password"];
        _database = [coder decodeObjectForKey:@"database"];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
//    if (other == self)
//        return YES;
//    if (![super isEqual:other])
//        return NO;
    
    return [[self server] isEqualToString:[other server]]
    && [[self login] isEqualToString:[other login]]
    //&& [[self password] isEqualToString:[other password]]
    && [[self database] isEqualToString:[other database]];
    
}

@end
