//
//  EventListDetailViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import "SubEvent.h"
#import "Reachability.h"
#import "MarqueeLabel.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface EventListDetailViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,MPMediaPickerControllerDelegate>
{
    NSMutableArray *event_CategoryArray;;
    IBOutlet UITableView *tbl_eventListDetail;
         NSMutableData *receivedData;
    NSMutableArray *sliderArray;
    IBOutlet UITableView *tbl_Slider;
    BOOL animating;
    NSInteger j;
    NSString *filename;
      BOOL isAnimatedLastRow;
    BOOL ISLeft;
    CGFloat NewViewtoLeft;
    BOOL isScroll;
    NetworkStatus  hostStatus;
    IBOutlet UIButton *btn_Menu;
    NSMutableArray *arySelectedItems;
     NSMutableArray *arySelectedID;
    NSString *strSelectedItems;
    NSString *strSelectedID;
    BOOL hasExceeded;
    NSString *strPrice;
    NSInteger _selectedRow;
    NSString *str_subEventID;
     NSMutableArray *arrSelectedrowIndex;
    
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
     }
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *gifView;

-(IBAction)menuLClicked:(id)sender;
-(IBAction)btn_BackClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblUploadMP3;
-(IBAction)eventImageClicked:(id)sender;
- (IBAction)uploadMP3_Clicked:(id)sender;


@property (strong, nonatomic)IBOutlet UIImageView *img_animation;
@property (strong, nonatomic) IBOutlet UIButton *btnUploadMP3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_Event;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Address;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Address1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Address2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_SelectTourna;
@property (strong, nonatomic) IBOutlet UIButton *btn_Proceed;
@property (strong, nonatomic) IBOutlet UILabel *lblPrize;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrency;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeFormat;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblMMYY;
- (IBAction)btn_LoginClicked:(id)sender;
@property(nonatomic,retain) IBOutlet UIView *main_View;
- (IBAction)btn_Proceed_Clicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) SubEvent *subEvent;
@end

