//
//  PostCell.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/28/21.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.layer.masksToBounds = YES;
    
}

-(void)setPost:(Post *)post {
    PFUser *user = post[@"author"];
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        PFFileObject *profileImage = user[@"profile_image"];
        NSURL *profileImageURL = [NSURL URLWithString:profileImage.url];
        [self.profileImageView setImageWithURL:profileImageURL];
        self.screenNameLabel.text = user[@"username"];
        self.usernameLabel.text = user[@"username"];
    }];
    self.postText.text = post[@"caption"];
    PFFileObject *image = post[@"image"];
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.postImage setImageWithURL:imageURL];

}

@end
