//
//  CommentCell.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "CommentCell.h"
#import "Parse/Parse.h"
#import "Comment.h"
#import "Post.h"
#import "UIImageView+AFNetworking.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComment:(Comment *)comment {
    PFUser *user = [PFUser currentUser];
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        PFFileObject *profileImage = user[@"profile_image"];
        NSURL *profileImageURL = [NSURL URLWithString:profileImage.url];
//        [self.profileImageView setImageWithURL:profileImageURL];
        self.nameLabel.text = user[@"username"];
        self.bodyLabel.text = comment[@"text"];
    }];
}

-(void)fetchComments {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
//    [query includeKey:@"author"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            Post *newPost = [Post new];
            self.commentArray = posts;
            
            // get the current user and assign it to "author" field. "author" field is now of Pointer type
//            newPost.author = [PFUser currentUser];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
@end
