//
//  PhotoView.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoView.h"

@interface PhotoView()

@property(nonatomic, strong, readwrite) UICollectionView *collectionView;
@property(nonatomic, strong, readwrite) UICollectionViewFlowLayout *collectionViewLayout;
@property(nonatomic, strong, readwrite) UIButton *addButton;
@property(nonatomic, strong, readwrite) UIButton *removePhotosButton;

@end

@implementation PhotoView

#pragma mark Private methods

- (void)createCollectionView
{
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.collectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:(NSLayoutFormatOptions)0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]" options:(NSLayoutFormatOptions)0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
}

- (void)createAddButton
{
    self.addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.addButton];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_collectionView]-8-[_addButton]-8-|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView, _addButton)]];
}

- (void)createRemovePhotosButton
{
    self.removePhotosButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.removePhotosButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.removePhotosButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_removePhotosButton]-8-|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_removePhotosButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_removePhotosButton]-<=0-|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_removePhotosButton)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.removePhotosButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.addButton attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
}

#pragma mark UIView methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self createCollectionView];
        [self createAddButton];
        [self createRemovePhotosButton];
    }
    return self;
}

@end
