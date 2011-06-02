//
//  jankenViewController.h
//  janken
//
//  Created by 中村 薫 on 10/12/10.
//  Copyright 2010 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jankenViewController : UIViewController {
	IBOutlet UIButton *btn_gu;
	IBOutlet UIButton *btn_tyoki;
	IBOutlet UIButton *btn_pa;
	IBOutlet UIButton *btn_again;
	IBOutlet UILabel *lbl_mes;
	IBOutlet UILabel *lbl_kekka;
	//IBOutlet UILabel *lbl_aite;
	IBOutlet UIImageView *img_aite;
}

enum te {
	gu,
	ch,
	pa
};

@property (nonatomic,retain) UIButton *btn_gu;
@property (nonatomic,retain) UIButton *btn_tyoki;
@property (nonatomic,retain) UIButton *btn_pa;
@property (nonatomic,retain) UIButton *btn_again;
@property (nonatomic,retain) UILabel *lbl_mes;
@property (nonatomic,retain) UILabel *lbl_kekka;
//@property (nonatomic,retain) UILabel *lbl_aite;
@property (nonatomic,retain) UIImageView *img_aite;

-(IBAction) btn_gu_down:(id) sender;
-(IBAction) btn_tyoki_down:(id) sender;
-(IBAction) btn_pa_down:(id) sender;
-(IBAction) btn_again_down:(id) sender;

-(void) janken:(enum te) hand;

@end

