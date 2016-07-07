//
//  CollectionViewLayout.m
//  CollectionTest
//
//  Created by user on 07.07.16.
//  Copyright © 2016 perpetuumlab. All rights reserved.
//

#import "CollectionViewLayout.h"
#import "Event.h"

@implementation CollectionViewLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.zoom = 1;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.zoom = 1;
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    CGFloat height = 24 * [self heightOfHour] + self.hourSize.height;
    CGFloat width = 8 * self.hourSize.width;
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger eventsCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < eventsCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [array addObject:attributes];
    }
    
    for (int i = 0; i < 7; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"DayHeaderView" atIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [array addObject:attributes];
    }
    
    for (int i = 0; i < [self numberOfHourCellsForZoom:self.zoom]; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"HourHeaderView" atIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [array addObject:attributes];
    }
    
    return array;
}

- (void)setZoom:(CGFloat)zoom
{
    self->_zoom = MAX(1, zoom);
    [self invalidateLayout];
}

- (CGFloat)heightOfHour
{
    return self.hourSize.height * self.zoom;
}

- (NSInteger)numberOfHourCellsForZoom:(CGFloat)zoom
{
    return 24 * (int)zoom;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGRect frame = CGRectZero;
    if ([elementKind isEqualToString:@"DayHeaderView"]) {
        frame.origin.x = (indexPath.row + 1) * self.hourSize.width;
        frame.origin.y = MAX(0,self.collectionView.contentOffset.y);
        frame.size.width = self.hourSize.width;
        frame.size.height = self.hourSize.height;
    }
    else if ([elementKind isEqualToString:@"HourHeaderView"]) {
        frame.origin.x = MAX(0,self.collectionView.contentOffset.x);
        frame.origin.y = indexPath.row * [self heightOfHour] * 24 / [self numberOfHourCellsForZoom:self.zoom] + self.hourSize.height;
        frame.size.width = self.hourSize.width;
        frame.size.height = [self heightOfHour] * 24 / [self numberOfHourCellsForZoom:self.zoom];
    }
    attributes.frame = frame;
    attributes.zIndex = 1;
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<EventDataSource> dataSource = (id)self.collectionView.dataSource;
    Event *event = [dataSource eventAtIdexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForEvent:event];
    return attributes;
}

- (CGRect)frameForEvent:(Event *)event
{
    CGRect frame = CGRectZero;
    frame.origin.x = self.hourSize.width * event.day;
    frame.origin.y = event.start / 3600 * [self heightOfHour] + self.hourSize.height;
    frame.size.width = self.hourSize.width;
    frame.size.height = event.duration / 3600 * [self heightOfHour];
    
 //   frame = CGRectInset(frame, HorizontalSpacing/2.0, 0);
    return frame;
}

@end
