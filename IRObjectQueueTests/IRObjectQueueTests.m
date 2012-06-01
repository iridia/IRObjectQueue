//
//  IRObjectQueueTests.m
//  IRObjectQueueTests
//
//  Created by Evadne Wu on 6/1/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRObjectQueueTests.h"
#import "IRObjectQueue.h"
#import "IRObjectQueueTestObject.h"

@interface IRObjectQueueTests ()

@property (nonatomic, readwrite, strong) IRObjectQueue *objectQueue;

@end


@implementation IRObjectQueueTests
@synthesize objectQueue;

- (void) setUp {

	[super setUp];
	
	self.objectQueue = [IRObjectQueue new];
	
}

- (void) tearDown {
	
	[super tearDown];
	
	self.objectQueue = nil;
	
}

- (void) testQueueing {

	static NSString * const kReuseID = @"-[IRObjectQueueTests testQueueing] Reuse Identifier";
	static NSUInteger const kNumberOfObjects = 100;
	
	for (NSUInteger i = 0; i < kNumberOfObjects; i++) {
		
		id datum = [NSString stringWithFormat:@"%i", i];
		
		IRObjectQueueTestObject *oqto = [IRObjectQueueTestObject objectWithDatum:datum reuseIdentifier:kReuseID];
		
		[self.objectQueue addObject:oqto];
		
	}
	
	NSMutableSet *dequeuedObjects = [NSMutableSet set];
	IRObjectQueueTestObject *dequeued = nil;
	
	while ((dequeued = [self.objectQueue dequeueObjectWithIdentifier:kReuseID])) {
		
		STAssertFalse([dequeuedObjects containsObject:dequeued], @"Dequeued object %@ must not be dequeued again", dequeued);
		
		STAssertEquals((NSUInteger)0, (NSUInteger)[[dequeuedObjects objectsPassingTest:^(IRObjectQueueTestObject *obj, BOOL *stop) {
			return [obj isEqual:dequeued];
		}] count], @"Dequeued object %@ must be unique", dequeued);
		
		[dequeuedObjects addObject:dequeued];
	}

}


@end
