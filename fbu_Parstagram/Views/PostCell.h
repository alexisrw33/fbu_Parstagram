//
//  PostCell.h
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/28/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postText;

-(void)setPost:(Post *)post;

@end


NS_ASSUME_NONNULL_END
