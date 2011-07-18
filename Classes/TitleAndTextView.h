//
//  TitleAndTextView.h
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExtention.h"
@class MessageModel;

@interface TitleAndTextView : UIViewExtention {
	UIView* contentView;
	UIImageView* userImageView;
	UILabel* userNameLabel;
	UILabel* timeStampLabel;
	UILabel* messageLabel;
}

- (id) initWithMessageModel:(MessageModel*)messagemodel;
- (void) initializeFields;
	
@property (nonatomic,retain) MessageModel* messageModel;

@end
