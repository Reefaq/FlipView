//
//  WallViewController.m
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
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
		
		NSMutableArray* messageArray = [[NSMutableArray alloc] init];
		
		for (int i = 1; i <= 18; i++) {
			
			MessageModel* messageModel1 = [[MessageModel alloc] init];
			messageModel1.messageID= i;
			messageModel1.userName = @"Reefaq Mohammed";
			messageModel1.userImage =  @"missing-people.png";
			messageModel1.createdAt = @"06/07/2011 at 01:00 AM";
			messageModel1.content = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
			
			[messageArray addObject:messageModel1];
			[messageModel1 release];
		}
		
		[self buildPages:messageArray];
		[messageArray release];
    }
    return self;
}

- (int)getRandomNumber:(int)from to:(int)to {
	return (int)from + random() % (to-from+1);
}


-(void)buildPages:(NSArray*)messageArrayCollection {
	
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	viewControlerStack = [[NSMutableArray alloc] init]; 
	
	int remainingMessageCount = 0;
	int totalMessageCount = [messageArrayCollection count];
	int numOfGroup = totalMessageCount /5;
	
	remainingMessageCount = totalMessageCount;


	for (int i=1; i<=numOfGroup; i++) {
		
		remainingMessageCount = totalMessageCount - (i * 5);
		
		NSRange rangeForView = NSMakeRange( (i * 5) -5, 5);
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
		
		
		int randomNumber = [self getRandomNumber:5 to:8];
		
		Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",randomNumber]);
		id layoutObject = [[[class alloc] init] autorelease];
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			[(LayoutViewExtention*)layoutObject initalizeViews:viewDictonary];
			[(LayoutViewExtention*)layoutObject rotate:self.interfaceOrientation animation:NO];
			[(LayoutViewExtention*)layoutObject setFrame:self.view.bounds];
			((LayoutViewExtention*)layoutObject).autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			[viewControlerStack addObject:layoutObject];
		}
		
	}
	
	if (remainingMessageCount > 0) {
			NSRange rangeForView = NSMakeRange( ([messageArrayCollection count]) - remainingMessageCount, remainingMessageCount);
			NSArray* messageArray= [messageArrayCollection subarrayWithRange:rangeForView];
			
			NSMutableDictionary* viewDictonary = [[[NSMutableDictionary alloc] init] autorelease];
			TitleAndTextView* view1forLayout;
			TitleAndTextView* view2forLayout;
			TitleAndTextView* view3forLayout;
			TitleAndTextView* view4forLayout;
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
			}		
			
			
			Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",remainingMessageCount]);
			id layoutObject = [[[class alloc] init] autorelease];
			if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
				[(LayoutViewExtention*)layoutObject initalizeViews:viewDictonary];
				[(LayoutViewExtention*)layoutObject rotate:self.interfaceOrientation animation:NO];
				[(LayoutViewExtention*)layoutObject setFrame:self.view.bounds];
				((LayoutViewExtention*)layoutObject).autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
				[viewControlerStack addObject:layoutObject];
			}
		
	}
	
	
	flipper = [[AFKPageFlipper alloc] initWithFrame:self.view.bounds];
	flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	flipper.dataSource = self;
	
	[self.view addSubview:flipper];
	
	
}


#pragma mark -
#pragma mark Data source implementation



- (NSInteger) numberOfPagesForPageFlipper:(AFKPageFlipper *)pageFlipper {
	return [viewControlerStack count];
}


