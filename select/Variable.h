//
//  Variable.h
//  Select
//
//  Created by Бобер on 06.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Variable : NSObject

-(void) setValue: (NSString*) val;

-(NSString*) value;

-(void) setName: (NSString*) val;

-(NSString*) name;

-(void) setFound: (bool) val;

-(bool) found;

@end
