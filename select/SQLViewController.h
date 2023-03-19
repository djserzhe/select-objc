//
//  SQLViewController.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Query.h"

@interface SQLViewController : UIViewController

@property Query* q;

- (IBAction)unwindToQuery:(UIStoryboardSegue *)segue;

@end