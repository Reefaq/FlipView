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
//  WallViewController.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "WallViewController.h"
#import "TitleAndTextView.h"
#import "Layout5.h"
#import "Layout6.h"
#import "Layout7.h"
#import "Layout8.h"

#import "Layout1.h"
#import "Layout2.h"
#import "Layout3.h"
#import "Layout4.h"

#import "UIViewExtention.h"
#import "AFKPageFlipper.h"
#import "FullScreenView.h"
#import "FooterView.h"
#import "HeaderView.h"

#import "MessageModel.h"

@implementation WallViewController

@synthesize viewControlerStack,gestureRecognizer,wallTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self.view setBackgroundColor:[UIColor whiteColor]];
		isInFullScreenMode = FALSE;
		
		messageArrayCollection = [[NSMutableArray alloc] init];
		
		for (int i = 1; i <= 18; i++) {
			
			MessageModel* messageModel1 = [[MessageModel alloc] init];
			messageModel1.messageID= i;
			messageModel1.userName = @"Harry Potter";
			messageModel1.userImage =  @"missing-people.png";
			messageModel1.createdAt = @"06/07/2011 at 01:00 AM";
			messageModel1.content = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
			
			[messageArrayCollection addObject:messageModel1];
			[messageModel1 release];
		}
		
		[self buildPages:messageArrayCollection];
		
		flipper = [[AFKPageFlipper alloc] initWithFrame:self.view.bounds];
		flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		flipper.dataSource = self;
		[self.view addSubview:flipper];
		
    }
    return self;
}

- (int)getRandomNumber:(int)from to:(int)to {
	return (int)from + random() % (to-from+1);
}


-(void)buildPages:(NSArray*)messageArray {
	
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	viewControlerStack = [[NSMutableArray alloc] init]; 
	
	int remainingMessageCount = 0;
	int totalMessageCount = [messageArray count];
	int numOfGroup = totalMessageCount /5;
	
	remainingMessageCount = totalMessageCount;
	
	for (int i=1; i<=numOfGroup; i++) {
		
		remainingMessageCount = totalMessageCount - (i * 5);
		int randomNumber = [self getRandomNumber:5 to:8];
		
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",randomNumber]];
	}
	
	if (remainingMessageCount > 0) {
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",remainingMessageCount]];
	}

	
}


#pragma mark -
#pragma mark Data source implementation



- (NSInteger) numberOfPagesForPageFlipper:(AFKPageFlipper *)pageFlipper {
	return [viewControlerStack count];
}

