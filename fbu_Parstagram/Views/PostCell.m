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
    
}

-(void)setPost:(Post *)post {
    self.postText.text = post[@"caption"];
    PFFileObject *image = post[@"image"];
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.postImage setImageWithURL:imageURL];

}

@end
