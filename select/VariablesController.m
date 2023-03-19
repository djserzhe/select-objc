//
//  VariablesController.m
//  Select
//
//  Created by Бобер on 04.07.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import "VariablesController.h"
#import "Query.h"

@implementation VariablesController

@synthesize vars;
@synthesize varsKeys;
@synthesize changedVars;

+ (id)sharedVariablesController {
    static VariablesController *sharedVariablesController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedVariablesController = [[self alloc] init];
    });
    return sharedVariablesController;
}

- (id)init {
    if (self = [super init]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"variables"];
        NSMutableDictionary *variables = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (variables == nil)
            self.vars = [[NSMutableDictionary alloc] init];
        else
            self.vars = variables;
  
        self.varsKeys = [[self.vars allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        changedVars = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)updateVariablesList {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"queries"];
    NSMutableArray *queries = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (queries == nil)
        queries = [[NSMutableArray alloc] init];
    
    NSMutableArray* varsInQueries = [[NSMutableArray alloc] init];
    
    for (Query* curQuery in queries) {
        [self addVarsFromQueryToArray:curQuery.sqlShortQuery arr:varsInQueries];
        [self addVarsFromQueryToArray:curQuery.sqlFullQuery arr:varsInQueries];
    }
    
    for (NSString* column in [self.vars allKeys]) {
        if (![varsInQueries containsObject:column]) {
            [self.vars removeObjectForKey:column];
        }
    }
    
    for (NSString* curVar in varsInQueries) {
        if (![self.vars objectForKey:curVar]) {
            [self.vars setObject:@"" forKey:curVar];
        }
    }
    self.varsKeys = [[self.vars allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)addVarsFromQueryToArray:(NSString*)queryText
                            arr:(NSMutableArray*)arr {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\$\\S+" options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:queryText options:0 range:NSMakeRange(0, queryText.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = match.range;
        NSString *var = [queryText substringWithRange:matchRange];
        [arr addObject:var];
    }
}

-(NSString*)replaceVariablesInQuery:(NSString*)queryText {
    NSString *newQueryText = queryText;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\$\\S+" options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:queryText options:0 range:NSMakeRange(0, queryText.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = match.range;
        NSString *var = [queryText substringWithRange:matchRange];
        NSString *varValue = vars[var];
        if (!varValue)
            varValue = @"''";
        else
            varValue = [NSString stringWithFormat:@"'%@'", varValue];
        newQueryText = [newQueryText stringByReplacingOccurrencesOfString:var withString:varValue];
    }
    return newQueryText;
}

-(void)saveVariables {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vars];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"variables"];
}

-(void)setVariable:(NSString*)varName
          varValue:(NSString*)varValue {
    [vars setObject:varValue forKey:varName];
    [changedVars addObject:varName];
}

-(BOOL)isQueryContainsChangedVars:(NSString*)queryText {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\$\\S+" options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:queryText options:0 range:NSMakeRange(0, queryText.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = match.range;
        NSString *var = [queryText substringWithRange:matchRange];
        if ([changedVars containsObject:var])
            return YES;
    }
    return NO;
}

@end
