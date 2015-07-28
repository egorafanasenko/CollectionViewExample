//
//  CoreDataManager.h
//  CollectionExample
//
//  Created by Alexandr on 28.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property(nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong, readonly) NSManagedObjectContext *backgroundContext;

+ (instancetype)sharedManager;
- (void)saveMainContext;
- (void)saveBackgroundContext;

@end
