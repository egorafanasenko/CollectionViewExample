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
#import "NYTPhotosViewController.h"

static NSString *const PhotoCellIdentifier = @"PhotoCellIdentifier";

typedef NS_ENUM(NSUInteger, PhotoState)
{
    PhotoStateDefault = 0,
    PhotoStateEdited
};

@interface PhotoViewController()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property(nonatomic, strong) PhotoDataProvider *dataProvider;

@property(nonatomic, assign) PhotoState state;

@end

@implementation PhotoViewController
@dynamic view;

#pragma mark Private methods

- (void)onEditedButtonClick:(UIButton *)button
{
    switch(self.state)
    {
        case PhotoStateDefault:
            self.state = PhotoStateEdited;
            break;
            
        case PhotoStateEdited:
            self.state = PhotoStateDefault;
            break;
            
        default:
            NSAssert(@"NO", @"unknwon state %li", (long)self.state);
            break;
    }
}

- (void)onAddButtonClick:(UIButton *)button
{
    [self createImagePicker];
}

- (void)onRemovePhotosButtonClock:(UIButton *)button
{
    NSArray *indexPaths = [self.dataProvider selectedPhotosIndexPaths];
    if(indexPaths.count > 0)
    {
        [self.dataProvider removeSelectedPhotos];
        [self.view.collectionView deleteItemsAtIndexPaths:indexPaths];
    }
}

- (void)createImagePicker
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)createPhotosViewControllerWithInitialPhotoIndexPath:(NSIndexPath *)initialPhotoPath
{
    NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:[self.dataProvider largeImages] initialPhoto:[self.dataProvider objectForIndexPath:initialPhotoPath]];
    
    [self presentViewController:photosViewController animated:YES completion:nil];
}

#pragma mark Setters

- (void)setState:(PhotoState)state
{
    _state = state;
    
    switch(state)
    {
        case PhotoStateDefault:
            self.view.removePhotosButton.highlighted = YES;
            [self.view.editedButton setTitle:@"Edited" forState:UIControlStateNormal];
            break;
            
        case PhotoStateEdited:
            self.view.removePhotosButton.highlighted = NO;
            [self.view.editedButton setTitle:@"Default" forState:UIControlStateNormal];
            break;
            
        default:
            NSAssert(NO, @"unknown state %li", (long)state);
            break;
    }
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
    switch (self.state)
    {
        case PhotoStateDefault:
        {
            [self createPhotosViewControllerWithInitialPhotoIndexPath:indexPath];
        }
        break;
            
        case PhotoStateEdited:
        {
            PhotoItem *item = [self.dataProvider objectForIndexPath:indexPath];
            item.isSelected = !item.isSelected;
            [self.view.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
        break;
            
        default:
            NSAssert(NO, @"unknown photo state %li", (long)self.state);
            break;
    }
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
    
    CGFloat photoItemWidth = ((CGRectGetWidth(self.view.frame) / 3.0f) - 1.0f) * 2.0f;
    [self.dataProvider addPhoto:photo withScale:CGSizeMake(photoItemWidth, photoItemWidth)];
    NSIndexPath *photoPath = [NSIndexPath indexPathForRow:[self.dataProvider numberOfRowsInSection:0] - 1 inSection:0];
    [self.view.collectionView insertItemsAtIndexPaths:@[photoPath]];
    [self.view.collectionView scrollToItemAtIndexPath:photoPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIViewController methods

- (void)loadView
{
    self.view = [[PhotoView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view.removePhotosButton setTitle:NSLocalizedString(@"Remove", nil) forState:UIControlStateNormal];
    [self.view.editedButton setTitle:NSLocalizedString(@"Edited", nil) forState:UIControlStateNormal];
    
    [self.view.editedButton addTarget:self action:@selector(onEditedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.addButton addTarget:self action:@selector(onAddButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.removePhotosButton addTarget:self action:@selector(onRemovePhotosButtonClock:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    
    self.view.collectionViewLayout.minimumLineSpacing = 2.0f;
    self.view.collectionViewLayout.minimumInteritemSpacing = 1.0f;
    self.view.collectionView.dataSource = self;
    self.view.collectionView.delegate = self;
    
    self.state = PhotoStateDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark Interface methods

- (instancetype)initWithDataProvider:(PhotoDataProvider *)dataProvider
{
    self = [super init];
    if(self)
    {
        self.dataProvider = dataProvider;
    }
    return self;
}

@end
