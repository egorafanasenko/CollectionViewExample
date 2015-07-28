//
//  PhotoDataProvider.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoDataProvider.h"
#import "PhotoItem.h"
#import "CoreDataManager.h"
#import "Photo.h"

@interface PhotoDataProvider()

@property(nonatomic, strong) NSMutableArray *photos;

@end

@implementation PhotoDataProvider

#pragma mark Pirvate methods

- (void)createPhotos
{
    self.photos = [NSMutableArray array];
    
    NSError *fetchErorr = nil;
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    NSArray *photos = [[CoreDataManager sharedManager].managedObjectContext executeFetchRequest:fetchReq error:&fetchErorr];
    if(fetchErorr)
    {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, fetchErorr.localizedDescription);
    }

    for(Photo *photo in photos)
    {
        [self.photos addObject:[PhotoItem itemWithImage:[UIImage imageWithData:photo.imageData] createAt:photo.createAt]];
    }
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%li.jpg", (long)index]];
}

- (NSArray *)selectedPhotos
{
    return [self.photos filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isSelected == YES"]];
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

- (void)addPhoto:(UIImage *)image
{
    PhotoItem *item = [PhotoItem itemWithImage:image createAt:[NSDate date]];
    [self.photos addObject:item];
    
    [CoreDataManager sharedManager];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
    {
        Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[CoreDataManager sharedManager].backgroundContext];
        
        NSData *imageData = UIImageJPEGRepresentation(item.image, 1.0f);
        photo.imageData = imageData;
        photo.createAt = item.createAt;
        
        [[CoreDataManager sharedManager] saveBackgroundContext];
    });
}

- (NSArray *)selectedPhotosIndexPaths
{
    NSArray *photos = [self selectedPhotos];
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for(PhotoItem *item in photos)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:[self.photos indexOfObject:item] inSection:0]];
    }
    
    return indexPaths;
}

- (void)removeSelectedPhotos
{
    NSArray *selectedPhotos = [self.photos filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isSelected == YES"]];
    if(selectedPhotos.count == 0)
    {
        NSAssert(NO, @"selected photos count == 0");
    }

    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    for(PhotoItem *item in selectedPhotos)
    {
        fetchReq.predicate = [NSPredicate predicateWithFormat:@"createAt == %@", item.createAt];
        NSArray *fetchedItems = [[CoreDataManager sharedManager].managedObjectContext executeFetchRequest:fetchReq error:NULL];
        [[[CoreDataManager sharedManager] managedObjectContext] deleteObject:[fetchedItems firstObject]];
    }
    
    [self.photos removeObjectsInArray:selectedPhotos];
    [[CoreDataManager sharedManager] saveMainContext];
}

@end
