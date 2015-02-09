//
//  HomeTableViewCell.h
//  instagram
//
//  Created by Don Wettasinghe on 2/8/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLable;

@end
