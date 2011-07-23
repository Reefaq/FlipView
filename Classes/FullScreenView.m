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
//  FullScreenView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//
#import "FullScreenView.h"
#import "MessageModel.h"

@implementation FullScreenView

@synthesize messageModel,viewToOverLap,fullScreenBG;

-(id)initWithModel:(MessageModel*)model {
	if (self = [super init]) {
		messageModel = model;
		
		[self setBackgroundColor:RGBCOLOR(243,243,243)];
		
		contentView = [[UIView alloc] init];
		[contentView setBackgroundColor:RGBCOLOR(243,243,243)];
		
		userImageView = [[UIImageView alloc] init];
		[userImageView setBackgroundColor:[UIColor clearColor]];
		[userImageView setFrame:CGRectMake(10, 10, 130, 130)];
		[userImageView setImage:[UIImage imageNamed:@"missing-people.png"]];
		[contentView addSubview:userImageView];
		
		userNameLabel = [[UILabel alloc] init];
		userNameLabel.font =[UIFont fontWithName:@"Helvetica" size:25];
		[userNameLabel setTextColor:RGBCOLOR(2,90,177)];
		[userNameLabel setBackgroundColor:[UIColor clearColor]];
		[userNameLabel setText:[NSString stringWithFormat:@"%@",messageModel.userName]];
		[userNameLabel setFrame:CGRectMake(userImageView.frame.origin.x + userImageView.frame.size.width + 10, 5, 0, 0)];
		[contentView addSubview:userNameLabel];
		
		timeStampLabel = [[UILabel alloc] init];
		[timeStampLabel setText:messageModel.createdAt];
		timeStampLabel.font =[UIFont fontWithName:@"Helvetica" size:12];
		[timeStampLabel setTextColor:RGBCOLOR(111,111,111)];
		[timeStampLabel setBackgroundColor:[UIColor clearColor]];
		[timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y, 0, 0)];
		timeStampLabel.alpha = 0;
		[contentView addSubview:timeStampLabel];
		
		scrollView = [[UIScrollView alloc] init];
		[scrollView setBackgroundColor:[UIColor clearColor]];
		[scrollView setFrame:CGRectMake(10, userImageView.frame.origin.y + userImageView.frame.size.height + 10, 0, 0)];
		[contentView addSubview:scrollView];
		
		messageLabel = [[UILabel alloc] init];
		messageLabel.numberOfLines = 0;	
		messageLabel.font = [UIFont fontWithName:@"Helvetica" size:22];		
		messageLabel.textColor =  RGBCOLOR(33,33,33);
		messageLabel.highlightedTextColor = RGBCOLOR(33,33,33);
		[messageLabel setBackgroundColor:[UIColor clearColor]];
		messageLabel.alpha = 0;	
		[scrollView addSubview:messageLabel];
		
		
		closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		UIImageView* closeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close-popup.png"]];
		[closeImage setFrame:CGRectMake(6, 6, 17, 17)];
		[closeButton addSubview:closeImage];
		[closeImage release];
		[closeButton addTarget:self action:@selector(closeFullScreenView:) forControlEvents:UIControlEventTouchUpInside];
		[closeButton sizeToFit];
		closeButton.alpha = 0;
		[contentView addSubview:closeButton];
		

		[self addSubview:contentView];

	}
	return self;
}

- (void)reAdjustLayout{
	
		[contentView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		CGSize contentViewArea = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
		
		//[userImageView setFrame:CGRectMake(10, 10, 130, 130)];
	
		[userNameLabel sizeToFit];
		[userNameLabel setFrame:CGRectMake(userImageView.frame.origin.x + userImageView.frame.size.width + 10, 5, (contentViewArea.width - (userImageView.frame.size.width + 10)) - 30, userNameLabel.frame.size.height)];

		[timeStampLabel sizeToFit];
		[timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];

		[closeButton setFrame:CGRectMake(contentViewArea.width - 30, 0, 30, 30)];
	
		[scrollView setFrame:CGRectMake(10, userImageView.frame.origin.y + userImageView.frame.size.height + 10, contentViewArea.width-20, contentViewArea.height - (userImageView.frame.origin.y + userImageView.frame.size.height + 10))];

		///////////////////////////////////////////////////////////////
		[messageLabel setText:messageModel.content];
		messageLabel.numberOfLines = 0;
		[messageLabel sizeToFit];
		[messageLabel setFrame:CGRectMake(0, 0, scrollView.frame.size.width,messageLabel.frame.size.height)];

		[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, messageLabel.frame.origin.y + messageLabel.frame.size.height)];
	
}


-(void)closeFullScreenView:(id)sender {
   viewToOverLap.alpha = 1;
   [self setBackgroundColor:[UIColor whiteColor]];
   [sender removeFromSuperview];
   [UIView beginAnimations:@"CLOSEFULLSCREEN" context:NULL];
   [UIView setAnimationDuration:0.30];
   [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:YES];
   [self setFrame:viewToOverLap.originalRect];
	fullScreenBG.alpha = 0;
   for (UIView* subview in [self subviews]) {
	   subview.alpha = 0;
   }	
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
   [UIView commitAnimations];
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
   if ([animationID isEqualToString:@"CLOSEFULLSCREEN"]) {
	   self.alpha = 0;
	   [self removeFromSuperview];
	   [[FlipViewAppDelegate instance] closeFullScreen];
   }
}

-(void)showFields {
	[self reAdjustLayout]; // i just need this dont know why ... but will look at this later and fix it 
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.20];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
	timeStampLabel.alpha = 1;
	closeButton.alpha = 1;
	messageLabel.alpha = 1;
	[UIView commitAnimations];
}


-(void) dealloc {
	[closeButton release];
	closeButton=nil;
	[userImageView release];
	userImageView=nil;
	[userNameLabel release];
	userNameLabel=nil;
	[timeStampLabel release];
	timeStampLabel=nil;
	[messageLabel release];
	messageLabel=nil;
	[scrollView release];
	scrollView=nil;
	[contentView release];
	contentView=nil;
	[super dealloc];
}

@end
