//
//  MyBrowserViewController.h
//  MyBrowser
//
//  Created by 中村 薫 on 10/12/20.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBrowserViewController : UIViewController {
	IBOutlet UIWebView *web;
	
	// toolbarボタン
	IBOutlet UIButton *btnBack;
	IBOutlet UIButton *btnForward;
	IBOutlet UIButton *btnReload;
	IBOutlet UIButton *btnStop;
	
	// URL制御ボタン
	IBOutlet UIView *viewBack;
	IBOutlet UITextField *txtUrl;
}

@property(nonatomic,retain) UIWebView *web;

// toolbarボタン
@property(nonatomic,retain) UIButton *btnBack;
@property(nonatomic,retain) UIButton *btnForward;
@property(nonatomic,retain) UIButton *btnReload;
@property(nonatomic,retain) UIButton *btnStop;

// URL制御ボタン
@property(nonatomic,retain) UIView *viewBack;
@property(nonatomic,retain) UITextField *txtUrl;

- (IBAction)btnToolBtn:(id) sender;
- (IBAction)btnUrlBar:(id) sender;
- (IBAction)goUrl:(id) sender;
- (IBAction)goGoogle:(id) sender;
- (IBAction)goHome:(id) sender;

@end

