//
//  VarsTableViewController.m
//  Select
//
//  Created by Бобер on 06.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import "VarsTableViewController.h"
#import "ScanBarcodeViewController.h"
#import "VariablesController.h"

@interface VarsTableViewController ()

@end

@implementation VarsTableViewController {
    VariablesController *vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vc = [VariablesController sharedVariablesController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (vc.varsKeys.count == 0) {
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"Add variables like $Var1, $Var2 etc. in your queries and they will be listed here. After that you could edit their values.";
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        self.tableView.backgroundView = messageLabel;
    }
    else {
        self.tableView.backgroundView = nil;
    }
    return vc.varsKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VarPrototypeCell" forIndexPath:indexPath];
    
    NSString* column = [vc.varsKeys objectAtIndex:indexPath.row];
    cell.varName.text = column;
    NSString* value = [vc.vars objectForKey:column];
    cell.varValue.text = value;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanBarcode"]) {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        if (indexPath != nil)
        {
            ScanBarcodeViewController *destViewController = segue.destinationViewController;
            destViewController.varName = vc.varsKeys[indexPath.row];
        }
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect aRect = self.view.frame;
    CGRect tabBarRect = self.tabBarController.tabBar.frame;
    if (keyboardRect.origin.y >= aRect.size.height)
        aRect.size.height = keyboardRect.origin.y - aRect.origin.y;
    else
        aRect.size.height = keyboardRect.origin.y - aRect.origin.y + tabBarRect.size.height;
    self.view.frame = aRect;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.vars];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"variables"];
//}

- (void)viewWillAppear:(BOOL)animated {
    [vc updateVariablesList];
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

@end
