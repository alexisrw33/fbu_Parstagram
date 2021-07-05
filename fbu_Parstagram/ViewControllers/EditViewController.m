//
//  EditViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "EditViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"

@interface EditViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

@property (strong, nonatomic) UIImage *imageForProfile;

@property (strong, nonatomic) PFUser *user;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.user = PFUser.currentUser;
    
    self.bioTextView.delegate = self;
    
    [self.user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        
        if (self.user[@"fullname"] != nil) {
            self.nameTextField.text = self.user[@"fullname"];
        }
        if (self.user[@"website"] != nil) {
            self.websiteTextField.text = self.user[@"website"];
        }
        if ([self.user[@"bio"] length] != 0) {
            self.bioTextView.text = self.user[@"bio"];
            self.bioTextView.textColor = [UIColor blackColor];
        } else {
            self.bioTextView.text = @"write a bio...";
            self.bioTextView.textColor = [UIColor lightGrayColor];
        }
        self.usernameTextField.text = self.user[@"username"];
        
        if (self.user[@"profile_image"] != nil) {
            PFFileObject *image = self.user[@"profile_image"];
            NSURL *url = [NSURL URLWithString:image.url];
            [self.profilePhoto setImageWithURL:url];
        }
        
    }];
}

- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onDone:(id)sender {
    
    self.user[@"fullname"] = self.nameTextField.text;
    self.user[@"username"] = self.usernameTextField.text;
    self.user[@"website"] = self.websiteTextField.text;
    self.user[@"bio"] = self.bioTextView.text;
    
    if([self.user[@"bio"] isEqualToString:@"write a bio..."]) {
        self.user[@"bio"] = @"";
    }
    
    if (self.imageForProfile != nil) {
        NSData *imageData = UIImagePNGRepresentation(self.imageForProfile);
        // get image data and check if that is not nil
        PFFileObject *photo = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
        self.user[@"profile_image"] = photo;
    }
    
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Successfully updated profile Photo!");
        } else {
            NSLog(@"Error:%@", error.localizedDescription);
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)onChangeProfilePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    //compress to fit within Parse's 10mb file limit
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Do something with the images (based on your use case)
    self.imageForProfile = info[UIImagePickerControllerOriginalImage];
//    CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.width);
//    [self resizeImage:self.imagePicked withSize:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.width)];
//    CGRect frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    UIImage *image = [self resizeImage:self.imageForProfile withSize:CGSizeMake(375, 375)];
    self.profilePhoto.alpha = 1;
    self.profilePhoto.image = image;
    

    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.bioTextView.text isEqualToString:@"write a bio..."]) {
         self.bioTextView.text = @"";
         self.bioTextView.textColor = [UIColor blackColor]; //optional
    }
    [self.bioTextView becomeFirstResponder];
}



- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.bioTextView.text isEqualToString:@""]) {
        self.bioTextView.text = @"write a bio...";
        self.bioTextView.textColor = [UIColor lightGrayColor]; //optional
    }
    [self.bioTextView resignFirstResponder];
}




@end
