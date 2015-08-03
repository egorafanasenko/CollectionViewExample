//
//  PhotoItem.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoItem.h"

@interface PhotoItem ()

@property(nonatomic, strong, readwrite) UIImage *smallImage;
@property(nonatomic, strong, readwrite) UIImage *largeImage;
@property(nonatomic, strong, readwrite) NSDate *createAt;

@end

@implementation PhotoItem
@synthesize image;
@synthesize placeholderImage;
@synthesize attributedCaptionCredit;
@synthesize attributedCaptionSummary;
@synthesize attributedCaptionTitle;

#pragma mark Private methods

- (instancetype)initWithLargeImage:(UIImage *)largeImage smallImage:(UIImage *)smaillImage createAt:(NSDate *)date
{
    self = [super init];
    if(self)
    {
        self.largeImage = largeImage;
        self.smallImage = smaillImage;
        self.createAt = date;
    }
    return self;
}

#pragma mark Inteface methods

+ (PhotoItem *)itemWithLargeImage:(UIImage *)largeImage smallImage:(UIImage *)smaillImage createAt:(NSDate *)date
{
    return [[PhotoItem alloc] initWithLargeImage:largeImage smallImage:smaillImage createAt:date];
}

#pragma mark Getters

- (UIImage *)image
{
    return self.largeImage;
}

- (UIImage *)placeholderImage
{
    return self.smallImage;
}

@end
