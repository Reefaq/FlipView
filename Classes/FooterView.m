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
//  FooterView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "FooterView.h"

#import "AFKPageFlipper.h"

@implementation FooterView

@synthesize currrentInterfaceOrientation,viewArray,flipperView,isLoading;

-(void)reAssignPaginationButtons {
	
	if (currentScrollNumber == 1) {
		if (numberTotal > 15) {
			
			
			UILabel* prevLabel = (UILabel*)[previousView viewWithTag:1];
			UIImageView* prevImage =(UIImageView*)[previousView viewWithTag:2];
			
			UILabel* nextLabel = (UILabel*)[nextView viewWithTag:1];
			UIImageView* nextImage = (UIImageView*)[nextView viewWithTag:2];
			
			[prevLabel setText:@"1"];
			[prevLabel sizeToFit];

			[buttonPrevious setHidden:TRUE];
			[buttonNext setHidden:FALSE];
			[nextLabel setText:[NSString stringWithFormat:@"%d - %d",(15*(currentScrollNumber))+1,numberTotal]];
			[nextLabel sizeToFit];

			[prevImage setFrame:CGRectMake(0, 3, prevImage.frame.size.width, prevImage.frame.size.height)];
			[prevLabel setFrame:CGRectMake(prevImage.frame.origin.x + prevImage.frame.size.width + 5, 0, prevLabel.frame.size.width, prevLabel.frame.size.height)];
			[previousView setFrame:CGRectMake(0, 0, prevLabel.frame.size.width + prevImage.frame.size.width + 5, 20)];

			[nextLabel setFrame:CGRectMake(0, 0, nextLabel.frame.size.width, nextLabel.frame.size.height)];
			[nextImage setFrame:CGRectMake(nextLabel.frame.origin.x + nextLabel.frame.size.width + 5, 3, nextImage.frame.size.width, nextImage.frame.size.height)];
			[nextView setFrame:CGRectMake(0, 0, nextLabel.frame.size.width + nextImage.frame.size.width + 5, 20)];
			
			[previousView setUserInteractionEnabled:FALSE];
			[nextView setUserInteractionEnabled:FALSE];

			[buttonPrevious setUserInteractionEnabled:TRUE];
			[buttonNext setUserInteractionEnabled:TRUE];

			[buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - previousView.frame.size.width) - 5, 0, previousView.frame.size.width, 20)];
			[buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 0, nextView.frame.size.width, 20)];
			
		}else {
			[buttonPrevious setHidden:TRUE];
			[buttonNext setHidden:TRUE];
		}

	}else {
		if (numberTotal > 15) {
			
			UILabel* prevLabel = (UILabel*)[previousView viewWithTag:1];
			UIImageView* prevImage =(UIImageView*)[previousView viewWithTag:2];
			
			UILabel* nextLabel = (UILabel*)[nextView viewWithTag:1];
			UIImageView* nextImage = (UIImageView*)[nextView viewWithTag:2];
			
			
			[buttonNext setHidden:FALSE];
			[buttonPrevious setHidden:FALSE];			
			[prevLabel setText:[NSString stringWithFormat:@"%d - %d",1,((15*(currentScrollNumber))-15)]];
			[prevLabel sizeToFit];

			[nextLabel setText:[NSString stringWithFormat:@"%d - %d",(15*(currentScrollNumber)) +1,numberTotal]];
			[nextLabel sizeToFit];

			if (((15*(currentScrollNumber)) +1) > numberTotal) {
				[buttonNext setHidden:TRUE];
			}
			[buttonNext sizeToFit];
			[buttonPrevious sizeToFit];
			
			
			[prevImage setFrame:CGRectMake(0, 3, prevImage.frame.size.width, prevImage.frame.size.height)];
			[prevLabel setFrame:CGRectMake(prevImage.frame.origin.x + prevImage.frame.size.width + 5, 0, prevLabel.frame.size.width, prevLabel.frame.size.height)];
			[previousView setFrame:CGRectMake(0, 0, prevLabel.frame.size.width + prevImage.frame.size.width + 5, 20)];
			
			[nextLabel setFrame:CGRectMake(0, 0, nextLabel.frame.size.width, nextLabel.frame.size.height)];
			[nextImage setFrame:CGRectMake(nextLabel.frame.origin.x + nextLabel.frame.size.width + 5, 3, nextImage.frame.size.width, nextImage.frame.size.height)];
			[nextView setFrame:CGRectMake(0, 0, nextLabel.frame.size.width + nextImage.frame.size.width + 5, 20)];
			
			[previousView setUserInteractionEnabled:FALSE];
			[nextView setUserInteractionEnabled:FALSE];
			
			[buttonPrevious setUserInteractionEnabled:TRUE];
			[buttonNext setUserInteractionEnabled:TRUE];

			[buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - previousView.frame.size.width) - 5, 0, previousView.frame.size.width, 20)];
			[buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 0, nextView.frame.size.width, 20)];
			
		}else {
			[buttonPrevious setHidden:TRUE];
			[buttonNext setHidden:TRUE];
		}
	}
	
	
	
	
}


