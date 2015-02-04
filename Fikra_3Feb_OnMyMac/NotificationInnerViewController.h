//
//  NotificationInnerViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"
#import "MarqueeLabel.h"
@interface NotificationInnerViewController : UIViewController<UIGestureRecognizerDelegate>

{
    IBOutlet UILabel *lbleventDetail;
    NSMutableArray *sliderArray;
    IBOutlet UITableView *tbl_Slider;
    BOOL animating;
    NSInteger j;
    BOOL isAnimatedLastRow;
    BOOL ISLeft;
    CGFloat NewViewtoLeft;
    BOOL isScroll;
    IBOutlet UIButton *btn_Menu;
      IBOutlet UIView *slide_View;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;

}
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;

-(IBAction)menuLClicked:(id)sender;
-(IBAction)btn_BackClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *lbl_event_Title;
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_event_Name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_event_first;
@property (strong, nonatomic) IBOutlet UILabel *lbl_event_Second;
@property (strong, nonatomic) IBOutlet UILabel *lbl_header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_headersecond;

@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

@property (nonatomic, strong) Notification *notification;
@end
