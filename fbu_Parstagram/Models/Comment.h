//
//  Comment.h
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (strong, nonatomic)NSString *text;
@property (strong, nonatomic)PFUser *user;
@property (strong, nonatomic)Post *post;

@end

NS_ASSUME_NONNULL_END
