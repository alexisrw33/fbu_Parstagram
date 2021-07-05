//
//  ProfileViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "ProfileViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileHeaderView.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//@property (strong, nonatomic) UIImageView *imageForProfile;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    
//    CGRect *frame = CGRectMake(self.collectionVie, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}

//-(void)getUserData {
//    PFUser *user = PFUser.currentUser;
//    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
//        self.name.text = user[@"fullname"];
//        self.descriptionLabel.text = user[@"bio"];
//        PFFileObject *image = user[@"profile_image"];
//        NSURL *imageURL = [NSURL URLWithString:image.url];
//        [self.profileImage setImageWithURL:imageURL];
//    }];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // reload the Profile Header View whenever this VC appears
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ProfileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"profileHeaderView" forIndexPath:indexPath];
    
    [headerView getUserData];
    
//    headerView.frame.size.height = 300;
    return headerView;
    
}


@end
