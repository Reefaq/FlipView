//
//  LayoutViewExtention.h
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LayoutViewExtention : UIView {
	UIInterfaceOrientation currrentInterfaceOrientation;
	BOOL isFullScreen;	
}
-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary;
-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)reAdjustLayout;

@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,assign) BOOL isFullScreen;

@end
