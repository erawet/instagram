//
//  CameraViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/6/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "CameraViewController.h"
#import <Parse/Parse.h>
#import "Utility.h"

@interface CameraViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UITextField *imageTitle;
@property (weak, nonatomic) IBOutlet UITextField *imageTag;
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager=[[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self actionViewShow];
}

- (IBAction)saveData:(id)sender {

    PFObject *dataObjects=[PFObject objectWithClassName:@"MyImages"];
    [dataObjects setObject:self.comment.text forKey:@"comment"];
    [dataObjects setObject:self.imageTag.text forKey:@"imageTag"];
    CLLocationCoordinate2D cordinates=[self getLocation];
    PFGeoPoint *point=[PFGeoPoint geoPointWithLatitude:cordinates.latitude longitude:cordinates.longitude];
    [dataObjects setObject:point forKey:@"location"];
    
    //get user ID
    NSUserDefaults *userEmail=[NSUserDefaults standardUserDefaults];
    [dataObjects setObject:[userEmail stringForKey:@"email"] forKey:@"email"];
    
    //Prepare image to save
    NSData *imageData=UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile=[PFFile fileWithName:@"image.png" data:imageData];
    [dataObjects setObject:self.imageTitle.text  forKey:@"imageName"];
    [dataObjects setObject:imageFile  forKey:@"imageFile"];
    
    [dataObjects saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self alertMessage:@"Successfilly Save" messageTitle:@"Success!!"];
        }else{
            [self alertMessage:@"Data not saved. Please tey again" messageTitle:@"Error!!"];
        }
    }];
    
}

-(void)alertMessage:(NSString*)message messageTitle:(NSString *)title{
    
    UIAlertView *alertmessage=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertmessage show];
}


- (IBAction)detectPictureLocation:(UIButton *)sender {
    
    CLLocationCoordinate2D cordinates=[self getLocation];
    self.latitudeLabel.text=[NSString stringWithFormat:@"%f", cordinates.latitude];
    self.longitudeLabel.text=[NSString stringWithFormat:@"%f", cordinates.longitude];
}

-(CLLocationCoordinate2D) getLocation{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}


-(void)actionViewShow{
    UIActionSheet *actions=[UIActionSheet new];
    actions.delegate = self;
    
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2) {
        return;
    }
    
    NSString* title;
    UIImagePickerControllerSourceType source;
    if (buttonIndex == 2 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // if library is available, it's first index
        title = NSLocalizedString(@"Choose Photo", nil);
        source = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        // otherwise open camera
        title = NSLocalizedString(@"Take Photo", nil);
        source = UIImagePickerControllerSourceTypeCamera;
    }
    
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
    
   // UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    // use utility methos to resize the image
    UIImage *sizeImage=[Utility imageWithImage:[info objectForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(380, 350)];
    [self.imageView setImage:sizeImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
