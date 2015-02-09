//
//  ImageDetailViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/9/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (weak, nonatomic) IBOutlet UIButton *onTapLike;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageDetail.image=[self.imageObject objectForKey:@"imageFile"];
    //self.likesLabel.text=[self.dataDict objectForKey:@"likes"];
}

- (IBAction)onCancelPress:(UIBarButtonItem *)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)onSaveTap:(id)sender {
    
    
    
}

@end