-(void) generateButtons {
	
	if (previousView) {
		for (UIView* view in previousView.subviews) {
			[view removeFromSuperview];
		}
		[previousView removeFromSuperview];
		[previousView release];
	}
	
	previousView = [[UIView alloc] init];

	UILabel* labelPrevious = [[UILabel alloc] init];
	[labelPrevious setText:@"1"];
	[labelPrevious setTextColor:[UIColor darkGrayColor]];
	[labelPrevious setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
	[labelPrevious sizeToFit];
	[labelPrevious setTag:1];
	[previousView addSubview:labelPrevious];
	[labelPrevious release];
	
	UIImageView* prevImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"previous.png"]];
	[prevImage setTag:2];
	[previousView addSubview:prevImage];
	[prevImage release];
	
	[previousView setUserInteractionEnabled:FALSE];
	
	
	buttonPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonPrevious addSubview:previousView];
	[buttonPrevious sizeToFit];
	[buttonPrevious addTarget:self action:@selector(previousClick:) forControlEvents:UIControlEventTouchUpInside];

	if (nextView) {
		for (UIView* view in nextView.subviews) {
			[view removeFromSuperview];
		}
		[nextView removeFromSuperview];
		[nextView release];
	}
	
	nextView = [[UIView alloc] init];
	
	UILabel* labelNext = [[UILabel alloc] init];
	[labelNext setText:@"1"];
	[labelNext setTextColor:[UIColor darkGrayColor]];
	[labelNext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
	[labelNext sizeToFit];
	[labelNext setTag:1];
	[nextView addSubview:labelNext];
	[labelNext release];
	
	UIImageView* nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
	[nextImage setTag:2];
	[nextView addSubview:nextImage];
	[nextImage release];
	
	[nextView setUserInteractionEnabled:FALSE];
	
	
	buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonNext addSubview:nextView];
	[buttonNext sizeToFit];
	[buttonNext addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
	
	if (barButtonsView) {
		for (UIView* view in barButtonsView.subviews) {
			[view removeFromSuperview];
		}
		[barButtonsView removeFromSuperview];
		[barButtonsView release];
	}	
	
	barButtonsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
	[barButtonsView setBackgroundColor:[UIColor whiteColor]];
	CGFloat left = 10;
	CGFloat width = 0;
	for (int i = 1; i <= numberTotal; i++) {
		UIButton* boxButton = [[UIButton alloc] init];
		[boxButton setBackgroundColor:[UIColor clearColor]];
		[boxButton setTag:i];
		[boxButton setFrame:CGRectMake(left, 4, 27, 16)];
		[boxButton addTarget:self action:@selector(boxClick:) forControlEvents:UIControlEventTouchUpInside];
		width = boxButton.frame.origin.x + boxButton.frame.size.width;
		
		[boxButton setImage:[UIImage imageNamed:@"unselected-page.png"] forState:UIControlStateNormal];
		
		//[boxButton setBackgroundColor:[UIColor blackColor]];
		if (flipperView.currentPage == i) {
			selectedButtonIndex = i;
			[boxButton setFrame:CGRectMake(left, 2, 27, 20)];
			[boxButton setImage:[UIImage imageNamed:@"selected-page.png"] forState:UIControlStateNormal];
			//[boxButton setBackgroundColor:[UIColor redColor]];
		}
		[barButtonsView addSubview:boxButton];
		[boxButton release];
		left+=30;
	}
	width +=10;
	BOOL shouldScroll = FALSE;
	int scrollCount = 0;
	if (width > 450) {
		scrollCount = floor(flipperView.currentPage/15) + 1;
		if (flipperView.currentPage % 15==0) {
			scrollCount -= 1;
		}
		shouldScroll = TRUE;		
		width = 450;
	}
	[barButtonsView setFrame:CGRectMake((self.frame.size.width/2) - (width/2), barButtonsView.frame.origin.y, width, barButtonsView.frame.size.height)];
	[barButtonsView setContentSize:CGSizeMake(barButtonsView.frame.size.width/2, barButtonsView.frame.size.height)];

	if (shouldScroll) {
		if (scrollCount > 1) {
			[barButtonsView setContentOffset:CGPointMake(((scrollCount-1) * 450), barButtonsView.frame.origin.y) animated:NO];
			currentScrollNumber =scrollCount;

		}else {
			[barButtonsView setContentOffset:CGPointMake(0, barButtonsView.frame.origin.y) animated:NO];
			currentScrollNumber = 1;
			
			[barButtonsView setFrame:CGRectMake(barButtonsView.frame.origin.x, barButtonsView.frame.origin.y, 450, barButtonsView.frame.size.height)];
			
		}
	}
	[buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - (buttonPrevious.frame.size.width-5)) - 5, 0, buttonPrevious.frame.size.width, buttonPrevious.frame.size.height-12)];
	[buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 0, buttonNext.frame.size.width, buttonNext.frame.size.height-12)];
	[self addSubview:barButtonsView];
	[self addSubview:buttonPrevious];
	[self addSubview:buttonNext];
	
	totalScrollNumber = (numberTotal / 15) +1;	
	if (!shouldScroll) {
		currentScrollNumber = 1;
	}	
	[self reAssignPaginationButtons];
	
}

