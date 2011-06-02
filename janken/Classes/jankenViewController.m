//
//  jankenViewController.m
//  janken
//
//  Created by 中村 薫 on 10/12/10.
//  Copyright 2010 personal. All rights reserved.
//

#import "jankenViewController.h"

@implementation jankenViewController

@synthesize btn_gu, btn_tyoki, btn_pa, btn_again;
@synthesize lbl_mes, lbl_kekka/*, lbl_aite*/, img_aite;

UIImage *img_gu;
UIImage *img_ch;
UIImage *img_pa;

-(void) janken:(enum te) hand {
	self.lbl_mes.text = @"じゃんけん・・・ぽん";
	
	srand(time(nil));
	enum te kekka = rand()%3;
	if ( kekka == gu ) {
		self.img_aite.image = img_gu;
	}
	else if ( kekka == ch ) {
		self.img_aite.image = img_ch;
	}
	else if ( kekka == pa ) {
		self.img_aite.image = img_pa;
	}
	
	if ( kekka == hand ) {
		self.lbl_kekka.text = @"あいこで・・・";
		self.btn_gu.hidden = NO;
		self.btn_tyoki.hidden = NO;
		self.btn_pa.hidden = NO;
		self.btn_again.hidden = YES;
	}
	else if ( kekka == ((hand+1) & 3) ) {
		self.lbl_kekka.text = @"あなたの勝ち！";
		self.btn_gu.enabled = NO;
		self.btn_tyoki.enabled = NO;
		self.btn_pa.enabled = NO;
	}
	else {
		self.lbl_kekka.text = @"あなたの負け！";
		self.btn_gu.enabled = NO;
		self.btn_tyoki.enabled = NO;
		self.btn_pa.enabled = NO;
	}
}

-(IBAction) btn_gu_down:(id) sender {
	NSLog( @"btn_gu_down" );

	self.btn_tyoki.hidden = YES;
	self.btn_pa.hidden = YES;
	self.btn_again.hidden = NO;

	[self janken:gu];
}

-(IBAction) btn_tyoki_down:(id) sender {
	NSLog( @"btn_tyoki_down" );

	self.btn_gu.hidden = YES;
	self.btn_pa.hidden = YES;
	self.btn_again.hidden = NO;
	
	[self janken:ch];
}

-(IBAction) btn_pa_down:(id) sender { 
	NSLog( @"btn_pa_down" );

	self.btn_tyoki.hidden = YES;
	self.btn_gu.hidden = YES;
	self.btn_again.hidden = NO;
	
	[self janken:pa];
}

-(IBAction) btn_again_down:(id) sender {
	NSLog( @"btn_again_down" );
	
	self.btn_gu.enabled = YES;
	self.btn_gu.hidden = NO;
	self.btn_tyoki.enabled = YES;
	self.btn_tyoki.hidden = NO;
	self.btn_pa.enabled = YES;
	self.btn_pa.hidden = NO;
	self.btn_again.hidden = YES;
	
	self.lbl_mes.text = @"じゃんけん・・・";
	self.lbl_kekka.text = @"";
	//self.lbl_aite.text = @"";
}

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

	self.lbl_mes.text = @"じゃんけん・・・";
	self.lbl_kekka.text = @"";
	self.lbl_kekka.font = [UIFont boldSystemFontOfSize:30];
	self.lbl_kekka.textColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	
	//self.lbl_aite.text = @"";
	img_gu = [[UIImage imageNamed:@"gu.png"] retain];
	img_ch = [[UIImage imageNamed:@"ch.png"] retain];
	img_pa = [[UIImage imageNamed:@"pa.png"] retain];

	self.btn_again.hidden = YES;
	NSLog( @"viewDidLoad" );
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
	[btn_gu release];
	[btn_tyoki release];
	[btn_pa release];
	[lbl_mes release];
	//[lbl_aite release];
	[lbl_kekka release];
	[img_aite release];
	[img_gu release];
	[img_ch release];
	[img_pa release];
	
    [super dealloc];
}

@end
