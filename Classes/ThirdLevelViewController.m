//
//  ThirdLevelViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/22/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "ThirdLevelViewController.h"
#import "AffordItAppDelegate.h"

@implementation ThirdLevelViewController

@synthesize key;
@synthesize documentsPath;
@synthesize all;
@synthesize buttonLabel;
@synthesize addAndDeleteButton;
@synthesize price;
@synthesize priceField;
@synthesize name;
@synthesize nameField;

//these methods are for overwritten by each individual
- (IBAction) textFieldDoneEditing: (id) sender
{
	[nameField resignFirstResponder];
}
- (IBAction) backgroundClicked: (id) sender
{
}

- (void) viewWillAppear: (BOOL)animated
{
	key = name;
	
	nameField.enabled = YES;
	nameField.alpha = 1.0;
	priceField.enabled = YES;
	priceField.alpha = 1.0;
	
	[addAndDeleteButton setTitle:buttonLabel forState:UIControlStateNormal];
	nameField.text = name;
	priceField.text = price;
	addAndDeleteButton.enabled = YES;
	addAndDeleteButton.alpha = 1.0;
	
	[super viewWillAppear:animated];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[addAndDeleteButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[addAndDeleteButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
	[key release];
	[documentsPath release];
	[all release];
	[buttonLabel release];
	[addAndDeleteButton release];
	[name release];
	[nameField release];
	[price release];
	[priceField release];
    [super dealloc];
}

@end
