//
//  SQLTableViewController1.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLTableViewCell.h"
#import "SQLViewController.h"
#import "SQLClient.h"
#import "RowViewController.h"

@interface SQLTableViewController : UITableViewController <SQLClientDelegate>

@property NSArray* table;
@property SQLClient* client;
@property Query* query;

@end
