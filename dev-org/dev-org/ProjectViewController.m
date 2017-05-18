//
//  ProjectViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/17/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "ProjectViewController.h"
#import "JSAPI.h"
#import "Project.h"


@interface ProjectViewController ()

@property (strong, nonatomic) Project *currProject;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [JSAPI fetchProject:^(Project *project) {
        self.currProject = project;
        NSLog(@"Projects: %@", self.currProject);
    }];
}

- (IBAction)applybuttonPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Status"
                                message:@"Project request Accepted"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Ok was pressed");
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
