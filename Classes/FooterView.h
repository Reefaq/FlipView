//
//  FooterView.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFKPageFlipper;

@interface FooterView : UIView {
	UIInterfaceOrientation currrentInterfaceOrientation;
	NSArray* viewArray;
	AFKPageFlipper* flipperView;
	UIScrollView* barButtonsView;
	UIButton* buttonPrevious;
	UIView* previousView;
	UIView* nextView;
	UIButton* buttonNext;
	int selectedButtonIndex;
	
	int numberTotal;
	int currentScrollNumber;
	int totalScrollNumber;
	BOOL isLoading;
}

@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,readonly) BOOL isLoading;
@property (nonatomic,assign) NSArray* viewArray;
@property (nonatomic,assign) AFKPageFlipper* flipperView;
-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)reAdjustLayout;
@end
