//
//  PostViewController.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/20/21.
//

#import "PostViewController.h"
#import "Post.h"
#import "Parse/Parse.h"

@interface PostViewController () < UINavigationControllerDelegate, UIImagePickerControllerDelegate >
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) UIImageView *imagePicked;
@property (nonatomic, strong) Post *post;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textView.text = @"write a caption...";
    self.textView.textColor = [UIColor lightGrayColor];
}

//-(void)takeAPicture {
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.imagePicked = info[UIImagePickerControllerOriginalImage];
//    CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.width);
//    [self resizeImage:self.imagePicked withSize:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.width)];
//    CGRect frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    UIImage *image = [self resizeImage:self.imagePicked withSize:CGSizeMake(1000, 1000)];
    self.imageView.alpha = 1;
    self.imageView.image = image;
    

    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onPost:(id)sender {
    [Post postUserImage:self.imageView.image withCaption:self.textView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Post has been uploaded!");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSString *errorString = [error localizedDescription];
            NSLog(@"%@", errorString);
        }
    }];
//    self.post.image = self.imagePicked.image;
//    [self.post.imag]
//    self.post.caption = self.textView.text;
    
}
- (IBAction)onSelectImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@"write a caption..."]) {
         self.textView.text = @"";
         self.textView.textColor = [UIColor blackColor]; //optional
    }
    [self.textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@""]) {
        self.textView.text = @"write a caption...";
        self.textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [self.textView resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
