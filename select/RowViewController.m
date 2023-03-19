//
//  RowViewController.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "RowViewController.h"

@interface RowViewController ()

@property (weak, nonatomic) IBOutlet UILabel *col1;
@property (weak, nonatomic) IBOutlet UILabel *content1;
@property (weak, nonatomic) IBOutlet UILabel *col2;
@property (weak, nonatomic) IBOutlet UILabel *content2;
@property (weak, nonatomic) IBOutlet UILabel *col3;
@property (weak, nonatomic) IBOutlet UILabel *content3;
@property (weak, nonatomic) IBOutlet UILabel *col4;
@property (weak, nonatomic) IBOutlet UILabel *content4;
@property (weak, nonatomic) IBOutlet UILabel *col5;
@property (weak, nonatomic) IBOutlet UILabel *content5;
@property (weak, nonatomic) IBOutlet UILabel *col6;
@property (weak, nonatomic) IBOutlet UILabel *content6;
@property (weak, nonatomic) IBOutlet UILabel *col7;
@property (weak, nonatomic) IBOutlet UILabel *content7;
@property (weak, nonatomic) IBOutlet UILabel *col8;
@property (weak, nonatomic) IBOutlet UILabel *content8;
@property (weak, nonatomic) IBOutlet UILabel *col9;
@property (weak, nonatomic) IBOutlet UILabel *content9;
@property (weak, nonatomic) IBOutlet UILabel *col10;
@property (weak, nonatomic) IBOutlet UILabel *content10;

@end

@implementation RowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int i = 1;
    NSString* val;
    for (NSString* column in self.row) {
        val = @"null";
        if (self.row[column] != [NSNull null]) {
            val = self.row[column];
        }
        
        if (i == 1) {
            self.col1.text = column;
            self.content1.text = val;
        }
        else if (i == 2) {
            self.col2.text = column;
            self.content2.text = val;
        }
        else if (i == 3) {
            self.col3.text = column;
            self.content3.text = val;
        }
        else if (i == 4) {
            self.col4.text = column;
            self.content4.text = val;
        }
        else if (i == 5) {
            self.col5.text = column;
            self.content5.text = val;
        }
        else if (i == 6) {
            self.col6.text = column;
            self.content6.text = val;
        }
        else if (i == 7) {
            self.col7.text = column;
            self.content7.text = val;
        }
        else if (i == 8) {
            self.col8.text = column;
            self.content8.text = val;
        }
        else if (i == 9) {
            self.col9.text = column;
            self.content9.text = val;
        }
        else if (i == 10) {
            self.col10.text = column;
            self.content10.text = val;
        }
        else
            break;
        i++;
    }
    
    while (i <= 10) {
        if (i == 1) {
            [self.col1 setHidden:YES];
            [self.content1 setHidden:YES];
        }
        else if (i == 2) {
            [self.col2 setHidden:YES];
            [self.content2 setHidden:YES];
        }
        else if (i == 3) {
            [self.col3 setHidden:YES];
            [self.content3 setHidden:YES];
        }
        else if (i == 4) {
            [self.col4 setHidden:YES];
            [self.content4 setHidden:YES];
        }
        else if (i == 5) {
            [self.col5 setHidden:YES];
            [self.content5 setHidden:YES];
        }
        else if (i == 6) {
            [self.col6 setHidden:YES];
            [self.content6 setHidden:YES];
        }
        else if (i == 7) {
            [self.col7 setHidden:YES];
            [self.content7 setHidden:YES];
        }
        else if (i == 8) {
            [self.col8 setHidden:YES];
            [self.content8 setHidden:YES];
        }
        else if (i == 9) {
            [self.col9 setHidden:YES];
            [self.content9 setHidden:YES];
        }
        else if (i == 10) {
            [self.col10 setHidden:YES];
            [self.content10 setHidden:YES];
        }
        i++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
