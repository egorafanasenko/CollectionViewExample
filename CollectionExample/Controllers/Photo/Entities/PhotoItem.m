//
//  PhotoItem.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoItem.h"

@interface PhotoItem ()

@property(nonatomic, strong, readwrite) UIImage *image;
@property(nonatomic, strong, readwrite) NSDate *createAt;

@end

@implementation PhotoItem

#pragma mark Private methods

- (instancetype)initWithImage:(UIImage *)image createAt:(NSDate *)date
{
    self = [super init];
    if(self)
    {
        self.image = image;
        self.createAt = date;
    }
    return self;
}

#pragma mark Inteface methods

+ (PhotoItem *)itemWithImage:(UIImage *)image createAt:(NSDate *)date
{
    return [[PhotoItem alloc] initWithImage:image createAt:(NSDate *)date];
}

@end
