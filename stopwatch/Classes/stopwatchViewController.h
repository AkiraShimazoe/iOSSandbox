//
//  stopwatchViewController.h
//  stopwatch
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stopwatchViewController : UIViewController {
	IBOutlet UILabel *lbl;
	NSTimer *timer;
}

@property(nonatomic,retain) UILabel *lbl;

- (void) onTimer:(NSTimer*)timer;
- (IBAction) start_down:(id) sender;
- (IBAction) stop_down:(id) sender;
- (IBAction) clear_down:(id) sender;

@end

