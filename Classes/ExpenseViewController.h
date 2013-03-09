//
//  ExpenseViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class ExpenseDetailController;

@interface ExpenseViewController: SecondLevelViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableDictionary *allExpense;
	
	IBOutlet UILabel *totalExpense;
	
	ExpenseDetailController *childController;
}

@property (nonatomic, retain) NSMutableDictionary *allExpense;
@property (nonatomic, retain) UILabel *totalExpense;

@end
