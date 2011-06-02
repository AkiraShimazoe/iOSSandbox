//
//  MyBrowserViewController.m
//  MyBrowser
//
//  Created by 中村 薫 on 10/12/20.
//  Copyright 2010 personal. All rights reserved.
//

#import "MyBrowserViewController.h"

@implementation MyBrowserViewController

@synthesize web;
@synthesize btnBack, btnForward, btnReload, btnStop;
@synthesize viewBack, txtUrl;


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
	
	[web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hatena.ne.jp/kaorun55/"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
	[web release];
}

- (IBAction)btnToolBtn:(id) sender {
	if (self.btnBack.hidden) {
		self.btnBack.hidden = NO;
		self.btnForward.hidden = NO;
		self.btnReload.hidden = NO;
		self.btnStop.hidden = NO;
	}
	else {
		self.btnBack.hidden = YES;
		self.btnForward.hidden = YES;
		self.btnReload.hidden = YES;
		self.btnStop.hidden = YES;
	}
}

- (IBAction)btnUrlBar:(id) sender {
	if (self.viewBack.hidden) {
		[self.txtUrl becomeFirstResponder];
		self.viewBack.hidden = NO;
	}
	else {
		[self.txtUrl resignFirstResponder];
		self.viewBack.hidden = YES;
	}
}

- (IBAction)goUrl:(id) sender {
    [self.txtUrl resignFirstResponder];
    self.viewBack.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.txtUrl.text]]];
}

- (IBAction)goGoogle:(id) sender {
    [self.txtUrl resignFirstResponder];
    self.viewBack.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.jp/"]]];
}

- (IBAction)goHome:(id) sender {
    [self.txtUrl resignFirstResponder];
    self.viewBack.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hatena.ne.jp/kaorun55/"]]];
}

@end
