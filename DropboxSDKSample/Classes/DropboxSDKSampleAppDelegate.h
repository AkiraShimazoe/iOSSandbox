//
//  DropboxSDKSampleAppDelegate.h
//  DropboxSDKSample
//
//  Created by 中村 薫 on 11/01/05.
//  Copyright 2011 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropboxSDKSampleAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

