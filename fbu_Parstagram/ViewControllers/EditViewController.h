//
//  EditViewController.h
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController <UITextViewDelegate>
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;


@end

NS_ASSUME_NONNULL_END
