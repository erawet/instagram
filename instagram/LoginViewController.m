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
    self.email.text=@"erawet@gmail.com";
    self.password.text=@"Password1";
    

    
}

- (IBAction)onLoginPress:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.email.text password:self.password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self saveUserDataLocally];
             [self performSegueWithIdentifier:@"goToTabBar" sender:self];
        }else{
             [self alertMessage:@"Invalied Password"];
             [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)onSignUpPress:(UIButton *)sender {
    self.confirmPassword.hidden=false;
    
    
    PFUser *newUser=[PFUser user];
    newUser.username=self.email.text;
    newUser.email=self.email.text;
    
    if ([self.password.text isEqualToString:self.confirmPassword.text]) {
        newUser.password=self.confirmPassword.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self saveUserDataLocally];
                [self performSegueWithIdentifier:@"goToTabBar" sender:self];
            } else {
                //NSString *errorString = [error userInfo][@"error"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else{
        [self alertMessage:@"Password does not match"];
    }
}

-(void)alertMessage:(NSString*)message{
    
    UIAlertView *alertmessage=[[UIAlertView alloc]initWithTitle:@"Error!!" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertmessage show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveUserDataLocally{
    
    NSUserDefaults *userEmail=[NSUserDefaults standardUserDefaults];
    [userEmail setObject:self.email.text forKey:@"email"];
    
}


@end
