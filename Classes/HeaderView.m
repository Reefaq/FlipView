/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  HeaderView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
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
