//
//  event.h
//  CollectionTest
//
//  Created by user on 07.07.16.
//  Copyright © 2016 perpetuumlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) NSTimeInterval start;
@property (assign, nonatomic) NSTimeInterval duration;
- (instancetype)initWithTitle:(NSString *)title day:(NSUInteger )day start:(NSTimeInterval)start duration:(NSTimeInterval)duration;
+ (instancetype)eventWithTitle:(NSString *)title day:(NSUInteger )day start:(NSTimeInterval)start duration:(NSTimeInterval)duration;
@end