- (UIView *) viewForPage:(NSInteger) page inFlipper:(AFKPageFlipper *) pageFlipper {

	LayoutViewExtention* layoutView  = (LayoutViewExtention*)[viewControlerStack objectAtIndex:page-1];
	[layoutView setFrame:pageFlipper.bounds];
	[layoutView setHidden:FALSE];
	[layoutView setTag:page];
	[layoutView rotate:self.interfaceOrientation animation:NO];
	
	layoutView.alpha = 1;
	
	UIView* footerViewInLayout = (UIView*) [layoutView viewWithTag:200];
	[footerViewInLayout removeFromSuperview];

	UIView* headerViewInLayout = (UIView*) [layoutView viewWithTag:201];
	[(HeaderView*)headerViewInLayout rotate:self.interfaceOrientation animation:NO];
	
		FooterView* footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, layoutView.frame.size.height - 20, layoutView.frame.size.width, 20)];
		[footerView setBackgroundColor:[UIColor whiteColor]];
		[footerView setTag:200];
		[footerView setFlipperView:flipper];
		[footerView setViewArray:viewControlerStack];
		[layoutView addSubview:footerView];
		[layoutView setBackgroundColor:[UIColor whiteColor]];
		[footerView release];	
	
	if (headerViewInLayout == nil) {
		//self.wallTitle
		HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, layoutView.frame.size.width, 50)];
		headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[headerView setWallTitleText:@"My Tweet"];
		[headerView setTag:201];
		[headerView setBackgroundColor:[UIColor whiteColor]];
		[layoutView addSubview:headerView];
		[headerView release];
	}
	
	
	return layoutView;
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
	
	
	if ([viewControlerStack count] > 0) {
		LayoutViewExtention* layoutView = (LayoutViewExtention*)[viewControlerStack objectAtIndex:flipper.currentPage-1];
		[layoutView rotate:toInterfaceOrientation animation:YES];
		FooterView* footerView = (FooterView*)[layoutView viewWithTag:200];
		footerView.alpha = 0;
		HeaderView* headerView = (HeaderView*)[layoutView viewWithTag:201];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.10];
		if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			[footerView setFrame:CGRectMake(0, 1004 - 20, 768, footerView.frame.size.height)];
		}else {
			[footerView setFrame:CGRectMake(0, 748 - 20, 1024, footerView.frame.size.height)];
		}
		[footerView rotate:toInterfaceOrientation animation:YES];
		[headerView rotate:toInterfaceOrientation animation:YES];
		[UIView commitAnimations];
	}
	
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if ([viewControlerStack count] > 0) {
		LayoutViewExtention* layoutView = (LayoutViewExtention*)[viewControlerStack objectAtIndex:flipper.currentPage-1];
		FooterView* footerView = (FooterView*)[layoutView viewWithTag:200];
		footerView.alpha = 1;
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
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

-(void) generateViews:(NSArray *)currentMesageArray {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  

	int remainingMessageCount = 0;
	int totalMessageCount = [currentMesageArray count];
	int numOfGroup = totalMessageCount /5;
	
	remainingMessageCount = totalMessageCount;
	
	for (int i=1; i<=numOfGroup; i++) {
		remainingMessageCount = totalMessageCount - (i * 5);
		
		NSRange rangeForView = NSMakeRange( (i * 5) -5, 5);
		NSArray* messageArray= [currentMesageArray subarrayWithRange:rangeForView];
		
		NSMutableDictionary* viewDictonary = [[NSMutableDictionary alloc] init];
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
		
		int randomNumber = [self getRandomNumber:5 to:8];
		
		Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",randomNumber]);
		id layoutObject = [[[class alloc] init] autorelease];
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			[(LayoutViewExtention*)layoutObject initalizeViews:viewDictonary];
			[(LayoutViewExtention*)layoutObject rotate:self.interfaceOrientation animation:NO];
			[(LayoutViewExtention*)layoutObject setFrame:self.view.bounds];
			((LayoutViewExtention*)layoutObject).autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			[((LayoutViewExtention*)layoutObject) setHidden:TRUE];
			[viewControlerStack addObject:layoutObject];
		}
		[viewDictonary release];
	}
	
	flipper.numberOfPages = [viewControlerStack count];
	
	if (remainingMessageCount > 0) {
		NSRange rangeForView = NSMakeRange( [currentMesageArray count] - remainingMessageCount, remainingMessageCount);
		NSArray* messageArray= [currentMesageArray subarrayWithRange:rangeForView];
		
		NSMutableDictionary* viewDictonary = [[NSMutableDictionary alloc] init];
		TitleAndTextView* view1forLayout;
		TitleAndTextView* view2forLayout;
		TitleAndTextView* view3forLayout;
		TitleAndTextView* view4forLayout;
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
		}		
		
		Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",remainingMessageCount]);
		id layoutObject = [[[class alloc] init] autorelease];
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			[(LayoutViewExtention*)layoutObject initalizeViews:viewDictonary];
			[(LayoutViewExtention*)layoutObject rotate:self.interfaceOrientation animation:NO];
			[(LayoutViewExtention*)layoutObject setFrame:self.view.bounds];
			((LayoutViewExtention*)layoutObject).autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			[((LayoutViewExtention*)layoutObject) setHidden:TRUE];
			[viewControlerStack addObject:layoutObject];
			numOfGroup += 1;
		}
		
		[viewDictonary release];
		flipper.numberOfPages = [viewControlerStack count];
	}
	
	LayoutViewExtention* layoutView = (LayoutViewExtention*)[viewControlerStack objectAtIndex:flipper.currentPage-1];
	FooterView* footerView = (FooterView*)[layoutView viewWithTag:200];
	[footerView performSelectorInBackground:@selector(updateBarButtons:) withObject:[NSString stringWithFormat:@"%d",numOfGroup]];
	
	[pool release];	

}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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
