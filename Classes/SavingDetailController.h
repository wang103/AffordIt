//
//  SavingDetailController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdLevelViewController.h"

@interface SavingDetailController: ThirdLevelViewController <UIActionSheetDelegate>
{
	NSString *month;
	IBOutlet UITextField *monthField;
}

@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) UITextField *monthField;

- (IBAction) deleteSaving: (id) sender;

@end
