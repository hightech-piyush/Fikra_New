//
//  ForgotPWDViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/28/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPWDViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate,NSURLConnectionDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITableViewDelegate>

{
     //IBOutlet UITextField *forgot_TextField;
     NSMutableData *receivedData;
    BOOL isScroll;
    IBOutlet UIView *slide_View;
    IBOutlet UITableView *tbl_Slider;
    NSMutableArray *sliderArray;
       CGFloat start;
    NSString *checkMethodWS;
    BOOL directionUp;
    IBOutlet UIImageView *img_animation;
    IBOutlet UIButton *brn_Forgot_PWD;
    NSString *RegID;
   
}
 @property (strong, nonatomic) IBOutlet UIView *gifView;
-(IBAction)menuLClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
-(IBAction)Forgot_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *forgot_TextField;
-(IBAction)btn_BackClicked:(id)sender;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@end




