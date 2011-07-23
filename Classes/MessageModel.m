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
//  MessageModel.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
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
