//
//  IRObjectQueueTestObject.m
//  IRObjectQueue
//
//  Created by Evadne Wu on 6/1/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRObjectQueueTestObject.h"

@interface IRObjectQueueTestObject ()
@property (nonatomic, readwrite, strong) id datum;
@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;
@end

@implementation IRObjectQueueTestObject
@synthesize datum = _datum;
@synthesize reuseIdentifier = _reuseIdentifier;

+ (id) objectWithDatum:(id)datum reuseIdentifier:(NSString *)identifier {

	return [[self alloc] initWithDatum:datum reuseIdentifier:identifier];

}

- (id) initWithDatum:(id)datum reuseIdentifier:(NSString *)identifier {

	self = [super init];
	if (!self)
		return nil;
	
	_datum = datum;
	_reuseIdentifier = [identifier copy];
	
	return self;

}

- (BOOL) isEqual:(id)object {

	if ([object isKindOfClass:[self class]]) {
		
		IRObjectQueueTestObject *castObject = (IRObjectQueueTestObject *)object;
		
		return [castObject.datum isEqual:self.datum] && [castObject.reuseIdentifier isEqual:self.reuseIdentifier];
		
	}
	
	return [super isEqual:object];

}

@end
