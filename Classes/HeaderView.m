//
//  HeaderView.m
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

@synthesize currrentInterfaceOrientation,wallTitleText;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
}

-(void) setWallTitleText:(NSString *)wallTitle {
	wallTitleText = wallTitle;
	
	
	UIImageView* userImageView = [[UIImageView alloc] init];
	userImageView.image = [UIImage imageNamed:@"missing-people.png"];
	[userImageView setFrame:CGRectMake(10, 1, 50, 48)];
	[self addSubview:userImageView];
	[userImageView release];
	
	wallNameLabel = [[UILabel alloc] init];
	[wallNameLabel setText:wallTitle];
	wallNameLabel.font =[UIFont fontWithName:@"Helvetica" size:30];
	[wallNameLabel setTextColor:RGBCOLOR(166,166,166)];
	wallNameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[wallNameLabel sizeToFit];
	[wallNameLabel setFrame:CGRectMake(userImageView.frame.origin.x + userImageView.frame.size.width + 10, 5, self.frame.size.width - (userImageView.frame.origin.x + userImageView.frame.size.width + 20), wallNameLabel.frame.size.height)];
	[self addSubview:wallNameLabel];
	
}

-(void) dealloc {
	[wallNameLabel release];
	[wallTitleText release];
	[super dealloc];
}

@end
