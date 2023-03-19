//
//  MainTableViewController.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "MainTableViewController.h"
#import "SQLTableViewCell.h"
#import "VariablesController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController {
    
    SQLClient *client;
    NSString *lastServerMessage;
    __weak IBOutlet UIBarButtonItem *addButton;
    SKProductsRequest *inAppPurRequest;
    SKProduct *inAppProduct;
    UIView *overlayView;
    BOOL transactionInProgress;
    VariablesController *vc;
}

#pragma mark - Table view standart

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![self checkStoredBoolProperty:@"helpWasShown"]) {
        [self showHelp:nil];        
    }
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"queries"];
    NSMutableArray *queries = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (queries == nil)
        self.queries = [[NSMutableArray alloc] init];
    else
        self.queries = queries;
    
    client = [SQLClient sharedInstance];
    vc = [VariablesController sharedVariablesController];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(loadData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self loadData];
    CGRect headerFrame = self.tableView.tableHeaderView.frame;
    headerFrame.size.height = 40;
    self.tableView.tableHeaderView.frame = headerFrame;
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:140 green:181 blue:195 alpha:1];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(EditTable:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = overlayView.center;
    [overlayView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [self setStoreBoolProperty:@"fullVersion"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.queries.count == 0) {
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 288, 21)];
        messageLabel.text = @"Press + to add a new element";
        
        self.tableView.backgroundView = messageLabel;
    }
    else {
        self.tableView.backgroundView = nil;
    }
    return self.queries.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    //поиск ячейки
    SQLTableViewCell *cell = (SQLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell.error setHidden:YES];
    int i = 1;
    Query *q = self.queries[indexPath.section];
    NSDictionary *row;
    
    if (q.error != nil) {
        [cell.error setHidden:NO];
        cell.error.text = q.error;
    }
    else if ((q.firstRecord.count == 0) && (client.workerQueue.operationCount == 0)) {
        [cell.error setHidden:NO];
        q.error = @"No data";
        cell.error.text = q.error;
    }
    else if (q.firstRecord.count > 0) {
        NSString* val;
        row = q.firstRecord[0];
        for (NSString* column in row) {
            val = @"null";
            if (row[column] != [NSNull null]) {
                val = row[column];
            }
            
            if (i == 1) {
                cell.c1r1.text = column;
                cell.c2r1.text = val;
                [cell.c1r1 setHidden:NO];
                [cell.c2r1 setHidden:NO];
            }
            else if (i == 2) {
                cell.c1r2.text = column;
                cell.c2r2.text = val;
                [cell.c1r2 setHidden:NO];
                [cell.c2r2 setHidden:NO];
            }
            else if (i == 3) {
                cell.c1r3.text = column;
                cell.c2r3.text = val;
                [cell.c1r3 setHidden:NO];
                [cell.c2r3 setHidden:NO];
            }
            else if (i == 4) {
                cell.c1r4.text = column;
                cell.c2r4.text = val;
                [cell.c1r4 setHidden:NO];
                [cell.c2r4 setHidden:NO];
            }
            else if (i == 5) {
                cell.c1r5.text = column;
                cell.c2r5.text = val;
                [cell.c1r5 setHidden:NO];
                [cell.c2r5 setHidden:NO];
            }
            else if (i == 6) {
                cell.c1r6.text = column;
                cell.c2r6.text = val;
                [cell.c1r6 setHidden:NO];
                [cell.c2r6 setHidden:NO];
            }
            else if (i == 7) {
                cell.c1r7.text = column;
                cell.c2r7.text = val;
                [cell.c1r7 setHidden:NO];
                [cell.c2r7 setHidden:NO];
            }
            else if (i == 8) {
                cell.c1r8.text = column;
                cell.c2r8.text = val;
                [cell.c1r8 setHidden:NO];
                [cell.c2r8 setHidden:NO];
            }
            else if (i == 9) {
                cell.c1r9.text = column;
                cell.c2r9.text = val;
                [cell.c1r9 setHidden:NO];
                [cell.c2r9 setHidden:NO];
            }
            else if (i == 10) {
                cell.c1r10.text = column;
                cell.c2r10.text = val;
                [cell.c1r10 setHidden:NO];
                [cell.c2r10 setHidden:NO];
            }
            else
                break;
            i++;
        }
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
    
    if ((row == nil) && (q.error == nil)) {
        [cell.spinner setFrame:CGRectMake(cell.bounds.size.width / 2 - 10, cell.bounds.size.height / 2 - 0, 10, 10)];
        [cell.spinner startAnimating];
    }
    else
        [cell.spinner stopAnimating];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Query *q = self.queries[indexPath.section];
    if (q.firstRecord.count == 0 || q.error != nil)
        return 3 * 22;
    else {
        NSDictionary *row = q.firstRecord[0];
        return MIN(row.count, 10) * 22;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Query* q = self.queries[section];
    if ([q.name isEqualToString:@""])
        return @"<no name>";
    else
        return q.name;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:204/255.0f green:224/255.0f blue:221/255.0f alpha:1.0f];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
    for (Query* curQuery in self.queries) {
        if ([vc isQueryContainsChangedVars:curQuery.sqlShortQuery])
            [self executeQuery:curQuery];
    }
    [vc.changedVars removeAllObjects];
    [self.tableView reloadData];
}

