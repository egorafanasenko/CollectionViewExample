//
//  PhotoCell.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItem.h"

@interface PhotoCell : UICollectionViewCell

- (void)configureWithItem:(PhotoItem *)item;

@end
