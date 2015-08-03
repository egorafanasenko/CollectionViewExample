//
//  PhotoItem.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NYTPhoto.h"

@interface PhotoItem : NSObject
<
    NYTPhoto
>

@property(nonatomic, strong, readonly) UIImage *smallImage;
@property(nonatomic, strong, readonly) UIImage *largeImage;
@property(nonatomic, strong, readonly) NSDate *createAt;
@property(nonatomic, assign) BOOL isSelected;

+ (PhotoItem *)itemWithLargeImage:(UIImage *)largeImage smallImage:(UIImage *)smaillImage createAt:(NSDate *)date;

@end
