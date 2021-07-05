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
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"There was an error logging out:%@", error.debugDescription);
    }];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    
    [cell setPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return;
//}

@end
