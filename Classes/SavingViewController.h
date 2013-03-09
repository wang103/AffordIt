//
//  SavingViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class SavingDetailController;

@interface SavingViewController: SecondLevelViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableDictionary *allSaving;
	
	IBOutlet UILabel *totalSaving;
	
	SavingDetailController *childController;
}

@property (nonatomic, retain) NSMutableDictionary *allSaving;
@property (nonatomic, retain) UILabel *totalSaving;

@end
