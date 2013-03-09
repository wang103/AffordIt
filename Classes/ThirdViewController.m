//
//  ThirdViewController.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

@synthesize affordButton;
@synthesize itemNameField;
@synthesize itemPriceField;
@synthesize suggestionView;

- (IBAction) submit: (id) sender
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	
	//get total monthly income
	NSString *filePath = [documentsPath stringByAppendingString:@"/IncomeList.plist"];
	
	NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	NSArray *tempKey = [tempDictionary allKeys];
	
	long long totalIncome = 0;
	
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES)
		for(NSString *key in tempKey)
		{
			NSString *tempIncome = [tempDictionary objectForKey:key];
			tempIncome = [tempIncome substringFromIndex:1];
			long long income = [tempIncome longLongValue];
			totalIncome += income;
		}
	
	[tempDictionary release];
	
	//get all the spending
	NSArray *minusFile = [[NSArray alloc] initWithObjects:@"/ExpenseList.plist", @"/LiabilityList.plist", nil];
	long long totalSpending = 0;
	for(NSString *file in minusFile)
	{
		NSString *filePath = [documentsPath stringByAppendingString:file];
		
		NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		NSArray *tempKey = [tempDictionary allKeys];
		
		if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES)
			for(NSString *key in tempKey)
			{
				NSString *tempIncome = [tempDictionary objectForKey:key];
				tempIncome = [tempIncome substringFromIndex:1];
				
				long long spending = [tempIncome longLongValue];
				
				totalSpending += spending;
			}
		
		[tempDictionary release];
	}
	[minusFile release];
	
	//get total montly saving
	filePath = [documentsPath stringByAppendingString:@"/SavingList.plist"];
	
	tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	tempKey = [tempDictionary allKeys];
	
	double totalSaving = 0.0;
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES)
		for(NSString *key in tempKey)
		{
			NSArray *tempSaving = [tempDictionary objectForKey:key];
			NSString *price = [tempSaving objectAtIndex:0];
			price = [price substringFromIndex:1];
			double income = [price doubleValue];
			NSString *month = [tempSaving objectAtIndex:1];
			double monthNumber = [month doubleValue];
			
			income /= monthNumber;
			totalSaving += income;
		}
	[tempDictionary release];
	
	long long spendableIncome = totalIncome - totalSaving - totalSpending;
	
	//get the C.C. debt
	filePath = [documentsPath stringByAppendingString:@"/CreditList.plist"];
	
	tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	tempKey = [tempDictionary allKeys];
	
	long long totalCredit = 0;
	
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES)
		for(NSString *key in tempKey)
		{
			NSString *tempCredit = [tempDictionary objectForKey:key];
			tempCredit = [tempCredit substringFromIndex:1];
			long long credit = [tempCredit longLongValue];
			totalCredit += credit;
		}
	
	[tempDictionary release];
	
	//display the decision
	//spendable income, total credit, item price
	NSString *itemN = itemNameField.text;
	NSString *itemP = itemPriceField.text;
	long long itemAmount = [itemP longLongValue];
	
	NSString *message;
	
	if(totalCredit == 0 && itemAmount <= spendableIncome)
		message = [[NSString alloc] initWithFormat: @"Yes, you can afford buying a %@. You don't have any credit card debt, and your monthly spendable income is $%lli, which is greater than the price of %@.", itemN, spendableIncome, itemN];
	else if(totalCredit == 0 && itemAmount > spendableIncome)
	{
		double monthOfSaving = (double)itemAmount / (double)spendableIncome;
		long long ns = (long long)monthOfSaving;
		if(ns < monthOfSaving)
			ns++;
		
		message = [[NSString alloc] initWithFormat: @"No, you cannot afford buying a %@. You don't have any credit card debt, but your monthly spendable income is $%lli, which is less than the price of %@. You can set this as a saving goal for %lli months.", itemN, spendableIncome, itemN, ns];
	}
	else
	{
		double monthlySpendable = (double)spendableIncome;
		double totalDebt = (double)totalCredit;
		double numberOfMonth = totalDebt/monthlySpendable;
		long long nm = (long long)numberOfMonth;
		if(nm < numberOfMonth)
			nm++;
		
		message = [[NSString alloc] initWithFormat: @"No, you cannot afford buying a %@. You have credit card debt of $%lli, and your monthly spendable income is $%lli. So you should to take up to %lli months to pay off the debt first.", itemN, totalCredit, spendableIncome, nm];
	}
	
	if(spendableIncome == 0)
	{
		[message release];
		message = [[NSString alloc] initWithFormat:@"No, you cannot afford buying a %@. Your monthly spendable income is $0.", itemN];
	}
	else if(spendableIncome < 0)
	{
		[message release];
		message = [[NSString alloc] initWithFormat:@"No, you cannot afford buying a %@. Your monthly income of $%lli is not sufficient to satisfy your current monthly liability, expenses and saving of $%lli", itemN, totalIncome, (long long)totalSaving+totalSpending];
	}
	
	if(itemAmount == 0)
	{
		[message release];
		message = [[NSString alloc] initWithFormat:@"Yes, if it's free, go get it!"];
	}
	
	suggestionView.text = message;
	[message release];
}

- (IBAction) backgroundClicked: (id) sender
{
	//cancel leading zero
	long long amount = [itemPriceField.text longLongValue];
	NSString *tempString = [[NSString alloc] initWithFormat:@"%lli", amount];
	itemPriceField.text = tempString;
	[tempString release];
	
	[itemNameField resignFirstResponder];
	[itemPriceField resignFirstResponder];
}
- (IBAction) textFieldDoneEditing: (id) sender
{
	[sender resignFirstResponder];
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
	[affordButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[affordButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
	
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
	[affordButton release];
	[itemNameField release];
	[itemPriceField release];
	[suggestionView release];
    [super dealloc];
}

@end
