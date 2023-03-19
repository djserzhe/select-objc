//
//  MainTableViewController.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLClient.h"
#import "Query.h"
#import "SQLTableViewCell.h"
#import "SQLTableViewController.h"
#import "IntroViewController.h"
@import StoreKit;
#import "DejalActivityView.h"

@interface MainTableViewController : UITableViewController <SQLClientDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property NSMutableArray* queries;
- (IBAction)unwindToQueryList:(UIStoryboardSegue *)segue;

@end
