//
//  stopwatchAppDelegate.h
//  stopwatch
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class stopwatchViewController;

@interface stopwatchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    stopwatchViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet stopwatchViewController *viewController;

@end

