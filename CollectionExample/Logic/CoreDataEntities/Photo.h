//
//  Photo.h
//  CollectionExample
//
//  Created by Alexandr on 28.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSDate * createAt;

@end
