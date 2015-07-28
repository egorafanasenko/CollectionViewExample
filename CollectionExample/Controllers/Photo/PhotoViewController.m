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
    UICollectionViewDelegateFlowLayout,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property(nonatomic, strong) PhotoDataProvider *dataProvider;

@end

@implementation PhotoViewController
@dynamic view;

#pragma mark Private methods

- (void)onAddButtonClick:(UIButton *)button
{
    [self createImagePicker];
}

- (void)onRemovePhotosButtonClock:(UIButton *)button
{
    NSArray *indexPaths = [self.dataProvider selectedPhotosIndexPaths];
    [self.dataProvider removeSelectedPhotos];
    [self.view.collectionView deleteItemsAtIndexPaths:indexPaths];
}

- (void)createImagePicker
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
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

#pragma mark UIImagePickerControllerDelegate protocol methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo = info[UIImagePickerControllerOriginalImage];
    
    [self.dataProvider addPhoto:photo];
    NSIndexPath *photoPath = [NSIndexPath indexPathForRow:[self.dataProvider numberOfRowsInSection:0] - 1 inSection:0];
    [self.view.collectionView insertItemsAtIndexPaths:@[photoPath]];
    [self.view.collectionView scrollToItemAtIndexPath:photoPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    
    [self.view.removePhotosButton setTitle:@"Remove" forState:UIControlStateNormal];
    
    [self.view.addButton addTarget:self action:@selector(onAddButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.removePhotosButton addTarget:self action:@selector(onRemovePhotosButtonClock:) forControlEvents:UIControlEventTouchUpInside];
    
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
