//
//  MyBrowserAppDelegate.h
//  MyBrowser
//
//  Created by 中村 薫 on 10/12/20.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyBrowserViewController;

@interface MyBrowserAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MyBrowserViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyBrowserViewController *viewController;

@end

