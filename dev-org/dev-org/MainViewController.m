//
//  MainViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "MainViewController.h"
#import "Developer.h"
#import "Organization.h"

@interface MainViewController ()

@property (strong, nonatomic) User *user;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkUserStatus];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkUserStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [userDefaults objectForKey:@"user"];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  
    if (!self.user) {
        NSLog(@"No user found!");
    } else {
        NSLog(@"User ID is: %@", self.user.userID);
        NSLog(@"Developer: %hhu", self.user.isDev);
        
        NSLog(@"%@", self.user.description);
        
        if (self.user.isDev) {
            NSLog(@"I'm a developer!");
            Developer *nowDev = (Developer *)self.user;
            [self performSegueWithIdentifier:@"showDevStoryboard" sender:self];
        } else {
            NSLog(@"I'm an organization!");
            Organization *nowOrg = (Organization *)self.user;
            [self performSegueWithIdentifier:@"showOrgStoryboard" sender:self];
        }
    }
    
}

- (IBAction)delete:(UIBarButtonItem *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUser {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (IBAction)createDev:(UIButton *)sender {
    Developer *newDev = [[Developer alloc] init];
    
    newDev.userID = @"devID";
    newDev.isDev = YES;
    newDev.username = @"MrDeveloper";
    newDev. email = @"dev@aol.com";
    newDev.address = @"2510 S 12th St";
    newDev.city = @"Seattle";
    newDev.state = @"WA";
    newDev.phone = @"206-555-1212";
    newDev.profilePic = @"image.jpg";
    newDev.websites = @[@"github.com", @"devsite.com"];
    newDev.languages = [NSArray arrayWithObjects: @"Objective-C", @"Esperanto", nil];
    newDev.services=[NSArray arrayWithObjects:@"full stack", @"iOS", @"Android", nil];
    newDev.isAvailable=YES;
    newDev.radius=@"10 miles";
    
    self.user  = newDev;
    [self saveUser];
}

- (IBAction)createOrg:(UIButton *)sender {
    Organization *newOrg = [[Organization alloc ]init];
    
    newOrg.userID = @"orgID";
    newOrg.isDev = NO;
    newOrg.username = @"MrNPO";
    newOrg.email = @"npo@msn";
    newOrg.address = @"2512 S 12th St";
    newOrg.city = @"Seattle";
    newOrg.state = @"WA";
    newOrg.phone = @"206-555-1212";
    newOrg.profilePic = @"image.jpg";
    newOrg.websites = @[@"github.com", @"devsite.com"];
    newOrg.org = @"We are a legitimate charity.";
    
    self.user = newOrg;
    [self saveUser];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
