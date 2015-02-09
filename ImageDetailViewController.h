//
//  ImageDetailViewController.h
//  instagram
//
//  Created by Don Wettasinghe on 2/9/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageDetailViewController : UIViewController

@property NSMutableDictionary *dataDict;

@property PFObject *imageObject;

@end
