//
//  ProfileHeaderView.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "ProfileHeaderView.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"

@implementation ProfileHeaderView
- (IBAction)onEditButton:(id)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Do any additional setup after loading this header view.
    self.editButton.layer.borderWidth = 2.0f;
    self.editButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2;
    self.profileImage.layer.masksToBounds = YES;
    
}

-(void)getUserData {
    PFUser *user = PFUser.currentUser;
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        self.fullName.text = user[@"fullname"];
        self.descriptionLabel.text = user[@"bio"];
        PFFileObject *image = user[@"profile_image"];
        NSURL *imageURL = [NSURL URLWithString:image.url];
        [self.profileImage setImageWithURL:imageURL];
    }];
}

@end
