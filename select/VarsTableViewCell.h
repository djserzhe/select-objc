//
//  VarsTableViewCell.h
//  Select
//
//  Created by Бобер on 06.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VarsTableViewCell : UITableViewCell <UITextFieldDelegate> {
    UILabel* varName;
    UITextField* varValue;
}

@property (nonatomic, retain) IBOutlet UILabel* varName;
@property (nonatomic, retain) IBOutlet UITextField* varValue;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@end
