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

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *developerSwitch;

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
- (IBAction)resetUser:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUser {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)userSignUpWithEmail:(NSString*)email username:(NSString*)username password:(NSString*)password isDev:(Boolean)isDev {
    
    User *newUser = [[User alloc] init];
        newUser.username = username;
        newUser.email = email;
    newUser.password = password;
        newUser.isDev = isDev;
        self.user = newUser;
    
    __weak typeof(self) bruce = self;
    [JSAPIPOSTRequest postUser:self.user withCompletion:^(NSString *identifier) {
        __strong typeof(bruce) hulk = bruce;
        
        // Remove quotation marks from string before assigning to user
        hulk.user.userToken = [identifier componentsSeparatedByString:@"\""][1];
        
        
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
    [self userSignUpWithEmail:self.emailTextField.text username:self.usernameTextField.text password:self.passwordTextField.text isDev:self.developerSwitch.isOn];
    self.view = self.defaultView;
}

- (IBAction)cancelSignUpPressed:(UIButton *)sender {
    self.view = self.defaultView;
}


- (IBAction)createDev:(UIButton *)sender {
//    [self userSignUp];
}

-(void)createDeveloper{
    [self saveUser];
    
    Developer *newDev = [[Developer alloc] init];
    
    newDev.userToken = self.user.userToken;
    newDev.isDev = YES;
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
        
        [hulk saveUser];
    }];
    
}

- (IBAction)createOrg:(UIButton *)sender {
//    [self userSignUp];
}

-(void)createOrganization{

    Organization *newOrg = [[Organization alloc ]init];
    
    newOrg.userToken = self.user.userToken;
    newOrg.isDev = NO;
//    newOrg.address = @"2512 S 12th St";
    newOrg.city = @"Seattle";
    newOrg.state = @"WA";
    newOrg.phone = @"206-555-1212";
    newOrg.profilePic = @"image.jpg";
    newOrg.websites = @[@"github.com", @"devsite.com"];
    newOrg.org = @"We are a legitimate charity.";
    
    self.user = newOrg;

    __weak typeof(self) bruce = self;
    [JSAPIPOSTRequest postNPO:newOrg withCompletion:^(NSDictionary *orgDictionary) {
        __strong typeof(bruce) hulk = bruce;
        
        NSString *userID = [orgDictionary valueForKey:@"userID"];
        [hulk.user setValue:userID forKey:@"userID"];
        
        NSString *orgID = [orgDictionary valueForKey:@"_id"];
        [hulk.user setValue:orgID forKey:@"orgID"];
        
        NSString *username = [newOrg valueForKey:@"username"];
        [hulk.user setValue:username forKey:@"username"];
        
        NSString *email = [newOrg valueForKey:@"email"];
        [hulk.user setValue:email forKey:@"email"];
        
        [hulk saveUser];
    }];

}

@end
