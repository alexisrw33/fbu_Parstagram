//
//  Comment.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 7/5/21.
//

#import "Comment.h"

@implementation Comment

@dynamic user;
@dynamic text;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
