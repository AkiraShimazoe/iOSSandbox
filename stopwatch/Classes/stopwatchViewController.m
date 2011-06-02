//
//  stopwatchViewController.m
//  stopwatch
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import "stopwatchViewController.h"

@implementation stopwatchViewController

@synthesize lbl;

NSDate *stdate;
BOOL timeflg = FALSE;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	timer = [NSTimer scheduledTimerWithTimeInterval:(0.001)
							target:self
							selector:@selector(onTimer:)
							userInfo:nil repeats:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) onTimer:(NSTimer*)timer {
	if (timeflg) {
		NSDate *now = [NSDate date];
		self.lbl.text = [NSString stringWithFormat:@"%.3f", [now timeIntervalSinceDate:stdate]];
	}
}

- (IBAction) start_down:(id) sender {
	NSLog( @"start_down" );
	timeflg = TRUE;
	stdate = [NSDate date];
	[stdate retain];
}

- (IBAction) stop_down:(id) sender {
	NSLog( @"stop_down" );
	timeflg = FALSE;
}

- (IBAction) clear_down:(id) sender {
	NSLog( @"clear_down" );
	timeflg = FALSE;
	self.lbl.text = @"0.000";
}

@end
