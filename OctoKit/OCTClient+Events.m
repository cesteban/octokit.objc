//
//  OCTClient+Events.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTClient+Events.h"
#import "OCTClient+Private.h"
#import "OCTEvent.h"
#import "OCTUser.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OCTClient (Events)

- (RACSignal *)fetchUserEventsNotMatchingEtag:(NSString *)etag {
	if (self.user == nil) return [RACSignal error:self.class.userRequiredError];
	
	NSString *path = [NSString stringWithFormat:@"users/%@/received_events", self.user.login ? : self.user.rawLogin];
	NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:etag];
	
	return [self enqueueRequest:request resultClass:OCTEvent.class fetchAllPages:NO];
}

@end
