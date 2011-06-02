//
//  jankenAppDelegate.h
//  janken
//
//  Created by 中村 薫 on 10/12/10.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class jankenViewController;

@interface jankenAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    jankenViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet jankenViewController *viewController;

@end

