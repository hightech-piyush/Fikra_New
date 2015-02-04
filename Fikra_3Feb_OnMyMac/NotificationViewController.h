//
//  NotificationViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "Sqlite.h"
@interface NotificationViewController : UIViewController<EGORefreshTableHeaderDelegate,UIGestureRecognizerDelegate,NSURLConnectionDelegate,UITextFieldDelegate,UIScrollViewDelegate,NSURLConnectionDelegate>
{
    NSMutableArray *date_Array;
    NSMutableArray *description_Array;
    IBOutlet UITableView *tbl_notification;
    NSMutableArray *notification_Array;
       BOOL ISLeft;
      NSString *str_registerId;
      IBOutlet UIView *slide_View;
    BOOL isScroll;
        NSMutableData *receivedData;
    BOOL isPullDrag;
    IBOutlet UIButton *btn_Menu;
     NSDictionary *dictNotifs;
    Sqlite *dbobj;
    IBOutlet UIImageView *img_animation;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
    
 
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;

@property (strong, nonatomic) IBOutlet UIView *gifView;
-(IBAction)menuLClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_Search;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblNoFound;

@end
