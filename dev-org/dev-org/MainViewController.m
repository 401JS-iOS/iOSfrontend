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
#import "OrgHomeViewController.h"
#import "JSAPI.h"

@interface MainViewController ()

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Organization *org;
@property (strong, nonatomic) UIView *defaultView;

@property (weak, nonatomic) IBOutlet UITextField *loginUsername;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *userTypeControl;

@property (weak, nonatomic) IBOutlet UIView *devSubView;
@property (weak, nonatomic) IBOutlet UISwitch *devIsAvailable;
@property (weak, nonatomic) IBOutlet UITextField *devServicesTextField;

@property (weak, nonatomic) IBOutlet UIView *orgSubView;
@property (weak, nonatomic) IBOutlet UITextField *orgNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *orgDescriptionTextView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkUserStatus];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)hideKeyBoard {
    [self.loginUsername resignFirstResponder];
    [self.loginPassword resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.stateTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.websiteTextField resignFirstResponder];
    [self.devServicesTextField resignFirstResponder];
    [self.orgNameTextField resignFirstResponder];
    [self.orgDescriptionTextView resignFirstResponder];
}
- (void)checkUserStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSData *data = [userDefaults objectForKey:@"user"];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"disk user token: %@", self.user.userToken);
    if (!self.user) {
        NSLog(@"No user found!");
    } else {
        NSLog(@"User ID is: %@", self.user.userID);
        NSLog(@"Developer: %hhu", self.user.isDev);

        NSLog(@"%@", self.user.description);

        if (self.user.isDev) {
            NSLog(@"I'm a developer!");
//            Developer *nowDev = (Developer *)self.user;
            [self performSegueWithIdentifier:@"showDevStoryboard" sender:nil];
        } else {
            NSLog(@"I'm an organization!");
            self.org = (Organization *)self.user;
            [self performSegueWithIdentifier:@"showOrgStoryboard" sender:nil];
        }
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"showOrgStoryboard"]) {
        OrgHomeViewController *orgVC = segue.destinationViewController.childViewControllers[0];
        NSLog(@"OrgHome token: %@",self.org.userToken);
//        NSLog(@"OrgHome orgID: %@",self.org.orgID);

        orgVC.org = self.org;
    } else {

    }
}

- (IBAction)loginPressed:(UIButton *)sender {
    self.user = [[User alloc] init];
    __weak typeof(self) bruce = self;

    [JSAPI signInWithUsername:(NSString*)self.loginUsername.text password:(NSString*)self.loginPassword.text andCompletion:^(NSString *identifier) {
        __strong typeof(bruce) hulk = bruce;

        // Remove quotation marks from string before assigning to user
        hulk.user.userToken = [identifier componentsSeparatedByString:@"\""][1];
        NSLog(@"testing login");
        [hulk saveUser];
    }];
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
    [self.navigationController setNavigationBarHidden:YES];
    self.view = signUpView;
    [self.userTypeControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
    CALayer *descriptionLayer = self.orgDescriptionTextView.layer;

    descriptionLayer.borderWidth = 0.5;
    descriptionLayer.cornerRadius = 5;
    descriptionLayer.borderColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.0].CGColor;

    [self.userTypeControl addTarget:self action:@selector(userTypeChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)userTypeChanged {
    if (self.userTypeControl.selectedSegmentIndex == 0) {
        [self.devSubView setHidden:NO];
        [self.orgSubView setHidden:YES];
    } else {
        [self.devSubView setHidden:YES];
        [self.orgSubView setHidden:NO];
    }
}

- (IBAction)createAccountPressed:(UIButton *)sender {

    BOOL isDev;
    if (self.userTypeControl.selectedSegmentIndex == 0) {
        isDev = YES;
    } else {
        isDev = NO;
    }
    NSLog(@"Developer: %hhu", isDev);
    [self userSignUpWithEmail:self.emailTextField.text username:self.usernameTextField.text password:self.passwordTextField.text isDev:isDev];
}

- (IBAction)cancelSignUpPressed:(UIButton *)sender {
    [self.userTypeControl removeTarget:self action:@selector(userTypeChanged) forControlEvents:UIControlEventValueChanged];
    self.view = self.defaultView;
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)createDeveloper{
    [self saveUser];

    Developer *newDev = [[Developer alloc] init];

    newDev.userToken = self.user.userToken;
    newDev.isDev = YES;
    newDev.city = self.cityTextField.text;
    newDev.state = self.stateTextField.text;
    newDev.phone = self.phoneTextField.text;
//    newDev.profilePic = @"image.jpg";
    newDev.websites = [NSArray arrayWithObject:self.websiteTextField.text];
//    newDev.languages = [NSArray arrayWithObjects: @"Objective-C", @"Esperanto", nil];
    newDev.services=[NSArray arrayWithObject:self.devServicesTextField.text];
    newDev.isAvailable=self.devIsAvailable.isOn;
    newDev.username = self.user.username;
//    newDev.radius=@"10 miles";

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
        [hulk.userTypeControl removeTarget:hulk action:@selector(userTypeChanged) forControlEvents:UIControlEventValueChanged];
        hulk.view = hulk.defaultView;
        [hulk.navigationController setNavigationBarHidden:NO];
        [hulk checkUserStatus];
    }];

}

-(void)createOrganization{

    self.org = [[Organization alloc] init];
    self.org.userToken = self.user.userToken;
    self.org.isDev = NO;
    self.org.city = self.cityTextField.text;
    self.org.state = self.stateTextField.text;
    self.org.phone = self.phoneTextField.text;
//    newOrg.profilePic = @"image.jpg";
    self.org.websites = [NSArray arrayWithObject:self.websiteTextField.text];
    self.org.org = self.orgNameTextField.text;
    self.org.orgDesc = self.orgDescriptionTextView.text;

    self.user = self.org;

//    __weak typeof(self) bruce = self;
    [JSAPIPOSTRequest postNPO:self.org withCompletion:^(NSDictionary *orgDictionary) {
//        __strong typeof(bruce) hulk = bruce;
        NSLog(@"dict: %@",orgDictionary);
        self.user.userID = orgDictionary[@"userID"];
        self.org.orgID = orgDictionary[@"_id"];
        self.user.username = orgDictionary[@"username"];
        self.user.email = orgDictionary[@"email"];
        [self saveUser];
        [self.navigationController setNavigationBarHidden:NO];
        [self checkUserStatus];
//        [hulk.userTypeControl removeTarget:hulk action:@selector(userTypeChanged) forControlEvents:UIControlEventValueChanged];
//        hulk.view = hulk.defaultView;
//        [hulk.navigationController setNavigationBarHidden:NO];
//        [hulk checkUserStatus];
    }];

}

@end
