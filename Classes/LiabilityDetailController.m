//
//  LiabilityDetailController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "LiabilityDetailController.h"
#import "AffordItAppDelegate.h"

#define kPlistnameWhole @"/LiabilityList.plist"

@implementation LiabilityDetailController

- (IBAction) backgroundClicked: (id) sender
{
	[nameField resignFirstResponder];
	[priceField resignFirstResponder];
	
	//cancel leading zero
	long long amount = [priceField.text longLongValue];
	NSString *tempString = [[NSString alloc] initWithFormat:@"%lli", amount];
	priceField.text = tempString;
	[tempString release];
	
	//change the value in plist
	if([addAndDeleteButton.titleLabel.text isEqualToString: @"Delete"])
	{
		if([key isEqualToString:nameField.text] == NO)
			[all removeObjectForKey:key];
		[all setObject:[@"$" stringByAppendingString: priceField.text] forKey:nameField.text];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		documentsPath = [paths objectAtIndex:0];
		documentsPath = [documentsPath stringByAppendingString: kPlistnameWhole];
		[all writeToFile:documentsPath atomically:YES];
	}
}

- (IBAction) deleteLiability: (id) sender
{
	NSString *itemName = [[NSString alloc] initWithString: nameField.text];
	NSString *itemAmount = [[NSString alloc] initWithString: priceField.text];
	
	if([addAndDeleteButton.titleLabel.text isEqualToString: @"Add"])
	{
		if([all objectForKey:itemName] == nil)
		{
			[all setObject:[@"$" stringByAppendingString:itemAmount] forKey:itemName];
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			documentsPath = [paths objectAtIndex:0];
			documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
			[all writeToFile:documentsPath atomically:YES];
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DONE" 
															message:@"You have successfully added a new item" 
														   delegate:nil 
												  cancelButtonTitle:@"OK" 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" 
															message:@"Names duplicated, please enter another name" 
														   delegate:nil 
												  cancelButtonTitle:@"OK" 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
	else
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] 
									  initWithTitle: [[@"Are you sure to delete item \"" stringByAppendingString:itemName] stringByAppendingString:@"\"?"]
									  delegate: self 
									  cancelButtonTitle:@"No!" 
									  destructiveButtonTitle:@"Yes!" 
									  otherButtonTitles:nil];
		
		AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[actionSheet showFromTabBar: [delegate.rootController tabBar]];
		
		[actionSheet release];
	}
	
	[itemName release];
	[itemAmount release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(!(buttonIndex == [actionSheet cancelButtonIndex]))
	{
		NSString *itemName = [[NSString alloc] initWithString: nameField.text];
		//NSString *itemAmount = [[NSString alloc] initWithString: priceField.text];
		
		[all removeObjectForKey:itemName];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		documentsPath = [paths objectAtIndex:0];
		documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
		
		[all writeToFile:documentsPath atomically:YES];
		
		nameField.enabled = NO;
		nameField.alpha = 0.0;
		priceField.enabled = NO;
		priceField.alpha = 0.0;
		addAndDeleteButton.enabled = NO;
		addAndDeleteButton.alpha = 0.0;
		
		[itemName release];
	}
}

- (void) viewWillAppear: (BOOL)animated
{
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}

@end
