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

@property (strong, nonatomic) NSArray *allOrgs;
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
    
}


-(void)loadOrgs{
    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        
        self.allOrgs = allOrganizations;
        NSLog(@"Organizations: %@", self.allOrgs);
        [self.orgTableView reloadData];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allOrgs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"NPORequestsTableViewCell";
    [self.orgTableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    NPORequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Organization *currentCell = self.allOrgs[indexPath.row];
    NSString *ImageURL = @"currentCell.profilePic";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
 
    cell.orgNameLabel.text = currentCell.username;
    
    cell.orgImage.image = [UIImage imageWithData:imageData];
    
    NSLog(@"Organization Name:%@", currentCell.username);
//    cell.requestTypeLabel.text = currentCell.
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *segueID = @"requestDetails";
    if ([[segue identifier]  isEqual: segueID]){
        ProjectViewController *destVC = segue.destinationViewController;
        int index = (int)self.orgTableView.indexPathsForSelectedRows.firstObject.row;
        destVC.organization = [self.allOrgs objectAtIndex:index];

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"requestDetails" sender:nil];
}


@end
