//
//  DevHomeViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "DevHomeViewController.h"
#import "JSAPI.h"
#import "Organization.h"
#import "NPORequestsTableViewCell.h"
#import "ProjectViewController.h"
#import "Project.h"

@interface DevHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *orgTableView;

@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) NSArray *allOrgs;
@property (strong, nonatomic) NSArray *allProjects;
@property (strong, nonatomic) NSMutableArray *filteredOrgsID;

@end

@implementation DevHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orgTableView.dataSource = self;
    self.orgTableView.delegate = self;
    self.orgTableView.rowHeight = 150;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadOrgs];
    [self loadProjects];
}


-(void)loadOrgs{
    __weak typeof(self) bruce = self;
    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        __strong typeof(bruce) hulk = bruce;
        
        hulk.allOrgs = allOrganizations;
        NSLog(@"Organizations: %@", self.allOrgs);
        [hulk.orgTableView reloadData];
    }];
    
}
-(void)loadProjects{
    __weak typeof(self) bruce = self;
    [JSAPI fetchProjects:^(NSArray<Project *> *projects) {
        __strong typeof(bruce) hulk = bruce;
    
        hulk.allProjects = projects;
        NSLog(@"Projects: %@", self.allProjects);
        [hulk.orgTableView reloadData];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allProjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"NPORequestsTableViewCell";
    [self.orgTableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    NPORequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    Project *projectDataCell = self.allProjects[indexPath.row];
   
    for (Organization *currentOrg in self.allOrgs) {
        if ([currentOrg.orgID isEqualToString: projectDataCell.orgID]) {
            cell.organization = currentOrg;
//            NSString *ImageURL = currentOrg.profilePic;
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
//            cell.orgImage.image = [UIImage imageWithData:imageData];
            
            
            cell.orgNameLabel.text = currentOrg.org;
        }
        
    }
    
    cell.requestTypeLabel.text = projectDataCell.service;
    cell.requestTypeLabel.text = projectDataCell.projectDescription;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    NSString *segueID = @"requestDetails";
    if ([[segue identifier]  isEqual: segueID]){
        ProjectViewController *destVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.orgTableView indexPathForSelectedRow];
        NPORequestsTableViewCell *selectedCell = [self.orgTableView cellForRowAtIndexPath:indexPath];
        
        
        destVC.project = [self.allProjects objectAtIndex:indexPath.row];
        destVC.organization = selectedCell.organization;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    [self performSegueWithIdentifier:@"requestDetails" sender:nil];
}



@end
