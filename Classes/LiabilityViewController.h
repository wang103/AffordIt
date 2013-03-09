//
//  LiabilityViewController.h
//  AffordIt
//
//  Created by Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class LiabilityDetailController;

@interface LiabilityViewController: SecondLevelViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableDictionary *allLiability;
	
	IBOutlet UILabel *totalLiability;
	
	LiabilityDetailController *childController;
}

@property (nonatomic, retain) NSMutableDictionary *allLiability;
@property (nonatomic, retain) UILabel *totalLiability;

@end
