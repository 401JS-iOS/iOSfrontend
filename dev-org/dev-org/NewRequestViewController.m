//
//  NewRequestViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "NewRequestViewController.h"
#import "Project.h"
#import "JSAPI.h"
#import "JSAPIPOSTRequest.h"
@interface NewRequestViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) Project *project;

@property (weak, nonatomic) IBOutlet UIPickerView *projectTypePicker;
@property (weak, nonatomic) IBOutlet UITextView *projectDescription;

@property (strong, nonatomic) NSArray *projectTypes;

@end

@implementation NewRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    self.projectTypePicker.dataSource = self;
    self.projectTypePicker.delegate = self;
    self.projectTypes = @[@"Website", @"iOS App", @"Android App"];
    
    [self.projectTypePicker selectRow:0 inComponent:0 animated:NO];
    self.projectDescription.layer.borderWidth = 2.0;
    self.projectDescription.layer.cornerRadius = 8.0;
    self.projectDescription.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)hideKeyBoard {
    [self.projectDescription resignFirstResponder];
}

- (IBAction)submitPressed:(UIButton *)sender {
    
  
    Project *newProject = [[Project alloc] init];
    newProject.service = self.projectTypes[[self.projectTypePicker selectedRowInComponent:0]];
    newProject.projectDescription = self.projectDescription.text;
    newProject.orgID = self.organization.orgID;
    
    if (self.developer) {
        newProject.dev = [NSString stringWithFormat:@"%@", self.developer.devID];
    }
    
//    [self.organization.projects addObject:newProject];
    
    NSLog(@"Project type: %@", newProject.service);
    NSLog(@"Project description: %@", newProject.projectDescription);
    __weak typeof(self) bruce = self;
    
    
    NSString *token = [NSString stringWithFormat: @"Bearer %@", self.organization.userToken];
    
    [JSAPIPOSTRequest postProject:newProject withToken:token andCompletion:^(NSDictionary *project)  {
    __strong typeof(bruce) hulk = bruce;
        
//        NSString *userID = [orgDictionary valueForKey:@"userID"];
//        [hulk.user setValue:userID forKey:@"userID"];
//        
//        NSString *orgID = [orgDictionary valueForKey:@"_id"];
//        [hulk.user setValue:orgID forKey:@"orgID"];
//        
//        NSString *username = [newOrg valueForKey:@"username"];
//        [hulk.user setValue:username forKey:@"username"];
//        
//        NSString *email = [newOrg valueForKey:@"email"];
//        [hulk.user setValue:email forKey:@"email"];
//        
        
    }];

///////////////////////////////
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.projectTypes.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.projectTypes[row];
}



@end
