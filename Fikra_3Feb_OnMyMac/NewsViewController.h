//
//  NewsViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "Sqlite.h"
#import "News.h"
#import "Reachability.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown,
} ScrollDirection;


@class EGORefreshTableFooterView;
@interface NewsViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate,NSURLConnectionDelegate>
{
       EGORefreshTableFooterView *refreshFooterView;
    IBOutlet UITableView *NewsTable;
    IBOutlet UITableView *tbl_Slider;
    IBOutlet UIView *slide_View;
    //IBOutlet UIView *main_View;
       // IBOutlet UIView *touch_View;
    NSMutableArray *sliderArray;
    NSMutableArray *newsArray;
    BOOL animating;
    BOOL hasFound;
    NSString *searchText;
    NSInteger j;
    BOOL isAnimatedLastRow;
          BOOL isScroll;
    IBOutlet UIButton *btn_Menu;
    NSDictionary *dictnews;
    NSMutableArray *aryNews;
       NSMutableArray *aryFiltered;
    NSMutableData *receivedData;
  NSString *str_WebServiceCheck;
    Sqlite *dbobj;
      NetworkStatus hostStatus;
    IBOutlet UIImageView *img_animation;
    UIView * footerView;
    IBOutlet UIView *view_Logout;
     IBOutlet UIView *view_Logout_Second;
    IBOutlet UIImageView *img_Advertisement;

           IBOutlet UIButton *btn_Advertisement;
   }
-(IBAction)btn_Advertisement_image_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *gifView;
@property(assign,getter=isReloading) BOOL reloading;
@property (strong, nonatomic) IBOutlet UIView *gifContainer;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@property(nonatomic,retain) IBOutlet UITextField *txt_Search;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UILabel *lblNoFound;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
-(IBAction)menuLClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
- (IBAction)btn_advertisement_Closed:(id)sender;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;

@end
