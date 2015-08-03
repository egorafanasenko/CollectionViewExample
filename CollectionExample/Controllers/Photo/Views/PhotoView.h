//
//  PhotoView.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView

@property(nonatomic, strong, readonly) UICollectionView *collectionView;
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *collectionViewLayout;
@property(nonatomic, strong, readonly) UIButton *addButton;
@property(nonatomic, strong, readonly) UIButton *removePhotosButton;
@property(nonatomic, strong, readonly) UIButton *editedButton;

@end
