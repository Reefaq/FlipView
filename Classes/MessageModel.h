//
//  MessageModel.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject {
	NSInteger messageID;
	NSString* content;
	NSString* createdAt;
	NSString* userName;
	NSString* userImage;
}

-(id)initWithMessageObject:(NSDictionary*)messageObject;

@property (nonatomic,assign) NSInteger messageID;
@property (nonatomic,retain) NSString* content;
@property (nonatomic,retain) NSString* createdAt;
@property (nonatomic,retain) NSString* userName;
@property (nonatomic,retain) NSString* userImage;

@end
