//
//  event.m
//  CollectionTest
//
//  Created by user on 07.07.16.
//  Copyright © 2016 perpetuumlab. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithTitle:(NSString *)title day:(NSUInteger )day start:(NSTimeInterval)start duration:(NSTimeInterval)duration;
{
    self = [super init];
    if (self) {
        self.title = title;
        self.day = day;
        self.start = start;
        self.duration = duration;
    }
    
    return self;
}

+ (instancetype)eventWithTitle:(NSString *)title day:(NSUInteger )day start:(NSTimeInterval)start duration:(NSTimeInterval)duration;
{
    return [[self alloc] initWithTitle:title day:day start:start duration:duration];
}

@end
