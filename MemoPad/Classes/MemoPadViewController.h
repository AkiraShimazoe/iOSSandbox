//
//  MemoPadViewController.h
//  MemoPad
//
//  Created by 中村 薫 on 10/11/26.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoPadViewController : UIViewController {
	// テキストビューのためのアウトレット
	IBOutlet UITextView* textView;
}

// キーボードを隠すためのアクション
-(IBAction)done;

@end

