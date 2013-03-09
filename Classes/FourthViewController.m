//
//  FourthViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "FourthViewController.h"
#import "AffordItAppDelegate.h"

@implementation FourthViewController

@synthesize resetButton;

- (IBAction) reset: (id) sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
								  initWithTitle: @"Are you sure to reset every thing, this will delete all your information"
								  delegate: self 
								  cancelButtonTitle:@"No!" 
								  destructiveButtonTitle:@"Yes!" 
								  otherButtonTitles:nil];
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[actionSheet showFromTabBar: [delegate.rootController tabBar]];
	
	[actionSheet release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(!(buttonIndex == [actionSheet cancelButtonIndex]))
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsPath = [paths objectAtIndex:0];
		NSArray *filesTemp = [[NSFileManager defaultManager] directoryContentsAtPath:documentsPath];
		
		for(NSString *file in filesTemp)
		{
			NSString *removeFile = [[documentsPath stringByAppendingString:@"/"] stringByAppendingString:file];
			[[NSFileManager defaultManager] removeItemAtPath:removeFile error:nil];
		}
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RESET SUCCESSFUL" 
														message:@"Please restart the app" 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
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
	[resetButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[resetButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
	
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
	[resetButton release];
	[super dealloc];
}

@end
