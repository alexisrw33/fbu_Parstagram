//
//  AppDelegate.m
//  fbu_Parstagram
//
//  Created by Alexis Rojas-Westall on 6/19/21.
//

#import "AppDelegate.h"
#import "Parse.h"
#import "HomeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

                configuration.applicationId = @"DilwfVyPrZ5h9LjLtS7aiIBQVo6P07puftQtsruh"; // <- UPDATE
                                  configuration.clientKey = @"xJ5vYJh1fXSjjyVCchsY9m6H6r9eeUcn9PyNHCDp"; // <- UPDATE
                configuration.server = @"https://parseapi.back4app.com";
            }];

    [Parse initializeWithConfiguration:config];
    
//    PFObject *User = [PFObject objectWithClassName:@"User"];
//    User[@"username"] = @1337;
//    User[@"password"] = @"Sean Plott";
////    gameScore[@"cheatMode"] = @NO;
//    [User saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//     if (succeeded) {
//            NSLog(@"Object saved!");
//     } else {
//            NSLog(@"Error: %@", error.description);
//     }
//    }];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
