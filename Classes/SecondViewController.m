//
//  SecondViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondLevelViewController.h"
#import "AffordItAppDelegate.h"

#import "IncomeViewController.h"
#import "LiabilityViewController.h"
#import "ExpenseViewController.h"
#import "SavingViewController.h"
#import "CreditViewController.h"

@implementation SecondViewController

@synthesize controllers;

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
	self.title = @"Assessment";
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	//income
	IncomeViewController *incomeViewController = [[IncomeViewController alloc] initWithNibName:@"IncomeView" bundle:nil];
	incomeViewController.title = @"Monthly Incomes";
	incomeViewController.rowImage = [UIImage imageNamed:@"Income.png"];
	[array addObject:incomeViewController];
	[incomeViewController release];
	
	//liability
	LiabilityViewController *liabilityViewController = [[LiabilityViewController alloc] initWithNibName:@"LiabilityView" bundle:nil];
	liabilityViewController.title = @"Liability/Month";
	liabilityViewController.rowImage = [UIImage imageNamed:@"Liability.png"];;
	[array addObject:liabilityViewController];
	[liabilityViewController release];
	
	//expense
	ExpenseViewController *expenseViewController = [[ExpenseViewController alloc] initWithNibName:@"ExpenseView" bundle:nil];
	expenseViewController.title = @"Monthly Expense";
	expenseViewController.rowImage = [UIImage imageNamed:@"Expense.png"];;
	[array addObject:expenseViewController];
	[expenseViewController release];
	
	//saving
	SavingViewController *savingViewController = [[SavingViewController alloc] initWithNibName:@"SavingView" bundle:nil];
	savingViewController.title = @"Saving Goals";
	savingViewController.rowImage = [UIImage imageNamed:@"Saving.png"];;
	[array addObject:savingViewController];
	[savingViewController release];
	
	//credit
	CreditViewController *creditViewController = [[CreditViewController alloc] initWithNibName:@"CreditView" bundle:nil];
	creditViewController.title = @"Credit Cards Debts";
	creditViewController.rowImage = [UIImage imageNamed:@"Creditcard.png"];;
	[array addObject:creditViewController];
	[creditViewController release];
	
	self.controllers = array;
	[array release];
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
	[controllers release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.controllers count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
	if(cell == nil)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:RootViewControllerCell] autorelease];
	
	//config cell
	NSUInteger row = [indexPath row];
	SecondLevelViewController *controller = [controllers objectAtIndex:row];
	
#if SDK_VERSION_3
	[cell.textLabel setText: controller.title];
	[cell.imageView setImage: controller.rowImage];
#else
	cell.text = controller.title;
	cell.image = controller.rowImage;
#endif

	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
	
	AffordItAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController pushViewController:nextController animated:YES];
}

@end
