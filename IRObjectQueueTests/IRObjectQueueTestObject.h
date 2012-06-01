//
//  IRObjectQueueTestObject.h
//  IRObjectQueue
//
//  Created by Evadne Wu on 6/1/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRObjectQueue.h"

@interface IRObjectQueueTestObject : NSObject <IRQueueableObject>

+ (id) objectWithDatum:(id)datum reuseIdentifier:(NSString *)identifier;
- (id) initWithDatum:(id)datum reuseIdentifier:(NSString *)identifier;

@end
