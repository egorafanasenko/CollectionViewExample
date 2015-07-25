//
//  PhotoDataProvider.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoDataProvider.h"
#import "PhotoItem.h"

@interface PhotoDataProvider()

@property(nonatomic, strong) NSMutableArray *photos;

@end

@implementation PhotoDataProvider

#pragma mark Pirvate methods

- (void)createPhotos
{
    self.photos = [NSMutableArray array];
    for(NSUInteger index = 1; index < 16; index++)
    {
        [self.photos addObject:[PhotoItem itemWithSmallImage:[self imageAtIndex:index]]];
    }
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%li.jpg", (long)index]];
}

#pragma mark DataProvderProtocol methods

- (NSUInteger)numberOfSections
{
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section
{
    return self.photos.count;
}

- (id)objectForIndexPath:(NSIndexPath *)indexPath
{
    return self.photos[(NSUInteger)indexPath.row];
}

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self createPhotos];
    }
    return self;
}

#pragma mark Interface methods

- (void)addRandomItem
{
    PhotoItem *item = [PhotoItem itemWithSmallImage:[self imageAtIndex:arc4random() % 15 + 1]];
    [self.photos addObject:item];
}

@end
