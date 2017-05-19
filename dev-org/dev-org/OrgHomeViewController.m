//
//  OrgHomeViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "OrgHomeViewController.h"
#import "NewRequestViewController.h"
@interface OrgHomeViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *devCollectionView;

@property (strong, nonatomic) NSArray *allDevs;


@end

@implementation OrgHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"White_background"]];

    self.devCollectionView.dataSource = self;

    [JSAPI fetchAllDevelopers:^(NSArray<Developer *> *allDevs) {
        NSLog(@"Developers: %@", allDevs);
        self.allDevs = allDevs;

        if (allDevs[0].isAvailable) {
            NSLog(@"Developer is available");

        } else {
            NSLog(@"Developer is NOT available");
        }
        [self.devCollectionView reloadData];

    }];

}

#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allDevs.count;
}
- (IBAction)newRequestButtonPressed:(UIButton *)sender {
    UIStoryboard *storyboard = self.storyboard;
    NewRequestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NewRequestViewController"];
    NSLog(@"OrgHome token: %@",self.org.userToken);
    vc.organization = self.org;
    [self presentViewController:vc animated:YES completion:nil];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"DevCell";
    DevCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    Developer *currentCell = self.allDevs[indexPath.row];

    cell.devUsernameLabel.text = currentCell.username;

    NSString *singleService = [currentCell.services objectAtIndex:0];
    //to convert image url to rendableUIImage
    NSString *ImageURL = @"currentCell.profilePic";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];

    cell.devProjectTypeLabel.text = singleService;
    cell.devProfileImage.image = [UIImage imageWithData:imageData];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];

    if ([[segue identifier]  isEqual: @"devProfileDetail"]) {
        DevProfileViewController *destVC = segue.destinationViewController;
        int index = (int)self.devCollectionView.indexPathsForSelectedItems.firstObject.row;
        destVC.developer = [self.allDevs objectAtIndex:index];
    }

}

@end
