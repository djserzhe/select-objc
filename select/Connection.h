//
//  Connection.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection : NSObject

-(void) setServer: (NSString*) val;

-(NSString*) server;

-(void) setLogin: (NSString*) val;

-(NSString*) login;

-(void) setPassword: (NSString*) val;

-(NSString*) password;

-(void) setDatabase: (NSString*) val;

-(NSString*) database;

@end
