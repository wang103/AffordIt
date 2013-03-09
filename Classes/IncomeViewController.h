//
//  IncomeViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class IncomeDetailController;

@interface IncomeViewController: SecondLevelViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableDictionary *allIncome;
	
	IBOutlet UILabel *totalIncome;
	
	IncomeDetailController *childController;
}

@property (nonatomic, retain) NSMutableDictionary *allIncome;
@property (nonatomic, retain) UILabel *totalIncome;

@end
