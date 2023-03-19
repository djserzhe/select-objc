//
//  ConnectionViewController.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "ConnectionViewController.h"

@interface ConnectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *server;
@property (weak, nonatomic) IBOutlet UITextField *database;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation ConnectionViewController {
    UITextField* activeField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.opaque = NO;

    if (self.connection != nil) {
        self.server.text = self.connection.server;
        self.database.text = self.connection.database;
        self.login.text = self.connection.login;
        self.password.text = self.connection.password;
    }
    else
        self.connection = [[Connection alloc] init];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) {
        self.connection = nil;
        return;
    }
    
    self.connection.server = self.server.text;
    self.connection.database = self.database.text;
    self.connection.login = self.login.text;
    self.connection.password = self.password.text;
    
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
