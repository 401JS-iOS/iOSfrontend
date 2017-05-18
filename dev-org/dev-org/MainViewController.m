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
#import "JSAPIPOSTRequest.h"

@interface MainViewController ()

@property (strong, nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UITextField *loginUsername;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

@property (strong, nonatomic) UIView *defaultView;


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
        NSLog(@"Developer: %@", self.user.isDev);
        
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

-(void)userSignUp{
    User *newUser = [[User alloc] init];
        newUser.username = @"jay9";
        newUser.email = @"jay9@com";
        newUser.isDev = @1;
        newUser.password = @"1234";
        self.user = newUser;
    
    __weak typeof(self) bruce = self;
    [JSAPIPOSTRequest postUser:self.user withCompletion:^(NSString *identifier) {
        __strong typeof(bruce) hulk = bruce;
        hulk.user.userToken = identifier;
        
        if (hulk.user.isDev) {
            [hulk createDeveloper];
        } else {
            [hulk createOrganization];
        }
    }];
    
    
}

- (IBAction)showSignUpViewPressed:(UIButton *)sender {
    UIView *signUpView = [[[NSBundle mainBundle] loadNibNamed:@"SignUpView" owner:self options:nil] objectAtIndex:0];
    
    self.defaultView = self.view;
    self.view = signUpView;
}

- (IBAction)createAccountPressed:(UIButton *)sender {
    self.view = self.defaultView;
}

- (IBAction)cancelSignUpPressed:(UIButton *)sender {
    self.view = self.defaultView;
}


- (IBAction)createDev:(UIButton *)sender {
    [self userSignUp];
}

-(void)createDeveloper{
    [self saveUser];
    
    Developer *newDev = [[Developer alloc] init];
    
    newDev.userToken = self.user.userToken;
    newDev.isDev = @1;
    newDev.address = @"2510 S 12th St";
    newDev.city = @"Seattle";
    newDev.state = @"WA";
    newDev.phone = @"206-555-1212";
    newDev.profilePic = @"image.jpg";
    newDev.websites = [NSArray arrayWithObjects:@"github.com", @"devsite.com", nil];
    newDev.languages = [NSArray arrayWithObjects: @"Objective-C", @"Esperanto", nil];
    newDev.services=[NSArray arrayWithObjects:@"full stack", @"iOS", @"Android", nil];
    newDev.isAvailable=YES;
    newDev.radius=@"10 miles";
    
    self.user  = newDev;
    __weak typeof(self) bruce = self;
    [JSAPIPOSTRequest postDev:newDev withCompletion:^(NSDictionary *devDictionary) {
        __strong typeof(bruce) hulk = bruce;
        
        NSString *userID = [devDictionary valueForKey:@"userID"];
        [hulk.user setValue:userID forKey:@"userID"];
        
        NSString *devID = [devDictionary valueForKey:@"_id"];
        [hulk.user setValue:devID forKey:@"devID"];
        
        NSString *username = [devDictionary valueForKey:@"username"];
        [hulk.user setValue:username forKey:@"username"];
        
        NSString *email = [devDictionary valueForKey:@"email"];
        [hulk.user setValue:email forKey:@"email"];
        
        
        newDev.username = self.user.username;
        newDev.email = self.user.email;
        
        
        [hulk saveUser];
    }];
    
}

- (IBAction)createOrg:(UIButton *)sender {
    [self createOrganization];
    [self userSignUp];
}

-(void)createOrganization{

    Organization *newOrg = [[Organization alloc ]init];
    
    newOrg.userID = @"orgID";
    newOrg.isDev = @0;
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

}

@end
