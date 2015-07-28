//
//  PhotoCell.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoItem.h"

@interface PhotoCell()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation PhotoCell

#pragma mark Private methods

- (void)createPhotoImageView
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
}

- (void)createMaskView
{
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[
        (id)[UIColor colorWithWhite:1.0f alpha:0.0f].CGColor,
        (id)[UIColor colorWithWhite:1.0f alpha:0.5f].CGColor,
        (id)[UIColor whiteColor].CGColor,
    ];
    self.gradientLayer.locations = @[
        @(0.0f),
        @(0.0f),
        @(0.7f)
    ];
    
    [self.imageView.layer insertSublayer:self.gradientLayer atIndex:0];
}

#pragma mark UICollectionViewCell method

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createPhotoImageView];
        [self createMaskView];
        self.gradientLayer.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
    }
    return self;
}

#pragma mark Interface methods

- (void)configureWithItem:(PhotoItem *)item
{
    self.imageView.image = item.image;
    
    self.gradientLayer.hidden = !item.isSelected;
}

@end
