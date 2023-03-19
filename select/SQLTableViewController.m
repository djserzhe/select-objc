//
//  SQLTableViewController1.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "SQLTableViewController.h"
#import "VariablesController.h"

@interface SQLTableViewController ()

@end

@implementation SQLTableViewController {
    NSString *errorText;
    NSString *lastServerMessage;
    __weak IBOutlet UIActivityIndicatorView *spinner;
    VariablesController *vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerNib:[UINib nibWithNibName:@"SQLTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListPrototypeCell"];
    self.tableView.rowHeight = 72;
    self.tableView.autoresizesSubviews = YES;
    self.navigationItem.title = self.query.name;
    
    vc = [VariablesController sharedVariablesController];
    
    [self loadData];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(loadData)
                  forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    
    self.client.delegate = self;
    
    if (self.query.connection.server == nil || self.query.connection.login == nil || self.query.connection.database == nil || self.query.connection.password == nil) {
        errorText = @"Check connection parameters";
        [spinner setHidden:YES];
        return;
    }
    
    if ([self.query.sqlFullQuery isEqualToString:@""]) {
        errorText = @"Full query is empty";
        [spinner setHidden:YES];
        return;
    }
    
    errorText = nil;
    self.table = [[NSArray alloc] init];
    [self.tableView reloadData];
    
    NSString *queryText = [vc replaceVariablesInQuery:self.query.sqlFullQuery];
    
    [self.client execute:queryText curQueryID:-1 conParams:self.query.connection completion:^(NSArray* results) {
        
        if (results != nil)
        {
            if (results.count == 1)
            {
                self.table = results[0];
                [self.tableView reloadData];
            }
            else
                errorText = @"Error getting data";
        }
        else
            errorText = @"Error getting data";
        
        if (self.refreshControl) {
            [self.refreshControl endRefreshing];
        }
        
        [spinner stopAnimating];
        //[spinner setHidden:YES];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([self.table count] > 0) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        if (errorText == nil) {
            [spinner startAnimating];
            self.tableView.backgroundView = spinner;
        }
        else {
            UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            messageLabel.text = errorText;
            messageLabel.textColor = [UIColor redColor];
            messageLabel.numberOfLines = 0;
            [messageLabel sizeToFit];
            
            self.tableView.backgroundView = messageLabel;
        }
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.table count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    //поиск ячейки
    SQLTableViewCell *cell = (SQLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSDictionary *row = self.table[indexPath.row];
    [cell.error setHidden:YES];

    int i = 1;
    NSString* val;
    for (NSString* column in row) {
        val = @"null";
        if (row[column] != [NSNull null]) {
            val = row[column];
        }
        
        if (i == 1) {
            cell.c1r1.text = column;
            cell.c2r1.text = val;
        }
        else if (i == 2) {
            cell.c1r2.text = column;
            cell.c2r2.text = val;
        }
        else if (i == 3) {
            cell.c1r3.text = column;
            cell.c2r3.text = val;
        }
        else if (i == 4) {
            cell.c1r4.text = column;
            cell.c2r4.text = val;
        }
        else if (i == 5) {
            cell.c1r5.text = column;
            cell.c2r5.text = val;
        }
        else if (i == 6) {
            cell.c1r6.text = column;
            cell.c2r6.text = val;
        }
        else if (i == 7) {
            cell.c1r7.text = column;
            cell.c2r7.text = val;
        }
        else if (i == 8) {
            cell.c1r8.text = column;
            cell.c2r8.text = val;
        }
        else if (i == 9) {
            cell.c1r9.text = column;
            cell.c2r9.text = val;
        }
        else if (i == 10) {
            cell.c1r10.text = column;
            cell.c2r10.text = val;
        }
        else
            break;
        i++;
    }
    
    while (i <= 10) {
        if (i == 1) {
            [cell.c1r1 setHidden:YES];
            [cell.c2r1 setHidden:YES];
        }
        else if (i == 2) {
            [cell.c1r2 setHidden:YES];
            [cell.c2r2 setHidden:YES];
        }
        else if (i == 3) {
            [cell.c1r3 setHidden:YES];
            [cell.c2r3 setHidden:YES];
        }
        else if (i == 4) {
            [cell.c1r4 setHidden:YES];
            [cell.c2r4 setHidden:YES];
        }
        else if (i == 5) {
            [cell.c1r5 setHidden:YES];
            [cell.c2r5 setHidden:YES];
        }
        else if (i == 6) {
            [cell.c1r6 setHidden:YES];
            [cell.c2r6 setHidden:YES];
        }
        else if (i == 7) {
            [cell.c1r7 setHidden:YES];
            [cell.c2r7 setHidden:YES];
        }
        else if (i == 8) {
            [cell.c1r8 setHidden:YES];
            [cell.c2r8 setHidden:YES];
        }
        else if (i == 9) {
            [cell.c1r9 setHidden:YES];
            [cell.c2r9 setHidden:YES];
        }
        else if (i == 10) {
            [cell.c1r10 setHidden:YES];
            [cell.c2r10 setHidden:YES];
        }
        i++;
    }
    
    if (row == nil) {
        [cell.spinner startAnimating];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else {
        [cell.spinner stopAnimating];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *row = self.table[indexPath.row];
    return MIN(row.count, 10) * 22;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([vc isQueryContainsChangedVars:self.query.sqlFullQuery])
        [self loadData];
    [vc.changedVars removeAllObjects];
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//Required
- (void)error:(NSString*)error code:(int)code severity:(int)severity queryID:(NSUInteger)queryID
{
    [spinner stopAnimating];
    [spinner setHidden:YES];
    NSLog(@"Error #%d: %@ (Severity %d)", code, error, severity);
    if (lastServerMessage != nil && [error rangeOfString:@"Check messages"].location != NSNotFound)
        errorText = [NSString stringWithFormat:@"%@:\n%@", error, lastServerMessage];
    else
        errorText = error;
    [self.tableView reloadData];
}

//Optional
- (void)message:(NSString*)message
{
    NSLog(@"Message: %@", message);
    lastServerMessage = message;
}

- (void)viewDidDisappear:(BOOL)animated {
    //[client disconnect];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSDictionary *row = self.table[indexPath.row];
//    
//    SQLViewController* viewController = [[SQLViewController alloc] init];
//    viewController.row = row;
//    [self.navigationController pushViewController:viewController animated:YES];
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRow"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RowViewController *destViewController = segue.destinationViewController;
        NSDictionary *row = self.table[indexPath.row];
        destViewController.row = row;
    }
}

@end
