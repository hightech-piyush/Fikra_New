//
//  ContactUsViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface ContactUsViewController : UIViewController<UIGestureRecognizerDelegate,UITextViewDelegate,UITextFieldDelegate,NSURLConnectionDelegate>
{
 
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *slide_View;
       NSMutableArray *sliderArray;
        NSMutableData *receivedData;
IBOutlet TPKeyboardAvoidingScrollView *keyBoardView;
    IBOutlet UIImageView *img_animation;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
        IBOutlet UIButton *btn_Send;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *gifView;


-(IBAction)menuLClicked:(id)sender;
@property(nonatomic,retain) IBOutlet UIView *main_View;
-(IBAction)btn_BackClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic)IBOutlet UITextField *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_mobile;
@property (strong, nonatomic)IBOutlet UITextField *txt_email;
@property (strong, nonatomic)IBOutlet UITextView *txt_comment;
@property (strong, nonatomic)IBOutlet UILabel *lbl_Placeholder;
- (IBAction)btn_Send_Clicked:(id)sender;
@end

