//
//  CameraSampleAppDelegate.h
//  CameraSample
//
//  Created by 中村 薫 on 10/12/27.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraSampleViewController;

@interface CameraSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CameraSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CameraSampleViewController *viewController;

@end

