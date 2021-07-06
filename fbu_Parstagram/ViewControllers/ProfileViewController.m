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
#import "Post.h"
#import "UserProfileCell.h"

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) PFUser *user;

@property (strong, nonatomic) NSMutableArray *userPosts;

//@property (strong, nonatomic) UIImageView *imageForProfile;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
      
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
      
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = ((self.collectionView.frame.size.width - (layout.minimumInteritemSpacing))/ postersPerLine);
    CGFloat itemHeight = itemWidth ;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.user = [PFUser currentUser];
}

-(void)fetchUserPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
    // [query includeKey:@"author"]; // gets the profile photo for each user
    [query whereKey:@"author" equalTo:self.user];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            Post *newPost = [Post new];
            self.userPosts = [posts copy];
            [self.collectionView reloadData];
//            [self.refreshControl endRefreshing];
            

            // get the current user and assign it to "author" field. "author" field is now of Pointer type
//            newPost.author = [PFUser currentUser];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
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
    [self fetchUserPosts];
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
    UserProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    Post *post = self.userPosts[indexPath.item];
    
    PFFileObject *image = post[@"image"];
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [cell.postImage setImageWithURL:imageURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ProfileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"profileHeaderView" forIndexPath:indexPath];
    
    [headerView getUserData];
    
//    headerView.frame.size.height = 300;
    return headerView;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchUserPosts];
}


@end
