//
//  IRObjectQueue.m
//  IRObjectQueue
//
//  Created by Evadne Wu on 6/1/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRObjectQueue.h"
#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif


@interface IRObjectQueue ()

@property (nonatomic, readwrite, strong) NSMutableDictionary *identifierToObjects;
- (NSMutableSet *) mutableSetForIdentifier:(NSString *)identifier;

@end

@implementation IRObjectQueue
@synthesize identifierToObjects = _identifierToObjects;
@synthesize purgesAutomatically = _purgesAutomatically;

- (id) init {

	self = [super init];
	if (!self)
		return nil;
		
	_purgesAutomatically = YES;
	
#if TARGET_OS_IPHONE

	__weak IRObjectQueue *wSelf = self;

	[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
	
		[wSelf handleMemoryWarning:note];
		
	}];

#endif
	
	return self;

}

- (NSMutableDictionary *) identifierToObjects {

	if (!_identifierToObjects)
		_identifierToObjects = [NSMutableDictionary dictionary];
	
	return _identifierToObjects;

}

- (void) addObject:(id<IRQueueableObject>)object {

	NSString *reuseID = [object reuseIdentifier];
	
	NSParameterAssert(object);
	NSParameterAssert(reuseID);
	
	[[self mutableSetForIdentifier:reuseID] addObject:object];

}

- (id) dequeueObjectWithIdentifier:(NSString *)reuseID {

	NSMutableSet *ms = [self mutableSetForIdentifier:reuseID];
	id<IRQueueableObject> answer = [ms anyObject];
	
	if (answer)
		[ms removeObject:answer];
		
	return answer;
	
}

- (void) removeAllObjects {

	self.identifierToObjects = nil;

}

- (NSMutableSet *) mutableSetForIdentifier:(NSString *)identifier {

	NSMutableDictionary *idsToObjs = self.identifierToObjects;
	NSMutableSet *answer = [idsToObjs objectForKey:identifier];
	if (!answer) {
		answer = [NSMutableSet set];
		[idsToObjs setObject:answer forKey:identifier];
	}
	
	return answer;

}

- (void) handleMemoryWarning:(NSNotification *)note {

	if (self.purgesAutomatically)
		[self removeAllObjects];

}

@end