- (UIView *) viewForPage:(NSInteger) page inFlipper:(AFKPageFlipper *) pageFlipper {

  	LayoutViewExtention* layoutToReturn = nil;
	NSInteger layoutNumber = [[viewControlerStack objectAtIndex:page-1] intValue];
	
	int remainingMessageCount = 0;
	int totalMessageCount = [messageArrayCollection count];
	int numOfGroup = totalMessageCount /5;
	remainingMessageCount = totalMessageCount - (numOfGroup * 5);	
	
	int rangeFrom = 0;
	int rangeTo = 0;
	BOOL shouldContinue = FALSE;
	
	if (page <= numOfGroup) {
		rangeFrom = (page * 5) -5;
		rangeTo = 5;
		shouldContinue = TRUE;
	}else if (remainingMessageCount > 0) {
		rangeFrom = [messageArrayCollection count] - remainingMessageCount;
		rangeTo = remainingMessageCount;
		shouldContinue = TRUE;
	}
	
	if (shouldContinue) {
		
		NSRange rangeForView = NSMakeRange(rangeFrom, rangeTo);
		
		NSArray* messageArray= [messageArrayCollection subarrayWithRange:rangeForView];
		
		NSMutableDictionary* viewDictonary = [[[NSMutableDictionary alloc] init] autorelease];
		TitleAndTextView* view1forLayout;
		TitleAndTextView* view2forLayout;
		TitleAndTextView* view3forLayout;
		TitleAndTextView* view4forLayout;
		TitleAndTextView* view5forLayout;
		for (int i = 0; i < [messageArray count]; i++) {
			if (i == 0) {
				view1forLayout = [[[TitleAndTextView alloc] initWithMessageModel:(MessageModel*)[messageArray objectAtIndex:i]] autorelease];
				[viewDictonary setObject:view1forLayout forKey:@"view1"];
			}
			if (i == 1) {
				view2forLayout = [[[TitleAndTextView alloc] initWithMessageModel:(MessageModel*)[messageArray objectAtIndex:i]] autorelease];
				[viewDictonary setObject:view2forLayout forKey:@"view2"];
			}
			if (i == 2) {
				view3forLayout = [[[TitleAndTextView alloc] initWithMessageModel:(MessageModel*)[messageArray objectAtIndex:i]] autorelease];
				[viewDictonary setObject:view3forLayout forKey:@"view3"];
			}
			if (i == 3) {
				view4forLayout = [[[TitleAndTextView alloc] initWithMessageModel:(MessageModel*)[messageArray objectAtIndex:i]] autorelease];
				[viewDictonary setObject:view4forLayout forKey:@"view4"];
			}
			if (i == 4) {
				view5forLayout = [[[TitleAndTextView alloc] initWithMessageModel:(MessageModel*)[messageArray objectAtIndex:i]] autorelease];
				[viewDictonary setObject:view5forLayout forKey:@"view5"];
			}
		}
		
		Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",layoutNumber]);
		id layoutObject = [[[class alloc] init] autorelease];
		
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			
			layoutToReturn = (LayoutViewExtention*)layoutObject;
			
			[layoutToReturn initalizeViews:viewDictonary];
			[layoutToReturn rotate:self.interfaceOrientation animation:NO];
			[layoutToReturn setFrame:self.view.bounds];
			layoutToReturn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			
			HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, layoutToReturn.frame.size.width, 50)];
			headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			[headerView setWallTitleText:@"My Tweet"];
			[headerView setBackgroundColor:[UIColor whiteColor]];
			[headerView rotate:self.interfaceOrientation animation:NO];
			[layoutToReturn setHeaderView:headerView];
			[headerView release];
			
			FooterView* footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, layoutToReturn.frame.size.height - 20, layoutToReturn.frame.size.width, 20)];
			[footerView setBackgroundColor:[UIColor whiteColor]];
			[footerView setFlipperView:flipper];
			[footerView setViewArray:viewControlerStack];
			
			if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
				[footerView setFrame:CGRectMake(0, 1004 - 20, 768, footerView.frame.size.height)];
			}else {
				[footerView setFrame:CGRectMake(0, 748 - 20, 1024, footerView.frame.size.height)];
			}
			[footerView rotate:self.interfaceOrientation animation:YES];
			
			[layoutToReturn setFooterView:footerView];
			[footerView release];
		}
	}
	
	return layoutToReturn;
}

-(void)showViewInFullScreen:(UIViewExtention*)viewToShow withModel:(MessageModel*)model{
	if (!isInFullScreenMode) {
		isInFullScreenMode = TRUE;
		
		CGRect bounds = [UIScreen mainScreen].bounds;
		if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
			CGFloat width = bounds.size.width;
			bounds.size.width = bounds.size.height;
			bounds.size.height = width;
		}
		
		
		fullScreenBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
		fullScreenBGView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[fullScreenBGView setBackgroundColor:RGBACOLOR(0,0,0,0.6)];
		fullScreenBGView.alpha = 0;
		[self.view addSubview:fullScreenBGView];
		
		
		viewToShowInFullScreen =  viewToShow;
		viewToShowInFullScreen.originalRect = viewToShowInFullScreen.frame;
		viewToShowInFullScreen.isFullScreen = TRUE;
		FullScreenView* fullView = [[FullScreenView alloc] initWithModel:model];
		fullView.frame = viewToShowInFullScreen.frame;
		fullView.viewToOverLap = viewToShowInFullScreen;
		fullView.fullScreenBG = fullScreenBGView;
		fullScreenView = fullView;
		[self.view addSubview:fullView];
		
		[self.view bringSubviewToFront:fullScreenBGView];	
		[self.view bringSubviewToFront:fullView];
		
		[UIView beginAnimations:@"SHOWFULLSCREEN" context:NULL];
		[UIView setAnimationDuration:0.40];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
		fullScreenBGView.alpha = 1;
		if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			[fullView setFrame:CGRectMake(10, 50, 768-20, 1004-60)];
		}else {
			[fullView setFrame:CGRectMake(10, 50, 1024-20, 746-60)];
		}
		[fullScreenView rotate:self.interfaceOrientation animation:YES];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
		
	}

	
}

