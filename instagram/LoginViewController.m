//
//  LoginViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/4/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmPassword.hidden=true;
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    
    
    
    
}
- (IBAction)onLoginPress:(UIButton *)sender {
    
}
- (IBAction)onSignUpPress:(UIButton *)sender {
    self.confirmPassword.hidden=false;
    
    PFUser *newUser=[PFUser user];
    newUser.username=self.email.text;
    
    if ([self.password.text isEqualToString:self.confirmPassword.text]) {
        newUser.password=self.confirmPassword.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self performSegueWithIdentifier:@"goToTabBar" sender:self];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                // Show the errorString somewhere and let the user try again.
            }
        }];

    } else{
        UIAlertView *alertmessage=[[UIAlertView alloc]initWithTitle:@"Warning!!" message:@"Password does not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertmessage show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
