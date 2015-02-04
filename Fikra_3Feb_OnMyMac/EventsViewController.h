//
//  EventsViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

#import "Sqlite.h"
#import "Reachability.h"


@interface EventsViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
       IBOutlet UITableView *event_Table;
    IBOutlet UIView *slide_View;
   // IBOutlet UIView *main_View;
    NSMutableArray *event_Array;
    NSMutableArray *img_eventArray;
      CGFloat curX;
    IBOutlet UITableView *tbl_Slider;
    NSMutableArray *sliderArray;
    BOOL ISLeft;
    BOOL isAnimatedLastRow;
NetworkStatus hostStatus;
    BOOL animating;
    NSInteger j;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
    IBOutlet UILabel *lbl_Advertisement;
    IBOutlet UIImageView *img_Advertisement;

IBOutlet UIView *view_Advertisement;
    NSString *str_link_advertisement;
    NSString *str_advertisementID;

      BOOL isScroll;
      BOOL isPullDrag;
    IBOutlet UIButton *btn_Menu;
    Sqlite *dbobj;
    IBOutlet UIImageView *img_animation;
   }
@property (strong, nonatomic) IBOutlet UIView *gifView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
@property(assign,getter=isReloading) BOOL reloading;
-(IBAction)menuLClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_Search;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblNoFound;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
@end

