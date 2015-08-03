//
//  CoreDataManager.m
//  CollectionExample
//
//  Created by Alexandr on 28.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property(nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

#pragma mark CoreData

- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext)
    {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Photos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Photos.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self managedObjectContext];
    }
    return self;
}

#pragma mark Interface methods

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static CoreDataManager *sharedManager;
    dispatch_once(&once, ^
    {
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)saveMainContext
{
    __block NSError *error = nil;
    [self.managedObjectContext performBlock:^
     {
         if(![self.managedObjectContext save:&error])
         {
             NSLog(@"error %@", error.localizedDescription);
         }
     }];
}

- (void)saveContext:(NSManagedObjectContext *)context
{
    [context performBlock:^
     {
         NSError *currentContextError = nil;
         if(![context save:&currentContextError])
         {
             NSLog(@"current context error %@", currentContextError.localizedDescription);
         }
         [context.parentContext performBlock:^
         {
             NSError *mainContextError = nil;
             if(![context.parentContext save:&mainContextError])
             {
                 NSLog(@"main context error %@", mainContextError.localizedDescription);
             }
         }];
     }];
}

@end
