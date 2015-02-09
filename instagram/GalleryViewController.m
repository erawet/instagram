//
//  GalleryViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/8/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCollectionViewCell.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)queryImageList{
    
    PFQuery *imageQuery=[PFQuery queryWithClassName:@"MyImages"];
    [imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (!error) {
            self.imageList=[[NSMutableArray alloc]initWithArray:objects];
            [self.galleryCollection reloadData];
        }
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *cell
    GalleryCollectionViewCell *cell=(GalleryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
