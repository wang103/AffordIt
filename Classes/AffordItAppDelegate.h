//
//  AffordItAppDelegate.h
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/19/09.
//  Copyright UIUC 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AffordItAppDelegate : NSObject <UIApplicationDelegate> 
{
	IBOutlet UINavigationController *navController;
    UIWindow *window;
	IBOutlet UITabBarController *rootController;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *rootController;

@end

