//
//  ExpenseViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "AffordItAppDelegate.h"
#import "ExpenseViewController.h"
#import "CustomCellForExpense.h"
#import "ExpenseDetailController.h"

#define kPlistnameWhole @"/ExpenseList.plist"
#define kPlistnamePart @"ExpenseList"
#define kNibName @"ExpenseDetailView"

@implementation ExpenseViewController

@synthesize allExpense;
@synthesize totalExpense;

- (IBAction) add: (id) sender
{
	if (childController == nil)
		childController = [[ExpenseDetailController alloc] 
						   initWithNibName:@"ExpenseDetailView" bundle:nil];
	childController.all = self.allExpense;
	
	childController.title = @"Add Expense";
	
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	if (childController == nil)
		childController = [[ExpenseDetailController alloc] 
						   initWithNibName:kNibName bundle:nil];
	childController.all = self.allExpense;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsPath = [paths objectAtIndex:0];
	documentsPath = [documentsPath stringByAppendingString:kPlistnameWhole];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:documentsPath] == NO)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:kPlistnamePart ofType:@"plist"];
		NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		self.allExpense = temp;
		[allExpense writeToFile:documentsPath atomically:YES];
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
	
	self.allExpense = tempDictionary;
	childController.all = self.allExpense;
	self.allKeys = [allExpense keysSortedByValueUsingSelector:@selector(compare:)];
	[self.table reloadData];
	
	[tempDictionary release];
	
	//calculate total
	long long total = 0;
	for(NSString *key in allKeys)
	{
		NSString *tempExpense = [allExpense objectForKey:key];
		tempExpense = [tempExpense substringFromIndex:1];
		long long income = [tempExpense longLongValue];
		total += income;
	}
	NSString *label = [[NSString alloc] initWithFormat:@"$%lli", total];
	totalExpense.text = label;
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
	[totalExpense release];
	[allExpense release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.allExpense count];
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
	cell.price.text = [allExpense objectForKey:cell.name.text];
	
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" 
													message:@"Please use the detail disclosure button on the right to edit this expense" 
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
		childController = [[ExpenseDetailController alloc] 
						   initWithNibName:@"ExpenseDetailView" bundle:nil];
	
	childController.title = [allKeys objectAtIndex:row];
	
	childController.buttonLabel = @"Delete";
	childController.name = [allKeys objectAtIndex:row];
	childController.price = [[allExpense objectForKey:[allKeys objectAtIndex:row]] substringFromIndex:1];
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController pushViewController:childController animated:YES];
}

- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 65;
}

@end
