//
//  ViewController.m
//  dev-org
//
//  Created by Robert Hatfield on 5/15/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *devCollectionView;

@property (strong, nonatomic) NSArray *allDevs;
@property (strong, nonatomic) NSArray *allOrgs;

@property (strong, nonatomic) NSArray *allDevs;
@property (strong, nonatomic) NSArray *allOrgs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    


    [JSAPI fetchAllOrganizations:^(NSArray<Organization *> *allOrganizations) {
        self.allOrgs = allOrganizations;
        NSLog(@"Organizations: %@", self.allOrgs);

    self.devCollectionView.delegate = self;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}


#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allDevs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"DevCell";
    DevCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Developer *currentCell = self.allDevs[indexPath.row];
    
    cell.devUsernameLabel.text = currentCell.username;
    
    NSString *singleService = [currentCell.services objectAtIndex:0];
    cell.devProjectTypeLabel.text = singleService;
    
//    commented out at the moment until there is an actual image, causes crash.//
//    cell.devProfileImage.image = currentCell.profilePicture;
    return cell;
}

#pragma UICollectionviewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *selectedCell = [self.allDevs objectAtIndex:indexPath.row];
    
    DevProfileViewController *destVC = [[DevProfileViewController alloc]init];
    
    destVC.developer = [self.allDevs objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"devProfileDetail"sender:destVC];
    
    NSLog(@"Developer Object %@ was selected", selectedCell);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]  isEqual: @"devProfileDetail"]) {
        DevProfileViewController *destVC = segue.destinationViewController;
        int index = (int)self.devCollectionView.indexPathsForSelectedItems.firstObject.row;
        destVC.developer = [self.allDevs objectAtIndex:index];
        
    }
    
}


@end
