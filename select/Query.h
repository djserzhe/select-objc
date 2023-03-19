//
//  Query.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "SQLClient.h"

@interface Query : NSObject

-(void) setSqlShortQuery: (NSString*) val;

-(NSString*) sqlShortQuery;

-(void) setSqlFullQuery: (NSString*) val;

-(NSString*) sqlFullQuery;

-(void) setFirstRecord: (NSMutableDictionary*) val;

-(NSArray*) firstRecord;

-(void) setName: (NSString*) val;

-(NSString*) name;

-(void) setError: (NSString*) val;

-(NSString*) error;

-(void) setConnection: (Connection*) val;

-(Connection*) connection;

-(void) setClient: (SQLClient*) val;

-(SQLClient*) client;

@end