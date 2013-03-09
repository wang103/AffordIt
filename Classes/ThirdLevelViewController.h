//
//  ThirdLevelViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/22/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdLevelViewController : UIViewController 
{
	NSString *name;
	IBOutlet UITextField *nameField;
	NSString *price;
	IBOutlet UITextField *priceField;
	
	NSString *buttonLabel;
	IBOutlet UIButton *addAndDeleteButton;
	
	NSMutableDictionary *all;
	
	NSString *documentsPath;
	
	NSString *key;
}

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *documentsPath;
@property (nonatomic, retain) NSMutableDictionary *all;
@property (nonatomic, retain) NSString *buttonLabel;
@property (nonatomic, retain) UIButton *addAndDeleteButton;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) UITextField *priceField;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UITextField *nameField;

- (IBAction) textFieldDoneEditing: (id) sender;
- (IBAction) backgroundClicked: (id) sender;

@end
