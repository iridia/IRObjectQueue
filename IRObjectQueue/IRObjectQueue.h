//
//  IRObjectQueue.h
//  IRObjectQueue
//
//  Created by Evadne Wu on 6/1/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRQueueableObject <NSObject>

- (NSString *) reuseIdentifier;

@end

@interface IRObjectQueue : NSObject

- (void) addObject:(id<IRQueueableObject>)object;
- (id<IRQueueableObject>) dequeueObjectWithIdentifier:(NSString *)reuseIdentifier;

- (void) removeAllObjects;

@end
