//
//  RootViewController.h
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSArray	*statuses;
}

@property(nonatomic,retain) NSArray *statuses;

- (void) loadTimelineByUserName:(NSString *)userName;
- (void) loadTimelineDidEnd: (NSNotification *)notification;
- (void) loadTimelineFaied: (NSNotification *) notification;
		
@end
