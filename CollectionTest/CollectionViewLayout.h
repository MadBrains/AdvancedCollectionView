//
//  CollectionViewLayout.h
//  CollectionTest
//
//  Created by user on 07.07.16.
//  Copyright © 2016 perpetuumlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@protocol EventDataSource <UICollectionViewDataSource>
- (Event *)eventAtIdexPath:(NSIndexPath *)indexPath;
@end

@interface CollectionViewLayout : UICollectionViewLayout
@property (assign, nonatomic) CGSize hourSize;
@property (assign, nonatomic) CGFloat headerWidth;
@property (assign, nonatomic) CGFloat zoom;
@end
