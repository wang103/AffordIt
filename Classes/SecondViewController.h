//
//  SecondViewController.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> 
{
	NSArray *controllers;
}

@property (nonatomic, retain) NSArray *controllers;

@end