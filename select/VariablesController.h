//
//  VariablesController.h
//  Select
//
//  Created by Бобер on 04.07.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariablesController : NSObject {
    NSMutableDictionary* vars;
    NSArray* varsKeys;
    NSMutableArray* changedVars;
}

@property NSMutableDictionary* vars;
@property NSArray* varsKeys;
@property NSMutableArray* changedVars;

+(id)sharedVariablesController;
-(void)updateVariablesList;
-(NSString*)replaceVariablesInQuery:(NSString*)queryText;
-(void)saveVariables;
-(BOOL)isQueryContainsChangedVars:(NSString*)queryText;
-(void)setVariable:(NSString*)varName
          varValue:(NSString*)varValue;

@end