//-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    overlayView.frame = [UIScreen mainScreen].bounds;
//}

#pragma mark - Show data

- (void)loadData {
    
    for (Query* curQuery in self.queries) {
        [self executeQuery:curQuery];
    }
    
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
    }
    
}

-(void)executeQuery:(Query*)curQuery {
    [curQuery setFirstRecord:nil];
    curQuery.error = nil;
    client.delegate = self;
    
    if (curQuery.connection.server == nil || curQuery.connection.login == nil || curQuery.connection.database == nil || curQuery.connection.password == nil) {
        curQuery.error = @"Check connection parameters";
        return;
    }
    
    if ([curQuery.sqlShortQuery isEqualToString:@""]) {
        curQuery.error = @"Short query is empty";
        return;
    }

    NSString *queryText = [vc replaceVariablesInQuery:curQuery.sqlShortQuery];
    
    [client execute:queryText curQueryID:[self.queries indexOfObject:curQuery] conParams:curQuery.connection completion:^(NSArray* results) {
        if (results != nil) {
            if (results.count >= 1)
            {
                [curQuery setFirstRecord:results[results.count - 1]];
                [self.tableView reloadData];
            }
            else if (curQuery.error == nil)
                curQuery.error = @"Error while getting data";
        }
        else if (curQuery.error == nil)
            curQuery.error = @"Error while getting data";
        
    }];
}

- (void)error:(NSString*)error code:(int)code severity:(int)severity queryID:(NSUInteger)queryID
{
    //NSLog(@"Error #%d: %@ (Severity %d)", code, error, severity);
    if (queryID == -1) {
        for (Query* curQuery in self.queries) {
            if (lastServerMessage != nil && [error rangeOfString:@"Check messages"].location != NSNotFound)
                curQuery.error = [NSString stringWithFormat:@"%@:\n%@", error, lastServerMessage];
            else
                curQuery.error = error;
        }
    }
    else {
        Query *q = self.queries[(int)queryID];
        if (lastServerMessage != nil && [error rangeOfString:@"Check messages"].location != NSNotFound)
            q.error = [NSString stringWithFormat:@"%@:\n%@", error, lastServerMessage];
        else
            q.error = error;
    }
    [self.tableView reloadData];

}

- (void)message:(NSString*)message
{
    //NSLog(@"Message: %@", message);
    lastServerMessage = message;
}

- (void)saveQueries {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.queries];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"queries"];
}

#pragma mark - Edit data

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.editing)
        [self performSegueWithIdentifier:@"showQueryEdit" sender:indexPath];
    else
        [self performSegueWithIdentifier:@"showQueryResult" sender:nil];
    
}

- (IBAction)addButtonPress:(id)sender {
    
    [self performSegueWithIdentifier:@"showQueryEdit" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showQueryResult"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SQLTableViewController *destViewController = segue.destinationViewController;
        Query *q = self.queries[indexPath.section];
        destViewController.client = client;
        destViewController.query = q;
    }
    else if ([segue.identifier isEqualToString:@"showQueryEdit"]) {
        SQLViewController *destViewController = segue.destinationViewController;
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = sender;
            destViewController.q = self.queries[indexPath.section];
        }
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"showQueryEdit"])
    {
        if (![sender isKindOfClass:[NSIndexPath class]] && self.queries.count > 0) {
            if (![self checkStoredBoolProperty:@"fullVersion"]) {
                if (transactionInProgress)
                    [self messageBox:@"Transaction in progress" message:@"You are already purchasing full version. Wait for the answer from the server."];
                else
                    [self validateProductIdentifiers];
                return NO;
            }
            else
                return YES;
        }
    }
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *reloadButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Reload" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            [self executeQuery:self.queries[indexPath.section]];
                                            [self.tableView reloadData];
                                        }];
    reloadButton.backgroundColor = [UIColor grayColor];
    
    UITableViewRowAction *editButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        [self performSegueWithIdentifier:@"showQueryEdit" sender:indexPath];
                                    }];
    editButton.backgroundColor = [UIColor orangeColor];
    //editButton.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UITableViewRowAction *delButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Del" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         [self.queries removeObjectAtIndex:indexPath.section];
                                         [self.tableView reloadData];
                                         [self saveQueries];
                                     }];
    delButton.backgroundColor = [UIColor redColor];
    
    return @[delButton, editButton, reloadButton];
    
}

