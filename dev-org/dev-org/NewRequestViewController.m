//
//  NewRequestViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "NewRequestViewController.h"
#import "Project.h"

@interface NewRequestViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *projectTypePicker;
@property (weak, nonatomic) IBOutlet UITextView *projectDescription;

@property (strong, nonatomic) NSArray *projectTypes;

@end

@implementation NewRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.projectTypePicker.dataSource = self;
    self.projectTypePicker.delegate = self;
    self.projectTypes = @[@"Website", @"iOS App", @"Android App"];
    
    [self.projectTypePicker selectRow:0 inComponent:0 animated:NO];
    self.projectDescription.layer.borderWidth = 2.0;
    self.projectDescription.layer.cornerRadius = 8.0;
    self.projectDescription.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (IBAction)submitPressed:(UIButton *)sender {
    Project *newProject = [[Project alloc] init];
    newProject.service = self.projectTypes[[self.projectTypePicker selectedRowInComponent:0]];
    newProject.projectDescription = self.projectDescription.text;
    if (self.developer) {
       newProject.devs = [[NSArray alloc] initWithObjects:self.developer, nil];
    }
    NSLog(@"Project type: %@", newProject.service);
    NSLog(@"Project description: %@", newProject.projectDescription);
    NSLog(@"Project developers: %@", newProject.devs);
    
    
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
