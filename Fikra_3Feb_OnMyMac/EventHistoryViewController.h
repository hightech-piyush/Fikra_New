//
//  EventHistoryViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 10/29/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MainEvent.h"
#import "MarqueeLabel.h"
@interface EventHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,EGORefreshTableHeaderDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    NSMutableArray *event_title_Array;
    NSMutableArray *event_Description_Array;
    IBOutlet UITableView *tbl_eventList;
    NSMutableArray *sliderArray;
    IBOutlet UITableView *tbl_Slider;
    BOOL animating;
    NSInteger j;
    BOOL isAnimatedLastRow;
    BOOL ISLeft;
    CGFloat NewViewtoLeft;
    BOOL isScroll;
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
    IBOutlet UILabel *lblNoEVENT;
    IBOutlet UIImageView *img_animation;
  
    
    IBOutlet NSTimer *timer;
}

-(IBAction)menuLClicked:(id)sender;

-(IBAction)btn_BackClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_Proceed;
- (IBAction)btn_LoginClicked:(id)sender;
  @property (strong, nonatomic) IBOutlet UIView *gifView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_EventName;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) MainEvent *event;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

@end
