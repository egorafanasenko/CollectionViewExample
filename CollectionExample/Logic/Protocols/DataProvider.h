//
//  DataProvider.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProvider <NSObject>

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (id)objectForIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSIndexPath *)indexPathForObject:(id)object;

@end
