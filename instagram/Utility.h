//
//  Utility.h
//  instagram
//
//  Created by Don Wettasinghe on 2/8/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Utility : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
