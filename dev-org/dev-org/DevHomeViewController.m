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

@interface DevHomeViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *orgTableView;

@property (strong, nonatomic) NSArray *allOrgs;
@end

@implementation DevHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.orgTableView.dataSource = self;
    NSString *nib = @"NPORequestsTableViewCell";
    [self.orgTableView registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:nib];
    
    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        self.allOrgs = allOrganizations;
        [self.orgTableView reloadData];
        NSLog(@"Organizations: %@", self.allOrgs);
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allOrgs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"NPORequestsTableViewCell";
    NPORequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Organization *currentCell = self.allOrgs[indexPath.row];
    cell.orgNameLabel.text = currentCell.org;
    NSLog(@"Organization Name:%@", currentCell.org);
//    cell.requestTypeLabel.text = currentCell.
    return cell;
}


@end
