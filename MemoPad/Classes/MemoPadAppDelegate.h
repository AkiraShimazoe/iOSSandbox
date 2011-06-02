//
//  MemoPadAppDelegate.h
//  MemoPad
//
//  Created by 中村 薫 on 10/11/26.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MemoPadViewController;

@interface MemoPadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MemoPadViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MemoPadViewController *viewController;

@end

