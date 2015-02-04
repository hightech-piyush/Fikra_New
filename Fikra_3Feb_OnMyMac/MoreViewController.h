//
//  MoreViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "Reachability.h"
@interface MoreViewController : UIViewController<EGORefreshTableHeaderDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate>



{
    NSArray *tableData;
    NSArray *tableData1;
    NSArray *tableData2;
    BOOL ISLeft;
    CGFloat NewViewtoLeft;
    IBOutlet UITableView *tbl_Slider;
    NSMutableArray *sliderArray;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
    
    NSString *strShareText;
    NetworkStatus hostStatus;
    IBOutlet UIButton *btn_Menu;
    IBOutlet UIView *slide_View;
    IBOutlet UITableView *tbl_More;
    NSArray *arr;
    NSMutableData *receivedData;
    NSString *checkSwith_Status;
    NSURLConnection *updateURLConnection;
    

IBOutlet UIImageView *img_animation;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
    @property (strong, nonatomic) IBOutlet UIView *gifView;
@property(nonatomic,retain)UIDocumentInteractionController *docFile;
-(IBAction)menuLClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
@property (nonatomic,retain) NSMutableArray*imgArry;
@property (nonatomic,retain) NSMutableArray*imgArry1;
@property (nonatomic,retain) NSMutableArray*imgArry2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
@end

