//
//  OrgHomeViewController.m
//  dev-org
//
//  Created by Rio Balderas on 5/16/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "OrgHomeViewController.h"
#import "JSAPI.h"
#import "Organization.h"
#import "NPORequestsTableViewCell.h"

@interface OrgHomeViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *orgTableView;

@property (strong, nonatomic) NSArray *allOrgs;
@end

@implementation OrgHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
//    self.orgTableView.dataSource = self;
    NSString *nib = @"NPORequestsTableViewCell";
    [self.orgTableView registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:nib];
    
    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        self.allOrgs = allOrganizations;
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
//    cell.requestTypeLabel.text = currentCell.
    return cell;
}


@end
