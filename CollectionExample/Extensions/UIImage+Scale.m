//
//  UIImage+Scale.m
//  CollectionExample
//
//  Created by Alexandr on 29.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

#pragma mark Private methods

void UIGraphicsBeginImageContextExt(CGSize size)
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        CGFloat tmp = [UIScreen mainScreen].scale;
        if(tmp > 1.5)
        {
            scale = 2.0;
        }
    }
    if(scale > 1.5)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
}

#pragma mark Interface methods

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if(!CGSizeEqualToSize(imageSize, targetSize))
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContextExt(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
