//
//  HomeViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/20/21.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Post.h"
#import "PostCell.h"
#import "CommentCell.h"
#import "CommentViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshControl;
    
    [self fetchPosts];
}
- (IBAction)onLogout:(id)sender {
    [self logout];
}

- (void)logout {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
//        [self dismissViewControllerAnimated:YES completion:nil];
        if (error) {
            NSLog(@"There was an error logging out:%@", error.debugDescription);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
//    [query includeKey:@"author"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            Post *newPost = [Post new];
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            

            // get the current user and assign it to "author" field. "author" field is now of Pointer type
//            newPost.author = [PFUser currentUser];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)fetchPostsWithMoreThan100Likes {
    // construct query
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"likesCount > 100"];
    PFQuery *query = [PFQuery queryWithClassName:@"Post" predicate:predicate];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            Post *newPost = [Post new];

            // get the current user and assign it to "author" field. "author" field is now of Pointer type
//            newPost.author = [PFUser currentUser];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqual:@"commentSegue"]) {
        CommentCell *cell = sender; // which cell  we clcked on -> which Post we clicked on
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Post *post = self.posts[indexPath.section];
        CommentViewController *commentViewController = segue.destinationViewController.childViewControllers[0];
        commentViewController.post = post;
    }
    // Pass the selected object to the new view controller.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
        Post *post = self.posts[indexPath.section];
        
        [cell setPost:post];
        
        return cell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        
        
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.posts.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end
