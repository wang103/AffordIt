//
//  FourthViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UIViewController <UIActionSheetDelegate>
{
	IBOutlet UIButton *resetButton;
}

@property (nonatomic, retain) UIButton *resetButton;

- (IBAction) reset: (id) sender;

@end