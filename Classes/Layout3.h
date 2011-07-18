//
//  Layout6.h
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LayoutViewExtention.h"
@class UIViewExtention;

@interface Layout3 : LayoutViewExtention {
	UIViewExtention* view1;
	UIViewExtention* view2;
	UIViewExtention* view3;
}
@property (nonatomic,retain) UIViewExtention* view1;
@property (nonatomic,retain) UIViewExtention* view2;
@property (nonatomic,retain) UIViewExtention* view3;

@end
