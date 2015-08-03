//
//  PhotoDataProvider.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DataProvider.h"

@interface PhotoDataProvider : NSObject
<
    DataProvider
>

- (void)addPhoto:(UIImage *)image withScale:(CGSize)scaleSize;

- (NSArray *)selectedPhotosIndexPaths;
- (void)removeSelectedPhotos;

- (NSArray *)largeImages;

@end
