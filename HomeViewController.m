//
//  HomeViewController.m
//  instagram
//
//  Created by Don Wettasinghe on 2/3/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import <Parse/Parse.h>
#import "Utility.h"
#import "ImageDetailViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *imageArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.imageArray=[NSMutableArray new];
    self.tableView.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{
     [self queryImageArray];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.imageArray.count;
}

-(void)queryImageArray{
    
    //get user ID
    NSUserDefaults *userEmail=[NSUserDefaults standardUserDefaults];
    NSString *email=[userEmail stringForKey:@"email"];
  
    PFQuery *query = [PFQuery queryWithClassName:@"MyImages"];
    [query whereKey:@"email" equalTo:email];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %@ scores.", self.imageArray);
            
            self.imageArray=[[NSMutableArray alloc]initWithArray:objects];
            [self.tableView reloadData];
         
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell=(HomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *imageObject=[self.imageArray objectAtIndex:indexPath.row];
    PFFile *imageFile=[imageObject objectForKey:@"imageFile"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            cell.imageView.image=[Utility imageWithImage:[UIImage imageWithData:data] scaledToSize:CGSizeMake(265, 225)];
        }
    }];
    
    cell.imageTitleLabel.text=[imageObject objectForKey:@"imageName"];
    cell.likeLable.text=[NSString stringWithFormat:@"%@",[imageObject objectForKey:@"likes"]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
  //  NSIndexPath *indrxpath=[[self.tableView indexPathForSelectedRow].row];
    
     ImageDetailViewController *iDV=[segue destinationViewController];
    NSDictionary  *imageDict=[self.imageArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    
    if ([segue.identifier isEqualToString:@"goToImageDetail"]) {
        iDV.imageObject=[self.imageArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}


@end
