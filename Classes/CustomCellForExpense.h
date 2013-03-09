//
//  CustomCellForExpense.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

/*
 This custom cell is for expense and liability view
 */

#import <UIKit/UIKit.h>

@interface CustomCellForExpense : UITableViewCell
{
	IBOutlet UILabel *name;
	IBOutlet UILabel *price;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *price;

@end
