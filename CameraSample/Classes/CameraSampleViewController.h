//
//  CameraSampleViewController.h
//  CameraSample
//
//  Created by 中村 薫 on 10/12/27.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraSampleViewController : UIViewController <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	IBOutlet UIImageView	*imageView;
}

@property(retain,nonatomic) UIImageView *imageView;

- (IBAction)showCameraSheet;

@end

