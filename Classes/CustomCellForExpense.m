//
//  CustomCellForExpense.m
//  AffordIt
//
//  Created by Tianyi Wang, Simon Zhao on 7/20/09.
//  Copyright 2009 UIUC. All rights reserved.
//

#import "CustomCellForExpense.h"

@implementation CustomCellForExpense

@synthesize name;
@synthesize price;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc 
{
	[name release];
	[price release];
    [super dealloc];
}

@end
