//
//  GalleryViewController.h
//  instagram
//
//  Created by Don Wettasinghe on 2/8/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCollectionViewCell.h"
#import  <Parse/Parse.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *galleryCollection;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSArray *imageFileArray;

@end
