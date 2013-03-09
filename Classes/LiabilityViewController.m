//
//  LiabilityViewController.m
//  AffordIt
//
//  Created by Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "AffordItAppDelegate.h"
#import "LiabilityViewController.h"
#import "CustomCellForExpense.h"
#import "LiabilityDetailController.h"

#define kPlistnameWhole @"/LiabilityList.plist"
#define kPlistnamePart @"LiabilityList"
#define kNibName @"LiabilityDetailView"

@implementation LiabilityViewController

@synthesize allLiability;
@synthesize totalLiability;

- (IBAction) add: (id) sender
{
	if (childController == nil)
		childController = [[LiabilityDetailController alloc] 
						   initWithNibName:@"LiabilityDetailView" bundle:nil];
	childController.all = self.allLiability;
	
	childController.title = @"Add Liability";
	
	childController.buttonLabel = @"Add";
	childController.name = @"New";
	childController.price = @"0";
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController pushViewController:childController animated:YES];
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

- (void)viewDidLoad 
{	
	if (childController == nil)
		childController = [[LiabilityDetailController alloc] 
						   initWithNibName:kNibName bundle:nil];
	childController.all = self.allLiability;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsPath = [paths objectAtIndex:0];
	documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:documentsPath] == NO)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:kPlistnamePart ofType:@"plist"];
		NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		self.allLiability = temp;
		[allLiability writeToFile:documentsPath atomically:YES];
		[temp release];
	}
	[super viewDidLoad];
}

- (void) viewWillAppear: (BOOL)animated
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsPath = [paths objectAtIndex:0];
	documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
	
	NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
	
	self.allLiability = tempDictionary;
	childController.all = self.allLiability;
	self.allKeys = [allLiability keysSortedByValueUsingSelector:@selector(compare:)];
	[self.table reloadData];
	
	[tempDictionary release];
	
	//calculate total
	long long total = 0;
	for(NSString *key in allKeys)
	{
		NSString *tempLiability = [allLiability objectForKey:key];
		tempLiability = [tempLiability substringFromIndex:1];
		long long income = [tempLiability longLongValue];
		total += income;
	}
	NSString *label = [[NSString alloc] initWithFormat:@"$%lli", total];
	totalLiability.text = label;
	[label release];

	[super viewWillAppear:animated];
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
	[allLiability release];
	[totalLiability release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.allLiability count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellTableIdentifier = @"CustomCellIdentifierForExpense";
	
	CustomCellForExpense *cell = (CustomCellForExpense *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
	
	if(cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellForExpense" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	
	NSUInteger row = [indexPath row];
	
	cell.name.text = [allKeys objectAtIndex:row];
	cell.price.text = [allLiability objectForKey:cell.name.text];
	
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" 
													message:@"Please use the detail disclosure button on the right to edit this liability" 
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	
	if (childController == nil)
		childController = [[LiabilityDetailController alloc] 
						   initWithNibName:@"LiabilityDetailView" bundle:nil];
	
	childController.title = [allKeys objectAtIndex:row];
	
	childController.buttonLabel = @"Delete";
	childController.name = [allKeys objectAtIndex:row];
	childController.price = [[allLiability objectForKey:[allKeys objectAtIndex:row]] substringFromIndex:1];
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController pushViewController:childController animated:YES];
}

- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 65;
}

@end
