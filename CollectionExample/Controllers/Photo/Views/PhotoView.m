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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_addButton]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_addButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_collectionView]-8-[_addButton]-8-|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView, _addButton)]];
}

#pragma mark UIView methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self createCollectionView];
        [self createAddButton];
    }
    return self;
}

@end
