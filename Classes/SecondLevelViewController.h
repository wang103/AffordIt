//
//  SecondLevelViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondLevelViewController : UIViewController 
{
	UIImage *rowImage;
	NSArray *allKeys;
	
	IBOutlet UITableView *table;
	IBOutlet UIButton *addButton;
	
	NSString *documentsPath;
}

@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSString *documentsPath;
@property (nonatomic, retain) NSArray *allKeys;
@property (nonatomic, retain) UIImage *rowImage;

- (IBAction) add: (id) sender;

@end
