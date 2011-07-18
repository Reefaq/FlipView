//
//  MessageModel.m
//  FlipViewProject
//
//  Created by Reefaq Mohammed on 16/07/11.
//  Copyright 2010 raw eng. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

@synthesize messageID;
@synthesize content;
@synthesize createdAt;
@synthesize userName;
@synthesize userImage;

-(id)initWithMessageObject:(NSDictionary*)messageObject {
	if (self = [super init]) {
		self.messageID = (NSInteger)[[messageObject objectForKey:@"id"] intValue];
		self.content = [messageObject objectForKey:@"content"];
		self.createdAt = [messageObject objectForKey:@"created_at"];
		self.userName = [messageObject objectForKey:@"userName"];
		self.userImage = [messageObject objectForKey:@"userImage"];
	}
	return self;
}


- (void) dealloc {
	[content release];
	[createdAt release];
	[userName release];
	[userImage release];
	[super dealloc];
}

@end
