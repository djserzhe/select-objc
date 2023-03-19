//
//  SQLViewController.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "SQLViewController.h"
#import "ConnectionTableViewController.h"

@interface SQLViewController ()

@property (weak, nonatomic) IBOutlet UITextField* queryName;
@property (weak, nonatomic) IBOutlet UITextView* shortQuery;
@property (weak, nonatomic) IBOutlet UITextView* fullQuery;
@property (weak, nonatomic) IBOutlet UIButton *connection;

@end

@implementation SQLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (self.q == nil) {
        self.q = [[Query alloc] init];
        self.navigationItem.title = @"New query";
    }
    else
        self.navigationItem.title = self.q.name;
    
    if (self.q.connection == nil) {
        self.q.connection = [[Connection alloc] init];
    }
    
    self.queryName.text = self.q.name;
    self.shortQuery.text = self.q.sqlShortQuery;
    self.fullQuery.text = self.q.sqlFullQuery;
    if (self.q.connection.server == nil)
        [self.connection setTitle:@"Press to choose..." forState:UIControlStateNormal];
    else
        [self.connection setTitle:[NSString stringWithFormat:@"%@\\%@", self.q.connection.server, self.q.connection.database] forState:UIControlStateNormal];
    [self registerForKeyboardNotifications];

}

- (IBAction)unwindToQuery:(UIStoryboardSegue *)segue {    
    ConnectionTableViewController *source = [segue sourceViewController];
    self.q.connection = source.curConnection;
    [self.connection setTitle:[NSString stringWithFormat:@"%@\\%@", self.q.connection.server, self.q.connection.database] forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showConnectionSet"]) {
        ConnectionTableViewController *destViewController = segue.destinationViewController;
        destViewController.curConnection = self.q.connection;
    }
    self.q.name = self.queryName.text;
    self.q.sqlShortQuery = self.shortQuery.text;
    self.q.sqlFullQuery = self.fullQuery.text;
}

- (void)registerForKeyboardNotifications
{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
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

@end
