//
//  PhotoItem.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

#pragma mark Private methods

- (instancetype)initWithSmallImage:(UIImage *)smallImage
{
    self = [super init];
    if(self)
    {
        self.smallImage = smallImage;
    }
    return self;
}

#pragma mark Inteface methods

+ (PhotoItem *)itemWithSmallImage:(UIImage *)smallImage
{
    return [[PhotoItem alloc] initWithSmallImage:smallImage];
}

@end
