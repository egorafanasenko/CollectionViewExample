//
//  UIImage+Scale.h
//  CollectionExample
//
//  Created by Alexandr on 29.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
