//
//  LoginViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AnimatedGif.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITableViewDelegate>

{
  AppDelegate *app;
     NSMutableData *receivedData;
    BOOL isScroll;
    BOOL isPullDrag;
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *slide_View;
    IBOutlet UITableView *tbl_Slider;
     NSMutableArray *sliderArray;
    IBOutlet UIImageView *img_animation;
    
    NSString *str_remember_username;
    NSString *str_remember_password;
    
    NSString *strPwd_Max;
    NSString *strPwd_Min;
    NSString *strPhone_Max;
    NSString *strPhone_Min;

     BOOL isChecked;
    NSString *Reg_ID;

      NSString *checkMethodWS;
    
}
-(IBAction)menuLClicked:(id)sender;
-(IBAction)btn_back_Clicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
- (IBAction)btn_RegisterClicked:(id)sender;
- (IBAction)btn_ForgotPassword_Clicked:(id)sender;
- (IBAction)btn_PushSliderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;
@property (strong, nonatomic) IBOutlet UIButton *btn_Check_Uncheck;
@property (strong, nonatomic) IBOutlet UILabel *lbl_OR;
@property (strong, nonatomic) IBOutlet UITextField *txt_Username;
@property (strong, nonatomic) IBOutlet UITextField *txt_Password;
@property (strong, nonatomic) IBOutlet UIView *gifContainer;

@property(nonatomic,retain) IBOutlet UIView *main_View;

@property (nonatomic,assign) BOOL isChecked;
@property (strong, nonatomic) IBOutlet UIView *gifView;

- (IBAction)btn_chk_Unchk_Clicked:(id)sender;

@end

