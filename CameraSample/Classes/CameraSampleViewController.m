//
//  CameraSampleViewController.m
//  CameraSample
//
//  Created by 中村 薫 on 10/12/27.
//  Copyright 2010 personal. All rights reserved.
//

#import "CameraSampleViewController.h"
#import "Mixi.h"
#import "MixiOAuthKey.h"

@implementation CameraSampleViewController

@synthesize imageView;

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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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

- (IBAction)showCameraSheet {
	NSLog(@"showCameraSheet");
	// アクションシートを作る
	UIActionSheet *sheet;
	sheet= [[UIActionSheet alloc]
			 initWithTitle:nil
			 delegate:self
			 cancelButtonTitle:@"キャンセル"
			 destructiveButtonTitle:nil
			 otherButtonTitles:@"ライブラリから選択", @"写真を撮る", @"写真を保存する", nil];
	[sheet autorelease];
	
	// アクションシートを表示する
	[sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"clickedButtonAtIndex:%d", buttonIndex);
	
	// ボタンインデックスをチェックする
	if (buttonIndex >= 3) {
		return;
	}
	
	// ソースタイプを決定する
	UIImagePickerControllerSourceType sourceType = 0;
	if (buttonIndex == 0 ) {
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	else if (buttonIndex == 1 ) {
		sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	else if (buttonIndex == 3 ) {
		sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	}
	
	// 使用可能かどうかチェックする
	if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
		return;
	}
	
	// イメージピッカーを作る
	UIImagePickerController *imagePicker;
	imagePicker = [[[UIImagePickerController alloc] init] autorelease];
	imagePicker.sourceType = sourceType;
	imagePicker.allowsEditing = YES;
	imagePicker.delegate = self;
	
	// イメージピッカを表示する
	[self presentModalViewController:imagePicker animated:YES];
	
}

- (void) imagePickerController:(UIImagePickerController *)picker
					didFinishPickingImage:(UIImage*)image
					editingInfo:(NSDictionary *)editingInfo {
	NSLog(@"%s", __FUNCTION__);
	// イメージピッカーを隠す
	[self dismissModalViewControllerAnimated:YES];

	// オリジナル画像を取得する
	UIImage *originalImage = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
	for ( NSString* key in [editingInfo keyEnumerator] ) {
		NSLog(@"key:%@, value:%@", key, [editingInfo objectForKey:key]);
	}
	
	// グラフィックコンテキストを作る
	// 縦
	CGSize size = { 300, 400 };
	UIGraphicsBeginImageContext(size);
	
	// 画像を縮小して描画する
	CGRect rect;
	rect.origin = CGPointZero;
	rect.size = size;
	[originalImage drawInRect:rect];
	
	// 描画した画像を取得する
	UIImage *shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// 画像を表示する
	imageView.image = shrinkedImage;
	
	// 画像を保存する(カメラで撮ったときだけ保存しないとダブル)
	//UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil );

	NSLog(@"post mixi");
	Mixi *mixi = [[Mixi alloc] init:CONSUMER_KEY consumerSecret:CONSUMER_SECRET];
	[mixi setAccessToken:@"c9a142e5638affbed0ab10f232e84182606a193f"];

	[mixi postVoiceWithPhotoData:@"from iPhone post"
                           photo:[[[NSData alloc] initWithData:UIImagePNGRepresentation( originalImage )] autorelease]
                        fileName:@"SAMPLE.JPG"];
}

- (void) dismissModalViewControllerDidCanceled:(UIImagePickerController *)picker {
	NSLog(@"%s", __FUNCTION__);
	// イメージピッカーを隠す
	[self dismissModalViewControllerAnimated:YES];
}

@end
