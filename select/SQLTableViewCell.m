//
//  SQLTableViewCell.m
//  select
//
//  Created by Бобер on 16.02.16.
//  Copyright (c) 2016 Serzhe Development. All rights reserved.
//

#import "SQLTableViewCell.h"

@implementation SQLTableViewCell

@synthesize c1r1;
@synthesize c2r1;
@synthesize c1r2;
@synthesize c2r2;
@synthesize c1r3;
@synthesize c2r3;
@synthesize c1r4;
@synthesize c2r4;
@synthesize c1r5;
@synthesize c2r5;
@synthesize c1r6;
@synthesize c2r6;
@synthesize c1r7;
@synthesize c2r7;
@synthesize c1r8;
@synthesize c2r8;
@synthesize c1r9;
@synthesize c2r9;
@synthesize c1r10;
@synthesize c2r10;
@synthesize spinner;
@synthesize error;

- (void)awakeFromNib {
    [error setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
