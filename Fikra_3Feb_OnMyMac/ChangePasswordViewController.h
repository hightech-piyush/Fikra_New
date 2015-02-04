//
//  ChangePasswordViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 10/29/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate>
{
    IBOutlet UIImageView *img_animation;
      NSMutableData *receivedData;
    IBOutlet UIView *view_Logout;
    NSString *pswrdMAX;
    IBOutlet UIView *view_Logout_Second;
   }
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UIView *gifView;

-(IBAction)menuLClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnChangePswrd;
@property (strong, nonatomic)IBOutlet UITextField *txt_oldPswrd;
@property (strong, nonatomic) IBOutlet UITextField *txt_NewPaswrd;
@property (strong, nonatomic)IBOutlet UITextField *txt_ConfimPaswrd;
-(IBAction)btn_BackClicked:(id)sender;
-(IBAction)btn_ChangePswrdClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@end