-(void)closeFullScreen {
	if (fullScreenView != nil) {
		fullScreenBGView.alpha=0;
		[fullScreenBGView removeFromSuperview];
		[fullScreenBGView release];
		
		fullScreenView.alpha = 0;
		[fullScreenView removeFromSuperview];
		[fullScreenView release];
		fullScreenView = nil;
		isInFullScreenMode = FALSE;
	}
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	if (fullScreenView != nil) {
		[UIView beginAnimations:@"WILLROTATE" context:NULL];
		[UIView setAnimationDuration:0.50];
		[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
		if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			[fullScreenView setFrame:CGRectMake(10, 50, 768-20, 1004-60)];
		}else {
			[fullScreenView setFrame:CGRectMake(10, 50, 1024-20, 748-60)];
		}
		[fullScreenView rotate:toInterfaceOrientation animation:YES];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
	}
	
	
	if ([viewControlerStack count] > 0 && [flipper.subviews count] > 0) {
		
		for (UIView* subview in flipper.subviews) {
			if ([subview isKindOfClass:[LayoutViewExtention class]]) {
				LayoutViewExtention* layoutView = (LayoutViewExtention*)subview;
				[layoutView rotate:toInterfaceOrientation animation:YES];
				layoutView.footerView.alpha = 0;
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.10];
				if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
					[layoutView.footerView setFrame:CGRectMake(0, 1004 - 20, 768, layoutView.footerView.frame.size.height)];
				}else {
					[layoutView.footerView setFrame:CGRectMake(0, 748 - 20, 1024, layoutView.footerView.frame.size.height)];
				}
				[layoutView.footerView rotate:toInterfaceOrientation animation:YES];
				[layoutView.headerView rotate:toInterfaceOrientation animation:YES];
				[UIView commitAnimations];
			}
			
		}
		
	}
	
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if ([viewControlerStack count] > 0 && [flipper.subviews count] > 0) {
		for (UIView* subview in flipper.subviews) {
			if ([subview isKindOfClass:[LayoutViewExtention class]]) {
				LayoutViewExtention* layoutView = (LayoutViewExtention*)subview;
				layoutView.footerView.alpha = 1;
			}
		}
	}
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
	if ([animationID isEqualToString:@"WILLROTATE"]) {
		if (fullScreenView != nil) {
			[fullScreenView setBackgroundColor:RGBACOLOR(0,0,0,0.6)];
		}		
	}else if ([animationID isEqualToString:@"FOOTER"]) {
		if (context) {
			((UIView*)context).alpha = 1;
		}
	}else if ([animationID isEqualToString:@"SHOWFULLSCREEN"]) {
		[fullScreenView showFields];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (flipper) {
		return !flipper.animating;
	}
	
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


-(void) generateViews:(NSArray *)currentMesageArray {
	
	int remainingMessageCount = 0;
	int totalMessageCount = [currentMesageArray count];
	int numOfGroup = totalMessageCount /5;
	
	remainingMessageCount = totalMessageCount;
	
	for (int i=1; i<=numOfGroup; i++) {
		remainingMessageCount = totalMessageCount - (i * 5);
		int randomNumber = [self getRandomNumber:5 to:8];
		
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",randomNumber]];
	}
	
	if (remainingMessageCount > 0) {
		numOfGroup += 1;
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",remainingMessageCount]];
	}
	
	flipper.numberOfPages = [viewControlerStack count];	
	
	if ([viewControlerStack count] > 0 && flipper.currentView) {
		if ([flipper.currentView isKindOfClass:[LayoutViewExtention class]]) {
			LayoutViewExtention* layoutView = (LayoutViewExtention*)flipper.currentView;
			[layoutView.footerView performSelectorInBackground:@selector(updateBarButtons:) withObject:[NSString stringWithFormat:@"%d",numOfGroup]];
		}
	}
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[messageArrayCollection release];
	if (fullScreenBGView != nil) {
		[fullScreenBGView release];
	}
	[viewControlerStack release];
	[gestureRecognizer release];
	[flipper release];
	if (fullScreenView != nil) {
		[fullScreenView release];
	}
	[wallTitle release];
    [super dealloc];
}


@end
