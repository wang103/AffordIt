//
//  AffordItAppDelegate.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright UIUC 2009. All rights reserved.
//

#import "AffordItAppDelegate.h"

@implementation AffordItAppDelegate

@synthesize window;
@synthesize rootController;
@synthesize navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    // Override point for customization after application launch
	[navController.navigationBar setTintColor: [UIColor colorWithRed:(CGFloat)0.0 green:(CGFloat)0.7 blue:(CGFloat)0.0 alpha:1.0]];
	
	[window addSubview:rootController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc
{
	[navController release];
	[rootController release];
    [window release];
    [super dealloc];
}

@end
