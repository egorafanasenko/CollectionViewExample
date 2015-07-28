//
//  PhotoViewController.h
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@class PhotoDataProvider;

@interface PhotoViewController : UIViewController

@property(nonatomic, strong) PhotoView *view;

- (instancetype)initWithDataProvider:(PhotoDataProvider *)dataProvider;

- (instancetype)init __attribute__((unavailable("Deprecated")));
@end
