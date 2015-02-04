//
//  NewsDetailViewController.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "News.h"
#import "MarqueeLabel.h"
@interface NewsDetailViewController : UIViewController<UITextFieldDelegate,EGORefreshTableHeaderDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIDocumentInteractionControllerDelegate>
{
   
     NSMutableArray *newsArray;
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
    NSString  *strLink;
    NSString *path;
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
  
}
@property(nonatomic,retain)UIDocumentInteractionController *docFile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;
-(IBAction)menuLClicked:(id)sender;
-(IBAction)btn_BackClicked:(id)sender;
-(IBAction)btn_Share_Clicked:(id)sender;
-(IBAction)btn_Link_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Header;
@property (strong, nonatomic) IBOutlet UILabel *lbl_EventName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_FirstHeader;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *newsSubTitle;
@property (strong, nonatomic) IBOutlet UILabel *newsSubTitle2;
@property (strong, nonatomic) IBOutlet UITextView *txtvDesc;
@property (strong, nonatomic) IBOutlet UILabel *descbg;
//@property(nonatomic,retain)UIDocumentInteractionController *docFile;
//@property (strong, nonatomic) IBOutlet UILabel *lbl_event_Title;
//@property (strong, nonatomic) IBOutlet UILabel *lbl_event_Name;
//@property (strong, nonatomic) IBOutlet UILabel *lbl_event_first;
//@property (strong, nonatomic) IBOutlet UILabel *lbl_event_Second;

@property(nonatomic,retain) IBOutlet UIView *main_View;
@property (strong, nonatomic) News *news;
- (IBAction)btn_LoginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@end

