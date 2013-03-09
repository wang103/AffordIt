//
//  CreditDetailController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdLevelViewController.h"

@interface CreditDetailController: ThirdLevelViewController <UIActionSheetDelegate>
{
}

- (IBAction) deleteCredit: (id) sender;

@end