-(void) setViewArray:(NSArray *) arrayToSet {
	viewArray = arrayToSet;
	
	numberTotal = [viewArray count];
	
	[self generateButtons];
}

-(void)boxClick:(id)sender {
	UIButton* button = (UIButton*)sender;
	
	if (flipperView != nil) {
		if (flipperView.currentPage != button.tag) {
			[flipperView setCurrentPage:button.tag animated:TRUE];
		}
	}		
}

-(void)previousClick:(id)sender {
	if (currentScrollNumber > 1) {
		currentScrollNumber -= 1;
		[barButtonsView setContentOffset:CGPointMake(barButtonsView.contentOffset.x - 450, barButtonsView.frame.origin.y) animated:YES];
		[self reAssignPaginationButtons];
	}
}
-(void)nextClick:(id)sender {
	if (currentScrollNumber < totalScrollNumber) {
		currentScrollNumber += 1;
		[barButtonsView setContentOffset:CGPointMake(barButtonsView.contentOffset.x + 450, barButtonsView.frame.origin.y) animated:YES];
		[self reAssignPaginationButtons];
	}	
}


-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
	[self reAdjustLayout];
}

-(void)reAdjustLayout {
		[barButtonsView setFrame:CGRectMake((self.frame.size.width/2) - barButtonsView.frame.size.width/2, 0, barButtonsView.frame.size.width, barButtonsView.frame.size.height)];
		[buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - buttonPrevious.frame.size.width) - 5, 0, buttonPrevious.frame.size.width, 20)];
		[buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 0, buttonNext.frame.size.width, 20)];

		[barButtonsView setContentOffset:CGPointMake(450 * (currentScrollNumber-1), barButtonsView.frame.origin.y) animated:YES];
}

-(void) dealloc {
	[nextView release];
	[previousView release];
	[barButtonsView release];
	[super dealloc];
}

@end
