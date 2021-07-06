//
//  CommentCell.h
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@property (strong, nonatomic) NSMutableArray *commentArray;

@end

NS_ASSUME_NONNULL_END
