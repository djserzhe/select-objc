//
//  ConnectionTableViewController.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "ConnectionTableViewController.h"
#import "ConnectionViewController.h"

@interface ConnectionTableViewController ()

@property NSMutableArray* connections;

@end

@implementation ConnectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInitialData];
}

- (void)loadInitialData {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"connections"];
    NSMutableArray *connections = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (connections == nil)
        self.connections = [[NSMutableArray alloc] init];
    else
        self.connections = connections;
    
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

    return [self.connections count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell"];
    if (cell == nil)
    {
        // or whatever cell initialisation method you have / created
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListPrototypeCell"];
    }
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    Connection *con = [self.connections objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\\%@", con.server, con.database];
    if ([con isEqual:self.curConnection]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.curConnection = [self.connections objectAtIndex:indexPath.row];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    return indexPath;
    
}

- (IBAction)unwindToConnectionList:(UIStoryboardSegue *)segue {
    
    ConnectionViewController *source = [segue sourceViewController];
    Connection *item = source.connection;
    if (item != nil) {
        if ([self.connections indexOfObject:item] == NSNotFound)
            [self.connections addObject:item];
        [self.tableView reloadData];
        [self saveCoonnections];
    }
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            [self performSegueWithIdentifier:@"showConnectionEdit" sender:indexPath];
                                        }];
    editButton.backgroundColor = [UIColor orangeColor];
    UITableViewRowAction *delButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Del" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                       {
                                           [self.connections removeObjectAtIndex:indexPath.row];
                                           [self.tableView reloadData];
                                           [self saveCoonnections];
                                       }];
    delButton.backgroundColor = [UIColor redColor];
    
    return @[delButton, editButton];
}

- (void)saveCoonnections {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.connections];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"connections"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showConnectionEdit"]) {
        ConnectionViewController *destViewController = segue.destinationViewController;
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = sender;
            destViewController.connection = self.connections[indexPath.row];
        }
    }
}

@end
