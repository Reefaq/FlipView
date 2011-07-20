//
//  FullScreenView.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExtention.h"
#import "MessageModel.h"

@interface FullScreenView : UIViewExtention  {
	MessageModel* messageModel;
	UIView* contentView;

	UIImageView* userImageView;
	UILabel* userNameLabel;
	UILabel* timeStampLabel;
	UILabel* messageLabel;

	UIViewExtention* viewToOverLap;
	UIView* fullScreenBG;
	UIButton* closeButton;
	
	UIScrollView* scrollView;
}

-(id)initWithModel:(MessageModel*)model;
-(void)showFields;

@property (nonatomic,assign) MessageModel* messageModel;
@property (nonatomic,assign) UIViewExtention* viewToOverLap;
@property (nonatomic,assign) UIView* fullScreenBG;
@end
