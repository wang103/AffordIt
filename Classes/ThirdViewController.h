//
//  ThirdViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
{
	IBOutlet UITextField *itemNameField;
	IBOutlet UITextField *itemPriceField;
	IBOutlet UITextView *suggestionView;
	
	IBOutlet UIButton *affordButton;
}

@property (nonatomic, retain) UIButton *affordButton;
@property (nonatomic, retain) UITextField *itemNameField;
@property (nonatomic, retain) UITextField *itemPriceField;
@property (nonatomic, retain) UITextView *suggestionView;

- (IBAction) submit: (id) sender;
- (IBAction) backgroundClicked: (id) sender;
- (IBAction) textFieldDoneEditing: (id) sender;

@end
