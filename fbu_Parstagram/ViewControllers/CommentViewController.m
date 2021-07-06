//
//  CommentViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "CommentViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "CommentCell.h"
#import "Post.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchComments];

}

- (void)didTapComment {
//    [post addComment: @"adasd"];
}

-(void)fetchComments {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
//    [query includeKey:@"author"];
    query.limit = 20;
    [query whereKey:@"post" equalTo:self.post];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        if (comments != nil) {
            // do something with the array of object returned by the call
//            Post *newPost = [Post new];
            self.commentsArray = comments;
            [self.tableView reloadData];
            
            // get the current user and assign it to "author" field. "author" field is now of Pointer type
//            newPost.author = [PFUser currentUser];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count;
}

@end
