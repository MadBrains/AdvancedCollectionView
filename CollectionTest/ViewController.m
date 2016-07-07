//
//  ViewController.m
//  CollectionTest
//
//  Created by user on 07.07.16.
//  Copyright © 2016 perpetuumlab. All rights reserved.
//

#import "ViewController.h"
#import "Event.h"
#import "CollectionViewCell.h"
#import "CollectionViewLayout.h"
#import "HeaderView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *array;
@property (assign, nonatomic) CGFloat prevZoom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [self createEvents];
    
    CollectionViewLayout *layout =(id)self.collectionView.collectionViewLayout;
    layout.hourSize = CGSizeMake(100.0f, 44.0f);
    
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"HourHeaderView" withReuseIdentifier:@"HeaderView"];
}

- (Event *)eventAtIdexPath:(NSIndexPath *)indexPath
{
    return self.array[indexPath.row];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *viewCell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
    viewCell.label.text = [self.array[indexPath.row] title];
    return viewCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    if ([kind isEqualToString:@"DayHeaderView"]) {
        headerView.label.text = [NSString stringWithFormat:@"day %ld",(long)indexPath.row + 1];
    }
    else if ([kind isEqualToString:@"HourHeaderView"]) {
        CollectionViewLayout *layout =(id)self.collectionView.collectionViewLayout;
        CGFloat zoom = (int)layout.zoom;
        headerView.label.text = [NSString stringWithFormat:@"hour %.2f",(indexPath.row + 1) / zoom];
    }

    return headerView;
}

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender
{
    CollectionViewLayout *layout =(id)self.collectionView.collectionViewLayout;
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.prevZoom = layout.zoom;
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat scale = sender.scale;
        layout.zoom = scale * self.prevZoom;
        [self.collectionView reloadData];
    }
}

- (NSArray *)createEvents
{
    return @[[Event eventWithTitle:@"First event" day:1 start:3600 * 0 duration:3600],
             [Event eventWithTitle:@"Second event" day:1 start:3600 * 2 duration:4000],
             [Event eventWithTitle:@"Perpetuum event" day:1 start:3600 * 4 duration:3600],
             [Event eventWithTitle:@"Super event" day:1 start:3600 * 10 duration:5000],
             [Event eventWithTitle:@"Failed event" day:2 start:3600 * 2 duration:1000],
             [Event eventWithTitle:@"Mega event" day:2 start:3600 * 5 duration:3600],
             [Event eventWithTitle:@"Test event" day:2 start:3600 * 10 duration:3600],
             [Event eventWithTitle:@"Fucking event" day:2 start:3600 * 11 duration:3600],
             [Event eventWithTitle:@"Sega mega drive event" day:3 start:3600 * 12 duration:5000],
             [Event eventWithTitle:@"Ulcamp event" day:4 start:3600 * 5 duration:3600],
             [Event eventWithTitle:@"birthday event" day:4 start:3600 * 12 duration:3600],
             [Event eventWithTitle:@"Event #198" day:4 start:3600 * 22 duration:1000],
             [Event eventWithTitle:@"First event" day:5 start:3600 * 13 duration:3600],
             [Event eventWithTitle:@"Content event" day:6 start:3600 * 22 duration:3600],
             [Event eventWithTitle:@"Recreated event" day:7 start:3600 * 3 duration:4000],
             [Event eventWithTitle:@"Typically event" day:7 start:3600 * 6 duration:3600],
             [Event eventWithTitle:@"Additional event" day:7 start:3600 * 9 duration:3700],
             [Event eventWithTitle:@"Last event" day:7 start:3600 * 22 duration:3600],
             ];
}

@end
