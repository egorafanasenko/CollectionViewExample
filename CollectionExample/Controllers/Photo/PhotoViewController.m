//
//  PhotoViewController.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "PhotoDataProvider.h"

static NSString *const PhotoCellIdentifier = @"PhotoCellIdentifier";

@interface PhotoViewController()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property(nonatomic, strong) PhotoDataProvider *dataProvider;

@end

@implementation PhotoViewController
@dynamic view;

#pragma mark Private methods

- (void)onAddButtonClick:(UIButton *)button
{
    [self.dataProvider addRandomItem];
    NSIndexPath *itemPath = [NSIndexPath indexPathForRow:[self.dataProvider numberOfRowsInSection:1] - 1  inSection:0];
    [self.view.collectionView insertItemsAtIndexPaths:@[itemPath]];
    [self.view.collectionView scrollToItemAtIndexPath:itemPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark UICollectionViewDataSourceProtocol methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataProvider numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [self.view.collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    [cell configureWithItem:[self.dataProvider objectForIndexPath:indexPath]];
    return cell;
}

#pragma mark UICollectionViewDelegateProtocol methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoItem *item = [self.dataProvider objectForIndexPath:indexPath];
    item.isSelected = !item.isSelected;
    [self.view.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark UICollectionViewDelegateFlowLayout protocl methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (CGRectGetWidth(self.view.frame) / 3.0f) - 1.0f;
    return CGSizeMake(width, width);
}

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.dataProvider = [[PhotoDataProvider alloc] init];
    }
    return self;
}

#pragma mark UIViewController methods

- (void)loadView
{
    self.view = [[PhotoView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view.addButton addTarget:self action:@selector(onAddButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    
    self.view.collectionViewLayout.minimumLineSpacing = 2.0f;
    self.view.collectionViewLayout.minimumInteritemSpacing = 1.0f;
    self.view.collectionView.dataSource = self;
    self.view.collectionView.delegate = self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
