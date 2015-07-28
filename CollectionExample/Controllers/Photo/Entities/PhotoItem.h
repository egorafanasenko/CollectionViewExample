//
//  PhotoItem.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PhotoItem : NSObject

@property(nonatomic, strong, readonly) UIImage *image;
@property(nonatomic, strong, readonly) NSDate *createAt;
@property(nonatomic, assign) BOOL isSelected;

+ (PhotoItem *)itemWithImage:(UIImage *)image createAt:(NSDate *)date;

@end
