//
//  Post.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/20/21.
//

#import "Post.h"
#import "Comment.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic dateStamp;
@dynamic userLikes;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    NSDate *timeStamp = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    newPost.dateStamp = [formatter stringFromDate:timeStamp];
    newPost.userLikes = [NSMutableArray new];
    
    [newPost saveInBackgroundWithBlock: completion];
}

- (void)addComment:(NSString *)text {
    Comment *newComment = [Comment new];
    newComment.text = text;
    newComment.user = PFUser.currentUser;
    newComment.post = self;
    [newComment saveInBackground];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
