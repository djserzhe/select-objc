//
//  ConnectionTableViewController.h
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"

@interface ConnectionTableViewController : UITableViewController 

@property Connection* curConnection;

- (IBAction)unwindToConnectionList:(UIStoryboardSegue *)segue;

@end
