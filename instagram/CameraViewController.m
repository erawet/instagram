//
//  CameraViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/6/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [self actionViewShow];
}

-(void)actionViewShow{
    UIActionSheet *actions=[UIActionSheet new];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [actions addButtonWithTitle:NSLocalizedString(@"Choose Photo or Video", nil)];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actions addButtonWithTitle:NSLocalizedString(@"Take Photo or Video", nil)];
    }
    
    actions.cancelButtonIndex = [actions addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    [actions showInView:self.view.window];
}

- (IBAction)reTakePicture:(id)sender {
    [self actionViewShow];
}

-(void)presentMediaPickerForSource:(UIImagePickerControllerSourceType)source withTitle:(NSString *)title{
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.sourceType=source;
    picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:source];
    [picker setTitle:title];
    
    picker.videoQuality=UIImagePickerControllerQualityTypeMedium;
    picker.videoMaximumDuration=90;
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
