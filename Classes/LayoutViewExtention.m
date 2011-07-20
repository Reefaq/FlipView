//
//  LayoutViewExtention.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import "LayoutViewExtention.h"


@implementation LayoutViewExtention

@synthesize currrentInterfaceOrientation,isFullScreen;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
	
	[self reAdjustLayout];
}

-(void)reAdjustLayout {
	//view extending this class can overide this method
}

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary {
	//view extending this class can overide this method
}

@end