- (IBAction)unwindToQueryList:(UIStoryboardSegue *)segue {
    SQLViewController *source = segue.sourceViewController;
    NSUInteger position = [self.queries indexOfObject:source.q];
    if (position == NSNotFound) {
        [self.queries addObject:source.q];
        [self executeQuery:self.queries.lastObject];
    }
    else
        [self executeQuery:self.queries[position]];
    //[self.tableView reloadData];
    [self saveQueries];
}

- (IBAction)showHelp:(id)sender {
    IntroViewController *intro = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroViewController"];
    [self presentViewController:intro animated:YES completion:nil];
}

- (IBAction)EditTable:(id)sender {
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewCellEditingStyleDelete;
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.queries removeObjectAtIndex:indexPath.row];
        [self saveQueries];
        [self.tableView reloadData];
    }
}

// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    Query *q = [self.queries objectAtIndex:fromIndexPath.section];
    [self.queries removeObject:q];
    [self.queries insertObject:q atIndex:toIndexPath.section];
    [self saveQueries];
    [self.tableView reloadData];
}

#pragma mark In-App Purchases

- (void)validateProductIdentifiers {
    
    if ([SKPaymentQueue canMakePayments]) {
        NSSet *products = [NSSet setWithObject:@"serzhe.select.multiple_queries"];
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:products];
        
        // Keep a strong reference to the request.
        inAppPurRequest = productsRequest;
        productsRequest.delegate = self;
        [productsRequest start];
        //[self.navigationController.view addSubview:overlayView];
        [DejalActivityView activityViewForView:self.view withLabel:@"Processing..."];
    }
    else {
        [self messageBox:@"Error" message:@"Cannot perform In-App Purchases"];
    }
}

- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    //[overlayView removeFromSuperview];
    [DejalActivityView removeView];
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        [self messageBox:@"Invalid identifier" message:invalidIdentifier];
    }
    
    if (response.products.count >= 1)
    {
        inAppProduct = response.products[0];
        [self showPurchaseDialog];
        
    }
}

-(void)showPurchaseDialog {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Full version"
                                                                   message:@"For adding more than one element you need to purchase the full version for 1.99 USD"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* buyAction = [UIAlertAction actionWithTitle:@"Buy" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:inAppProduct];
                                                              payment.quantity = 1;
                                                              [[SKPaymentQueue defaultQueue] addPayment:payment];
                                                              transactionInProgress = TRUE;
                                                              //[self.navigationController.view addSubview:overlayView];
                                                              [DejalActivityView activityViewForView:self.view withLabel:@"Processing..."];
                                                          }];
    
    UIAlertAction* restoreAction = [UIAlertAction actionWithTitle:@"Restore" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          [[SKPaymentQueue defaultQueue]   restoreCompletedTransactions];
                                                          //[self.navigationController.view addSubview:overlayView];
                                                          [DejalActivityView activityViewForView:self.view withLabel:@"Processing..."];
                                                      }];
    
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * action) {}];
    
    [alert addAction:buyAction];
    [alert addAction:restoreAction];
    [alert addAction:cancelAction];
    alert.popoverPresentationController.barButtonItem = addButton;
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)messageBox:(NSString *)title
          message:(NSString *)message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
//            case SKPaymentTransactionStatePurchasing:
//                [self showTransactionAsInProgress:transaction deferred:NO];
//                break;
//            case SKPaymentTransactionStateDeferred:
//                [self showTransactionAsInProgress:transaction deferred:YES];
//                break;
            case SKPaymentTransactionStateFailed:
                //[overlayView removeFromSuperview];
                [DejalActivityView removeView];
                [self messageBox:@"Error" message:@"Transaction failed"];
                transactionInProgress = FALSE;
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                //[overlayView removeFromSuperview];
                [DejalActivityView removeView];
                [self messageBox:@"Succes" message:@"Transaction completed. You can now add more then one element"];
                transactionInProgress = TRUE;
                [self setStoreBoolProperty:@"fullVersion"];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                //[overlayView removeFromSuperview];
                [DejalActivityView removeView];
                [self messageBox:@"Succes" message:@"You purchase restored. You can now add more then one element"];
                transactionInProgress = TRUE;
                [self setStoreBoolProperty:@"fullVersion"];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}

-(BOOL)checkStoredBoolProperty:(NSString *)propertyName {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:propertyName];
    NSString *properyValue = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (properyValue == nil)
        return FALSE;
    else
        return TRUE;
}

-(void)setStoreBoolProperty:(NSString *)propertyName {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@"YES"];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:propertyName];
}

@end
