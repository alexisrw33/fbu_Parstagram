//
//  CommentViewController.h
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
