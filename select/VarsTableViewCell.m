//
//  VarsTableViewCell.m
//  Select
//
//  Created by Бобер on 06.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import "VarsTableViewCell.h"
#import "ScanBarcodeViewController.h"
#import "VariablesController.h"

@implementation VarsTableViewCell {
    VariablesController *vc;
}

@synthesize varName;
@synthesize varValue;

- (void)awakeFromNib {
    // Initialization code
    self.varValue.delegate = self;
    vc = [VariablesController sharedVariablesController];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [vc setVariable:self.varName.text varValue:self.varValue.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanBarcode"]) {
        ScanBarcodeViewController *destViewController = segue.destinationViewController;
        destViewController.varName = varName.text;
    }
}

@end
