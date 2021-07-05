//
//  ProfileViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "ProfileViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *postNumber;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.editButton.layer.borderWidth = 2.0f;
    self.editButton.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)getUserData {
    PFUser *user = PFUser.currentUser;
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        self.name.text = user[@"fullname"];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getUserData]; // will be fired every time
}

- (IBAction)onEditButton:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
