//
//  SavingViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/21/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "AffordItAppDelegate.h"
#import "SavingViewController.h"
#import "CustomCellForExpense.h"
#import "SavingDetailController.h"

#define kPlistnameWhole @"/SavingList.plist"
#define kPlistnamePart @"SavingList"
#define kNibName @"SavingDetailView"

@implementation SavingViewController

@synthesize allSaving;
@synthesize totalSaving;

- (IBAction) add: (id) sender
{
	if (childController == nil)
		childController = [[SavingDetailController alloc] 
						   initWithNibName:@"SavingDetailView" bundle:nil];
	childController.all = self.allSaving;
	
	childController.title = @"Add Saving Goal";
	
	childController.buttonLabel = @"Add";
	childController.name = @"New";
	childController.price = @"0";
	childController.month = @"1";
	
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	if (childController == nil)
		childController = [[SavingDetailController alloc] 
						   initWithNibName:kNibName bundle:nil];
	childController.all = self.allSaving;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsPath = [paths objectAtIndex:0];
	documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:documentsPath] == NO)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:kPlistnamePart ofType:@"plist"];
		NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		self.allSaving = temp;
		[allSaving writeToFile:documentsPath atomically:YES];
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
	
	self.allSaving = tempDictionary;
	childController.all = self.allSaving;
	self.allKeys = [allSaving allKeys];
	[self.table reloadData];
	
	[tempDictionary release];
	
	//calculate total
	double total = 0;
	for(NSString *key in allKeys)
	{
		NSArray *tempIncome = [allSaving objectForKey:key];
		NSString *price = [tempIncome objectAtIndex:0];
		price = [price substringFromIndex:1];
		double income = [price doubleValue];
		NSString *month = [tempIncome objectAtIndex:1];
		double monthNumber = [month doubleValue];
		
		income /= monthNumber;
		total += income;
	}
	NSString *label = [[NSString alloc] initWithFormat:@"$%.2f", total];
	totalSaving.text = label;
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
	[allSaving release];
	[totalSaving release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.allSaving count];
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
	NSString *monthLabel = [[allSaving objectForKey:cell.name.text] objectAtIndex:0];
	double money = [[monthLabel substringFromIndex:1] doubleValue];
	NSString *realMonthLabel = [[allSaving objectForKey:cell.name.text] objectAtIndex:1];
	double month = [realMonthLabel doubleValue];
	money /= month;
	
	NSString *final = [[NSString alloc] initWithFormat:@"$%.2f /mo", money];
	cell.price.text = final;
	[final release];
	
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" 
													message:@"Please use the detail disclosure button on the right to edit this saving goal" 
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
		childController = [[SavingDetailController alloc] 
						   initWithNibName:@"SavingDetailView" bundle:nil];
	
	childController.title = [allKeys objectAtIndex:row];
	
	childController.buttonLabel = @"Delete";
	childController.name = [allKeys objectAtIndex:row];
	childController.price = [[[allSaving objectForKey:[allKeys objectAtIndex:row]] objectAtIndex:0] substringFromIndex:1];
	NSString *monthLabel = [[allSaving objectForKey:[allKeys objectAtIndex:row]] objectAtIndex:1];
	childController.month = monthLabel;
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController pushViewController:childController animated:YES];
}

- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 65;
}

@end
