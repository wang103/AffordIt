//
//  CreditViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class CreditDetailController;

@interface CreditViewController: SecondLevelViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableDictionary *allCredit;
	
	IBOutlet UILabel *totalCredit;
	
	CreditDetailController *childController;
}

@property (nonatomic, retain) NSMutableDictionary *allCredit;
@property (nonatomic, retain) UILabel *totalCredit;

@end
