//
//  TermsofServiceViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsofServiceViewController : UIViewController<UIGestureRecognizerDelegate,NSURLConnectionDelegate>

{
    BOOL isScroll;
    BOOL isPullDrag;
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *slide_View;
    IBOutlet UITableView *tbl_Slider;
    NSMutableArray *sliderArray;
        NSMutableData *receivedData;
    IBOutlet UIImageView *img_animation;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
    }
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *gifView;
@property(nonatomic,retain) IBOutlet UITextView *txt_View;
-(IBAction)menuLClicked:(id)sender;
@property(nonatomic,retain) IBOutlet UIView *main_View;
-(IBAction)btn_BackClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@end
