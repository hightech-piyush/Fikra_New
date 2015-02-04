//
//  RegisterViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/19/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "AppDelegate.h"
#import "CirActivityIndicatorView.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,NSURLConnectionDelegate,UIPickerViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,UIApplicationDelegate>

{
        IBOutlet TPKeyboardAvoidingScrollView *keyBoardView;
    //IBOutlet UIButton *btn_Register;
    IBOutlet UIView *pickerView;
    IBOutlet UIView *loadView;
    NSMutableData *receivedData;
    NSMutableArray *pickerArray;
    NSArray *arr;
    NSString *strGender;
    NSString *strDob;
    AppDelegate *app;
    NSString *check_WS_Method;
    NSString *strCountryID;
    BOOL isScroll;
    BOOL isPullDrag;
    NSString *strDateFormat;
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *slide_View;
    IBOutlet UITableView *tbl_Slider;
    NSMutableArray *sliderArray;
       IBOutlet UIView *loadingView;
     IBOutlet UIView *loadingViewSecond;
    CirActivityIndicatorView * etActivity;
    IBOutlet UIImageView *img_animation;
    
    
    NSString *strPwd_Max;
    NSString *strPwd_Min;
    NSString *strPhone_Max;
    NSString *strPhone_Min;
    
    
      }
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
- (IBAction)btndone2:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *gifView;

-(IBAction)menuLClicked:(id)sender;
-(IBAction)btn_RegisterClicked:(id)sender;
-(IBAction)btn_BackClicked:(id)sender;
@property(strong,nonatomic)  NSMutableArray *CountryArray;
- (IBAction)doneArea:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar1;
@property (strong, nonatomic) IBOutlet UIPickerView *dp;
@property (strong, nonatomic) IBOutlet UIToolbar *tb;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic)IBOutlet UITextField *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_nickName;
@property (strong, nonatomic)IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_phone;
@property (strong, nonatomic) IBOutlet UITextField *txt_Password;
@property (strong, nonatomic)IBOutlet UITextField *txt_Nationality;
@property (strong, nonatomic) IBOutlet UITextField *txt_Gender;
@property (strong, nonatomic) IBOutlet UITextField *txt_DOB;
@property (strong, nonatomic) IBOutlet UILabel *lbl_pleaseWait;

@property (strong, nonatomic) IBOutlet UILabel *lbl_pleaseWaitSub;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UITextField *txt_ConfirmPassword;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Gender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Nationality;

- (IBAction)btn_Nationality_Clicked:(id)sender;
- (IBAction)btn_Gender_Clicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Dob;
- (IBAction)btn_DOB_Clicked:(id)sender;

@property (strong, nonatomic)IBOutlet UIButton *btn_Register;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@end
