//
//  NewsViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NotificationViewController.h"
#import "EventsViewController.h"
#import "MoreViewController.h"
#import "NewsDetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SliderTableViewCell.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "News.h"
#import "MFSideMenu.h"
#import "Constant.h"
#import "MFSideMenu/MFSideMenu.h"



#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface NewsViewController ()

@end

@implementation NewsViewController

{
    NSInteger visibleRows;
    NSInteger thresholdValue;
    NSInteger thresholdValues;
    BOOL canLoadMore;
    CGFloat lastContentOffset;
    NSMutableArray *aryOfSubArrays;

    
    
    
    CGPoint translatedPoint;
    NSInteger _firstX;
    NSInteger _firstY;
    NSInteger numberofView;
    CGSize viewSize;
    
    BOOL isBegan;

    EGORefreshTableHeaderView *_refreshHeaderView;
    
    NSURLConnection *updateURLConnection;
    NSURLConnection *newsConnection;
 }

@synthesize main_View;
@synthesize reloading=_reloading;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark DATABASE OPEN

-(void)databaseOpen
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *myDBnew=[documentsDirectory stringByAppendingPathComponent:@"FikraDB.sqlite"];
    dbobj =[[Sqlite alloc]init];
    [dbobj open:myDBnew];
    //NSLog(@"Database Opened");
    
}

#pragma mark INSERT NEWS INTO DATABASE

-(void)insertIntoNews:(News *)news
{
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into news (addedOn,description,link,status,subtitle1,subtitle2,title,news_web_id) values ('%@','%@','%@','%@','%@','%@','%@','%@')",news.addOn,news.description,news.link,news.status,news.subtitle1,news.subtitle2,news.title,news.str_id];
    BOOL success = [dbobj executeNonQuery:q];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark DELETE NEWS FROM DATABASE

-(void)deleteFromNews
{
    [self databaseOpen];
    NSString *dq=[NSString stringWithFormat:@"Delete from news"];
    BOOL success = [dbobj executeNonQuery:dq];
    if (success) {
        
    }else
    {}
    [dbobj close];
}
//#pragma mark UPDATE ENTRY INTO DATABASE
//
//-(void)updateCalendar:(News *)news
//{
//    [self databaseOpen];
//    NSString *q=[NSString stringWithFormat:@"update Calendar set title= '%@',foldername= '%@',type= '%@',priority= '%@',focus= '%@',startdate= '%@',enddate= '%@',reminddate= '%@',remindtext= '%@', folderid = %d,color='%@',status='%@' where entryid=%d",calendar.strTitle,calendar.strFolderName,calendar.strType,calendar.strPriority,calendar.strFocus,calendar.strStartDate,calendar.strEndDate,calendar.strRemindDate,calendar.strRemindText,calendar.folderid,calendar.strColor,calendar.strStatus,calendar.entryId];
//    [dbobj executeNonQuery:q];
//    [dbobj close];
//}


#pragma mark SELECT CALENDAR TO GET CALENDAR ENTRIES

-(NSArray *)selectFromNews
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from news"];
    NSArray * aryNews_=[dbobj executeQuery:cq];
    [dbobj close];
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    
    NSMutableArray *aryNews__ = [@[] mutableCopy];
    for (NSDictionary *dictNews in aryNews_) {
        NSString *strID = [dictNews valueForKey:@"news_web_id"];
        News *news = [self selectFromNewsWhereNewsID:strID];
        [aryNews__ addObject:news];
    }

    

         return aryNews__;
}


-(NSArray *)selectFromNews_ForRealData
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from news"];
    NSArray * aryNews_=[dbobj executeQuery:cq];
    [dbobj close];
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    
    
    return aryNews_;
}

#pragma mark SELECT EVENT FOR SPECIFIC EVENT ID

-(News *)selectFromNewsWhereNewsID:(NSString *)newsID
{
    //int event_id = [eventID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from news where news_web_id = %@",newsID];
    NSArray * aryNews_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictNews = [aryNews_ objectAtIndex:0];
    
    
    NSString *st_id =[dictNews valueForKey:@"news_web_id"];
    NSString *date = [dictNews valueForKey:@"addedOn"];
    NSString *description =[dictNews valueForKey:@"description"];
    NSString *link = [dictNews valueForKey:@"link"];
    NSString *subtitle1 = [dictNews valueForKey:@"subtitle1"];
    NSString *subtitle2 =[dictNews valueForKey:@"subtitle2"];
    NSString *title = [dictNews valueForKey:@"title"];
    
    //NSString *title_ = [dictNews valueForKey:@"title"];
    
    //NSDate *dateTitle = [self getDateFromString:title_];
    //NSString *title = [self getStringDateFromDate:dateTitle];
    
    News *newssub = [[News alloc] init];
    newssub.str_id=st_id;
    newssub.addOn=date;
    newssub.description=description;
    newssub.link=link;
    newssub.subtitle1=subtitle1;
    newssub.subtitle2=subtitle2;
    newssub.title=title;
    
    
    
    
    
    return newssub;
}



#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
    
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        [[NSUserDefaults standardUserDefaults] setValue:FromNews forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    
   else if ([loginStatus isEqualToString:@"0"]) {
       [[NSUserDefaults standardUserDefaults] setValue:FromNews forKey:kScreen];
       [[NSUserDefaults standardUserDefaults] synchronize];
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    else
    {
         view_Logout.hidden=NO;
        view_Logout_Second.hidden=NO;

    }
    
    
 
}


-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

#pragma mark - View Method



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update_YorN_WebService_Called_news) name:kUpdateNotificationNews object:nil];
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

      view_Logout_Second.hidden=YES;

      [self loadGIF_View];
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];

    if (IS_IPHONE5) {
        
        //  dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,518,320,50)];
        //  dot.image=[UIImage imageNamed:@"voicechat-header-1.png"];
        //  [self.view addSubview:dot];
        
        [button addTarget:self
                   action:@selector(aMethod)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.frame = CGRectMake(0,518,80,50);
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button];
        
        
        
        [button1 addTarget:self
                    action:@selector(aMethod1)
          forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        button1.frame = CGRectMake(80,518,80,50);
        [button1 setImage:[UIImage imageNamed:@"news_active.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"news_active.png"] forState:UIControlStateSelected];
        [self.view addSubview:button1];
        
        
        
        
        [button2 addTarget:self
                    action:@selector(aMethod2)
          forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitle:@"" forState:UIControlStateNormal];
        button2.frame = CGRectMake(160,518,80,50);
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button2];
        
        
        
        [button3 addTarget:self
                    action:@selector(aMethod3)
          forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitle:@"" forState:UIControlStateNormal];
        button3.frame = CGRectMake(240,518,80,50);
        [button3 setImage:[UIImage imageNamed:@"more_inactive.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"more_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button3];
        
     }
    else
    {
        //         dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,430,320,50)];
        //         dot.image=[UIImage imageNamed:@"voicechat-header-1.png"];
        //         [self.view addSubview:dot];
        
        [button addTarget:self
                   action:@selector(aMethod)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.frame = CGRectMake(0,430,80,50);
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button];
        
        
        
        [button1 addTarget:self
                    action:@selector(aMethod1)
          forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        button1.frame = CGRectMake(80,430,80,50);
        [button1 setImage:[UIImage imageNamed:@"news_active.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"news_active.png"] forState:UIControlStateSelected];
        [self.view addSubview:button1];
        
        
        
        
        [button2 addTarget:self
                    action:@selector(aMethod2)
          forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitle:@"" forState:UIControlStateNormal];
        button2.frame = CGRectMake(160,430,80,50);
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateSelected];        [self.view addSubview:button2];
        
        
        
        [button3 addTarget:self
                    action:@selector(aMethod3)
          forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitle:@"" forState:UIControlStateNormal];
        button3.frame = CGRectMake(240,430,80,50);
        [button3 setImage:[UIImage imageNamed:@"more_inactive.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"more_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button3];
        
        
    }

    
    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:NewsTable.frame];
    view.delegate = self;
    [main_View insertSubview:view belowSubview:NewsTable];
    _refreshHeaderView = view;
    _refreshHeaderView.hidden=YES;
    
      [self initFooterView];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    
    
    [self performSelector:@selector(update_YorN_WebService_Called_news) withObject:nil afterDelay:3.0];

    
  
    
    
 
    //[self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
 

    // Do any additional setup after loading the view.
}



-(void)initFooterView
{
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    
    UIActivityIndicatorView * actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    actInd.tag = 10;
    
    actInd.frame = CGRectMake(150.0, 5.0, 20.0, 20.0);
    
    actInd.hidesWhenStopped = YES;
    
    [footerView addSubview:actInd];
    
    actInd = nil;
}


-(void)update_YorN_WebService_Called_news
{
    
    visibleRows = 10;
    thresholdValue = 0;
    
    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
    [_lblNoFound setFont:lblFont];
    _lblNoFound.hidden = YES;
    _gifView.hidden = NO;
    img_animation.hidden = NO;
  
    str_WebServiceCheck=@"6000";
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?screen=news&device_id=%@",ConstantPATH,UpdateURL,app.deviceToke1]];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    updateURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( updateURLConnection )
    {
        receivedData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

-(void)loadGIF_View
{
    
    
    img_animation.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed: @"btn_1.png"],
                                     [UIImage imageNamed: @"btn_2.png"],
                                     [UIImage imageNamed: @"btn_3.png"],
                                     [UIImage imageNamed: @"btn_4.png"],
                                     [UIImage imageNamed: @"btn_5.png"],
                                     [UIImage imageNamed: @"btn_6.png"] ,nil];
    img_animation.animationDuration = 1.0f; // about 30fps with your 13 images.
    //Set gordon's frame here
    [img_animation startAnimating];

    }


-(void)viewWillAppear:(BOOL)animated
{
    //[self addTapGesture];
    // touch_View.hidden=YES;
    [super viewWillAppear:animated];
    view_Logout.hidden=YES;
     view_Logout_Second.hidden=YES;
//    _gifView.hidden = NO;
//    img_animation.hidden = NO;
//  
//    [self loadGIF_View];
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
    }else
    {
        UIImage *logoutImage = [UIImage imageNamed:@"logout-icon_New.png"];
        [_btnLogin setImage:logoutImage forState:UIControlStateNormal];
        
    }
    [_txt_Search setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    UIFont *font = [UIFont fontWithDescriptor:afont size:16.0];
    _txt_Search.font = font;
      [UIView setAnimationsEnabled:YES];
       animating=TRUE;
   
    isAnimatedLastRow=TRUE;
  
      UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
[self performSelector:@selector(update_YorN_WebService_Called_news) withObject:nil afterDelay:3.0];
    
//    if ([newsArray count]==0) {
//        UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//        UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:16.0];
//        [_lblNoFound setFont:lblFont];
//        _lblNoFound.hidden = NO;
//    }else
//    {
//        UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//        UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:16.0];
//        [_lblNoFound setFont:lblFont];
//        _lblNoFound.hidden = YES;
//    }
    
     //    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
//    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [rightRecognizer setNumberOfTouchesRequired:1];
//    [main_View addGestureRecognizer:rightRecognizer];
//
//    //........towards left Gesture recogniser for swiping.....//
//    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
//    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [leftRecognizer setNumberOfTouchesRequired:1];
//    [main_View addGestureRecognizer:leftRecognizer];

       
}



#pragma mark - TEXT FIELD...
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    NSString *searchText = textField.text;
    //    NSArray *aryProps = [dictProperty valueForKey:@"PaymentHistory"];
    //
    //    aryFoundNotifs = [aryProps filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"property_name beginswith[cd] %@", searchText]];
    //    NSLog(@"ary found = %@",aryFoundNotifs);
    searchText = textField.text;
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NewsTable.tableFooterView = nil;
    if ([searchText length]==0) {
        _refreshHeaderView.hidden=YES;
        searchText = string;
        
    }else
    {
        if ([string length]==0) {
            searchText =[searchText substringToIndex:[searchText length]-1];
            //if ([searchText length]==0) {
            _refreshHeaderView.hidden=NO;
            
            
            //              }
        }else
        {
            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
            
        }
        
    }
    
    if ([searchText length]==0) {
        _refreshHeaderView.hidden=YES;
        
        NSArray *aryEvents_ = [dictnews valueForKey:@"news"];
        aryNews = [@[] mutableCopy];
        
        for (NSDictionary *dict in aryEvents_) {
            News *news = [self getNews:dict];
            [aryNews addObject:news];
        }
        NSLog(@"ary Events = %@",aryNews);
        if ([aryNews count]==0) {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = YES;
            NewsTable.tableFooterView = nil;
        }else
        {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = YES;
            NewsTable.tableFooterView = nil;
        }
        hasFound = NO;
        [NewsTable reloadData];
        //_refreshHeaderView.hidden=NO;
    }else
    {
        _refreshHeaderView.hidden=YES;
        NSArray *aryEvents_ = [self selectFromNews_ForRealData];//[dictnews valueForKey:@"news"];
        NSArray *aryFoundEvents = [aryEvents_ filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"subtitle1 CONTAINS[cd] %@", searchText]];
        NSLog(@"ary found = %@",aryFoundEvents);
        
        aryFiltered = [@[] mutableCopy];
        for (NSDictionary *dict in aryFoundEvents) {
            NSString *strID = [dict valueForKey:@"news_web_id"];
            News *news = [self selectFromNewsWhereNewsID:strID];//[self getNews:dict];
            [aryFiltered addObject:news];
        }
        
        NSLog(@"ary Props = %@",aryFiltered);
        
        if ([aryFiltered count]==0) {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = NO;
            NewsTable.tableFooterView = nil;
            _refreshHeaderView.hidden=YES;
            
        }else
        {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = YES;
            NewsTable.tableFooterView = nil;
            
        }
        
        hasFound = YES;
        [NewsTable reloadData];
    }
    
    return YES;
//      NewsTable.tableFooterView = nil;
//    if ([searchText length]==0) {
//        _refreshHeaderView.hidden=YES;
//        searchText = string;
//        
//    }else
//    {
//        if ([string length]==0) {
//            searchText =[searchText substringToIndex:[searchText length]-1];
//            //if ([searchText length]==0) {
//                   _refreshHeaderView.hidden=NO;
//           
//
//            //              }
//        }else
//        {
//            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
//            
//        }
//        
//    }
//    
//    if ([searchText length]==0) {
//        _refreshHeaderView.hidden=YES;
//
//        NSArray *aryEvents_ = [dictnews valueForKey:@"news"];
//        aryNews = [@[] mutableCopy];
//        
//        for (NSDictionary *dict in aryEvents_) {
//            News *news = [self getNews:dict];
//            [aryNews addObject:news];
//        }
//        NSLog(@"ary Events = %@",aryNews);
//        if ([aryNews count]==0) {
//            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
//            [_lblNoFound setFont:lblFont];
//            _lblNoFound.hidden = YES;
//              NewsTable.tableFooterView = nil;
//        }else
//        {
//            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
//            [_lblNoFound setFont:lblFont];
//            _lblNoFound.hidden = YES;
//               NewsTable.tableFooterView = nil;
//        }
//        hasFound = NO;
//        [NewsTable reloadData];
//         //_refreshHeaderView.hidden=NO;
//    }else
//    {
//         _refreshHeaderView.hidden=YES;
//        NSArray *aryEvents_ = [self selectFromNews_ForRealData];//[dictnews valueForKey:@"news"];
//       // NSArray *aryFoundEvents = [aryEvents_ filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText]];
//            NSArray *aryFoundEvents = [aryEvents_ filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText]];
//        NSLog(@"ary found = %@",aryFoundEvents);
//        
//        aryFiltered = [@[] mutableCopy];
//        for (NSDictionary *dict in aryFoundEvents) {
//            NSString *strID = [dict valueForKey:@"news_web_id"];
//            News *news = [self selectFromNewsWhereNewsID:strID];//[self getNews:dict];
//            [aryFiltered addObject:news];
//        }
//    
//        NSLog(@"ary Props = %@",aryFiltered);
//        
//        if ([aryFiltered count]==0) {
//            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
//            [_lblNoFound setFont:lblFont];
//            _lblNoFound.hidden = NO;
//             NewsTable.tableFooterView = nil;
//            _refreshHeaderView.hidden=YES;
//
//        }else
//        {
//            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
//            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
//            [_lblNoFound setFont:lblFont];
//            _lblNoFound.hidden = YES;
//            NewsTable.tableFooterView = nil;
//            
//        }
//        
//        hasFound = YES;
//        [NewsTable reloadData];
//    }
//    
//    return YES;
}



-(void)News_WS_Called

{
    
    
    //str_WebServiceCheck=@"1000";
      AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@device_id=%@&status=0",ConstantPATH,NewsURl,app.deviceToke1]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    newsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( newsConnection )
	{
		receivedData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
    

    

}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength: 0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
//    NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
//    NSLog(@"%@",dictTemp);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSArray *aryNews_ = [self selectFromNews];
    if ([aryNews_ count]==0) {
        //
        //        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connect.Tap Retry to try again" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
        //        [al show];
        //        al.tag=2000;
        
        
        Reachability *hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];
        
        hostStatus=[hostReach currentReachabilityStatus];
        if (hostStatus ==NotReachable) {
            [self performSelector:@selector(connectionLostview) withObject:nil];
        }
        else{
            
            [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
            
        }
        
        
    }
    else{
        if (newsArray) {
            [newsArray removeAllObjects];
        }else
        {
            newsArray = [@[] mutableCopy];
        }
        
        //    for (NSDictionary *dictNewss in aryNews_)
        //    {
        //        News *news = [self getNews:dictNewss];
        //        [newsArray addObject:news];
        //    }
        newsArray = [aryNews_ mutableCopy];
        [NewsTable reloadData];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
        NSLog(@"ERROR with theConenction");
	}
}


#pragma mark ---GET DATE IN EITHER STRING OR DATE TYPE
-(NSDate *)getDateFromString:(NSString *)strDate
{
    
    NSDateFormatter *tempFormatter2 = [[NSDateFormatter alloc]init];
    [tempFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateWithoutTime = [tempFormatter2 dateFromString:strDate];
    return dateWithoutTime;
}

-(NSString *)getStringDateFromDate:(NSDate *)buttonDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY HH:mm"];
    NSString *strDate = [df stringFromDate:buttonDate];
    return strDate;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection == newsConnection) {
            if(receivedData)
        {
            if ([newsArray count]) {
                [newsArray removeAllObjects];

            }
                     NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
          // newsArray = [@[] mutableCopy];
            if (dictTemp)
            {
                dictnews = @{};
                dictnews =dictTemp;
            
            
            NSArray *arrCountry = [dictTemp valueForKey:@"news"];
            
                if ([arrCountry count]!=0) {
                    [self deleteFromNews];
                }
            for (NSDictionary *dictNewss in arrCountry) {
                News *news = [self getNews:dictNewss];
                [self insertIntoNews:news];
               // [newsArray addObject:news];
            }
                
                NSArray *aryNews_ = [self selectFromNews];
                NSLog(@"LOCAL NEWS = %@",aryNews_);
                
                NSInteger remainingItems = [aryNews_ count];
                aryOfSubArrays = [@[] mutableCopy];
                thresholdValues = 0;
               
                while (thresholdValues<[aryNews_ count])
                {
                    NSRange range = NSMakeRange(thresholdValues, MIN(visibleRows, remainingItems));
                    NSArray *subarray = [aryNews_ subarrayWithRange:range];
                    [aryOfSubArrays addObject:subarray];
                    remainingItems-=range.length;
                    thresholdValues+=range.length;
                }
                
                
                if ([aryNews_ count]<visibleRows)
                {
                    //newsArray = [aryNews_ mutableCopy];

                    newsArray = [aryNews_ mutableCopy];
                    canLoadMore = NO;
                    thresholdValue = thresholdValue + 1;
                }else
                {
                    
                    if (thresholdValue == 0) {
                        NSArray *subArray = [aryOfSubArrays objectAtIndex:thresholdValue];
                        for (News *news in subArray) {
                            [newsArray addObject:news];
                        }
                        thresholdValue=thresholdValue+1;
                    }
                    //thresholdValue = newsArray.count;
                    if (thresholdValue < [aryNews_ count])
                    {
                        //data still exists in main array.
                        canLoadMore = YES;
                    }else
                    {
                        //data does not exists..
                        canLoadMore = NO;
                    }
                }
                
                
                NSLog(@"Final News array = %@",newsArray);
                if ([newsArray count]==0) {
                    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
                    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
                    [_lblNoFound setFont:lblFont];
                    _lblNoFound.hidden = NO;
                }else
                {
                    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
                    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
                    [_lblNoFound setFont:lblFont];
                    _lblNoFound.hidden = YES;
                }
          //            if (refreshFooterView == nil) {
//                refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, [self tableViewHeight], 320.0f, 600.0f)];
//                refreshFooterView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
//                [NewsTable addSubview:refreshFooterView];
//                NewsTable.showsVerticalScrollIndicator = YES;
//                
//            }
            [NewsTable reloadData];
                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
                 [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
            }
        }
    }
    else if  (connection == updateURLConnection) {
        if(receivedData)
        {
            NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
            NSArray *aryStatus = [dictTemp valueForKey:@"Regiaster_check"];
            NSDictionary *dictStatus = [aryStatus objectAtIndex:0];
            NSString *status = [dictStatus valueForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                if (newsArray) {
                    [newsArray removeAllObjects];
                    //  [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
                }else
                {
                    newsArray = [@[] mutableCopy];
                }
                [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
                
            }else
            {
                NSArray *aryNews_ = [self selectFromNews];
                if ([aryNews_ count]==0) {
                    [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
                }
                if ([newsArray count]!=0) {
                    [newsArray removeAllObjects];
                    [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];

                }else
                {
                    newsArray = [@[] mutableCopy];
                }
                
                
                NSInteger remainingItems = [aryNews_ count];
                aryOfSubArrays = [@[] mutableCopy];
                thresholdValues = 0;
                
                while (thresholdValues<[aryNews_ count])
                {
                    NSRange range = NSMakeRange(thresholdValues, MIN(visibleRows, remainingItems));
                    NSArray *subarray = [aryNews_ subarrayWithRange:range];
                    [aryOfSubArrays addObject:subarray];
                    remainingItems-=range.length;
                    thresholdValues+=range.length;
                }
                
                
                if ([aryNews_ count]<visibleRows) {
                    //                newsArray = [aryNews_ mutableCopy];
                    
                    newsArray = [aryNews_ mutableCopy];
                    canLoadMore = NO;
                    thresholdValue = newsArray.count;
                }else
                {
                    /*for (int i =0; i<visibleRows; i++)
                     {
                     News *news = [aryNews_ objectAtIndex:i];
                     [newsArray addObject:news];
                     }*/
                    
                    if (thresholdValue == 0) {
                        NSArray *subArray = [aryOfSubArrays objectAtIndex:thresholdValue];
                        for (News *news in subArray) {
                            [newsArray addObject:news];
                        }
                        thresholdValue=thresholdValue+1;
                    }
                    //thresholdValue = newsArray.count;
                    if (thresholdValue < [aryNews_ count])
                    {
                        //data still exists in main array.
                        canLoadMore = YES;
                    }else
                    {
                        //data does not exists..
                        canLoadMore = NO;
                    }
                }

                
                
                
                
                //newsArray = [aryNews_ mutableCopy];
                if ([newsArray count]==0) {
                    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
                    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
                    [_lblNoFound setFont:lblFont];
                    _lblNoFound.hidden = NO;
                }else
                {
                    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
                    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
                    [_lblNoFound setFont:lblFont];
                    _lblNoFound.hidden = YES;
                }
//                for (NSDictionary *dictNewss in aryNews_)
//                {
//                    News *news = [self getNews:dictNewss];
//                    
//                    [newsArray addObject:news];
//                }
                [NewsTable reloadData];
                [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
            }
            
        }
        
    }
       
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==2000) {
//        if (buttonIndex==0) {
//            
//        
//        [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
//        }
//    }
//}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==9999) {
        if (buttonIndex==0) {
            
            
            [self performSelector:@selector(News_WS_Called) withObject:nil afterDelay:0.2];
        }
    }
   
   }


-(void)connectionLostview
{
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connection.Tap Retry to try again" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
    [al show];
    al.tag=9999;
    
}

-(void)removeGIF_View
{
    _gifView.hidden = YES;
    img_animation.hidden = YES;
 }


-(News *)getNews:(NSDictionary *)dictNews
{
    NSString *st_id =[dictNews valueForKey:@"id"];
    NSString *date = [dictNews valueForKey:@"addedOn"];
    NSString *description =[dictNews valueForKey:@"description"];
    NSString *link = [dictNews valueForKey:@"link"];
    NSString *subtitle1 = [dictNews valueForKey:@"subtitle1"];
    NSString *subtitle2 =[dictNews valueForKey:@"subtitle2"];
    NSString *title_ = [dictNews valueForKey:@"title"];
    
    NSDate *dateTitle = [self getDateFromString:title_];
    NSString *title = [self getStringDateFromDate:dateTitle];
    
    News *newssub = [[News alloc] init];
    newssub.str_id=st_id;
     newssub.addOn=date;
     newssub.description=description;
     newssub.link=link;
     newssub.subtitle1=subtitle1;
     newssub.subtitle2=subtitle2;
     newssub.title=title;
  
    
    //nationality.countryID = countryID;
    //nationality.name = name;
    
   // NSLog(@"%@",nationality);
    return newssub;
}
#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Tab bar button Clicked


-(void)aMethod
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    [self.navigationController pushViewController:verify animated:NO];

}

-(void)aMethod1{
  
  }
-(void)aMethod2{
  
    NotificationViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"noti"];
    [self.navigationController pushViewController:verify animated:NO];
}
-(void)aMethod3{
    
    MoreViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"more"];
    [self.navigationController pushViewController:verify animated:NO];
    
}




-(void)addNewsAtBottom
{
    NSArray *aryNews_ = [self selectFromNews];
    NSLog(@"LOCAL NEWS = %@",aryNews_);
   
    if (thresholdValue!=[aryOfSubArrays count])
    {
        if (canLoadMore) {
            NSArray *subArray = [aryOfSubArrays objectAtIndex:thresholdValue];
            for (News *news in subArray)
            {
                [newsArray addObject:news];
                
            }
            
            thresholdValue = thresholdValue+1;
            
            if (thresholdValue<[aryOfSubArrays count])
            {
                canLoadMore = YES;
                
            }else
            {
                //isAnimatedLastRow = NO;
                //animating = NO;
                
                
                canLoadMore = NO;
            }
        }
        
    }
    
    else
        
    {
        canLoadMore = NO;
       // [footerView removeFromSuperview];
      NewsTable.tableFooterView = nil;

    }
    NSLog(@"Final News array = %@",newsArray);
      [NewsTable reloadData];
    
    
}



#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{  NSLog(@"scrollViewWillBeginDragging");
    _refreshHeaderView.hidden=NO;
    NewsTable.tableFooterView=nil;
         [_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
  }

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{ NSLog(@"scrollViewDidScroll");
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
      [self initFooterView];
    
    if (aryFiltered.count) {
        _refreshHeaderView.hidden=NO;
    }
    else
    {
        if ((newsArray.count)&&([_txt_Search.text length]==0)) {
            _refreshHeaderView.hidden=NO;

        }
        else
        {
            _refreshHeaderView.hidden=YES;

        }
    }
    
    
    
    if ([_txt_Search.text length]>0)
    {
         NewsTable.tableFooterView = nil;
    }
    else
    {
        NewsTable.tableFooterView = footerView;

    }
    
    [(UIActivityIndicatorView *)[footerView viewWithTag:10] startAnimating];

//
//    ScrollDirection scrollDirection;
//    
//    if (lastContentOffset<scrollView.contentOffset.y) {
//        scrollDirection = ScrollDirectionUp;
//    }else
//    {
//        canLoadMore = NO;
//        scrollDirection = ScrollDirectionDown;
//    }
//    
//    lastContentOffset = scrollView.contentOffset.y;
//    
//    if (canLoadMore) {
//        if (scrollDirection == ScrollDirectionUp) {
//            [self addNewsAtBottom];
//        }else
//        {
//            return;
//        }
//    }else
//    {
//        
//    }
//
    
    
//    CGPoint offset = scrollView.contentOffset;
//    CGRect bounds = scrollView.bounds;
//    CGSize size = scrollView.contentSize;
//    UIEdgeInsets inset = scrollView.contentInset;
//    float y = offset.y + bounds.size.height - inset.bottom;
//    float h = size.height;
//    // NSLog(@"offset: %f", offset.y);
//    // NSLog(@"content.height: %f", size.height);
//    // NSLog(@"bounds.height: %f", bounds.size.height);
//    // NSLog(@"inset.top: %f", inset.top);
//    // NSLog(@"inset.bottom: %f", inset.bottom);
//    // NSLog(@"pos: %f of %f", y, h);
//    
//    float reload_distance = 10;
//    if(y > h + reload_distance)
//    {
//        if (canLoadMore)
//        {
//            //[self performSelector:@selector(addNewsAtBottom) withObject:nil afterDelay:2.0];
//            [self addNewsAtBottom];
//        }else
//        {
//            return;
//        }
//    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{  NSLog(@"scrollViewDidEndDecelerating");

    
    NSArray *visibleRowsAry = [NewsTable visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRowsAry lastObject];
    NSIndexPath *path = [NewsTable indexPathForCell:lastVisibleCell];
    
    if(path.row == newsArray.count-1)
    {
          [self addNewsAtBottom];
        
        NewsTable.tableFooterView = nil;

       // footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 0.0)];
    }
    
    //BOOL endOfTable = (scrollView.contentOffset.y >= ((visibleRowsAry.count * 40) - scrollView.frame.size.height)); // Here 40 is row height
    
    //[main_View removeGestureRecognizer:swipegestureRecognizer];
}


- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[NewsTable setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
  
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{ NSLog(@"scrollViewDidEndDragging");
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    	}

           
  



#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self performSelector:@selector(update_YorN_WebService_Called_news) withObject:nil afterDelay:3.0];
 	//[self News_WS_Called];
	[self reloadTableViewDataSource];


}
#pragma mark - Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
              //[main_View addGestureRecognizer:swipegestureRecognizer];
            _refreshHeaderView.loading = YES;
   	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
 
}

- (void)doneLoadingTableViewData

{
  
    _refreshHeaderView.loading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:NewsTable];
     NewsTable.tableFooterView = nil;
   
    _refreshHeaderView.hidden=YES;
 [self dataSourceDidFinishLoadingNewData];
    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==NewsTable) {
        
        
        return 45;
    }
    else if (tableView==tbl_Slider)
    {
        return 47;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==NewsTable) {
        
    
        if (hasFound) {
            return [aryFiltered count];
        }else
        {
            return [newsArray count];
        }

}
       return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==NewsTable) {
    
       // NSLog(@"visible row = %ld",(long)indexPath.row);
        
    
    //1. Get the cell
    static NSString *CellIdentifier = @"Cell";
 
        NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = (NewsTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    j=indexPath.row;
    //3. Setup the cell
    
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    [cell.lbl_Event setFont:[UIFont fontWithDescriptor:afont size:24.0]];
   
    [cell.lbl_Date setFont:[UIFont fontWithDescriptor:afont size:21.0]];
cell.lbl_Date.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    
    [cell.lbl_year setFont:[UIFont fontWithDescriptor:afont size:13.0]];
   // cell.lbl_year.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
        News *news = [[News alloc] init];
       
        
        if (hasFound) {
            news = [aryFiltered objectAtIndex:indexPath.row];
            
        }else
        {
            news = [newsArray objectAtIndex:indexPath.row];
        }

       cell.lbl_Event.text = [news subtitle1];
        NSString *strDate = [news addOn];
        NSArray *arr = [strDate componentsSeparatedByString:@" "];
        NSString *date = [arr objectAtIndex:0];
        //NSLog(@"%@",date);
        NSString *month = [arr objectAtIndex:1];
        //NSLog(@"%@",month);

        NSString *year = [arr objectAtIndex:2];
        //NSLog(@"%@",year);
        
       NSString *year_month = [NSString stringWithFormat:@"%@ %@", month, year];
        NSString *newdate;
        if (date.length==1) {
             newdate = [NSString stringWithFormat:@"0%@",date];
        }
        else if (date.length==2)
        {
            newdate=date;
        }
        cell.lbl_year.text =year_month;
        cell.lbl_Date.text=newdate;
        if ([cell.lbl_Event.text length]>30) {
            cell.lbl_Event.marqueeType = MLContinuous;
            cell.lbl_Event.scrollDuration = 15.0;
            cell.lbl_Event.animationCurve = UIViewAnimationOptionCurveEaseInOut;
            cell.lbl_Event.fadeLength = 10.0f;
            cell.lbl_Event.continuousMarqueeExtraBuffer = 10.0f;
            cell.lbl_Event.tag = 101;
        }
        
    // cell.lbl_Event.text = [newsArray objectAtIndex:indexPath.row];
  //  cell.detailTextLabel.text = [NSString stringWithFormat:@"details for row number %ld",(long)indexPath.row];
  
    
  return cell;
    }
       return nil;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//      return 0;
//
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==NewsTable) {
        
        News *news = [[News alloc] init];
        if (hasFound) {
            news = [aryFiltered objectAtIndex:indexPath.row];
        }else
        {
            news = [newsArray objectAtIndex:indexPath.row];
        }
       
        [[NSUserDefaults standardUserDefaults] setValue:FromNews forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    NewsDetailViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
        verify.news = news;
    [self.navigationController pushViewController:verify animated:NO];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    if(tableView == NewsTable)
    {
        
    
        
    }
}

-(BOOL)isRowZeroVisible {
    NSArray *indexes = [NewsTable indexPathsForVisibleRows];
    for (NSIndexPath *index in indexes) {
        if (index.row == 0) {
            return YES;
        }
    }
    
    return NO;
}


//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if(tableView == NewsTable)
    {
        NSInteger i=newsArray.count;
        
        
        if (i==j+1) {
            if (isAnimatedLastRow==TRUE) {
                
                isAnimatedLastRow=FALSE;
                CATransform3D rotation;
                rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
                rotation.m34 = 1.0/ -600;
                
                
                //2. Define the initial state (Before the animation)
                cell.layer.shadowColor = [[UIColor blackColor]CGColor];
                cell.layer.shadowOffset = CGSizeMake(10, 10);
                cell.alpha = 0;
                
                cell.layer.transform = rotation;
                cell.layer.anchorPoint = CGPointMake(0, 0.5);
                
                //!!!FIX for issue #1 Cell position wrong------------
                if(cell.layer.position.x != 0){
                    cell.layer.position = CGPointMake(0, cell.layer.position.y);
                }
                
                //4. Define the final state (After the animation) and commit the animation
                [UIView beginAnimations:@"" context:NULL];
                [UIView setAnimationDuration:0.8];
                cell.layer.transform = CATransform3DIdentity;
                cell.alpha = 1;
                cell.layer.shadowOffset = CGSizeMake(0, 0);
                [UIView commitAnimations];
                animating=FALSE;
                
            }
            else{
                animating=FALSE;
            }
        }
        else
        {
            if (animating==TRUE) {
                
                CATransform3D rotation;
                rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
                rotation.m34 = 1.0/ -600;
                
                
                //2. Define the initial state (Before the animation)
                cell.layer.shadowColor = [[UIColor blackColor]CGColor];
                cell.layer.shadowOffset = CGSizeMake(10, 10);
                cell.alpha = 0;
                
                cell.layer.transform = rotation;
                cell.layer.anchorPoint = CGPointMake(0, 0.5);
                
                //!!!FIX for issue #1 Cell position wrong------------
                if(cell.layer.position.x != 0){
                    cell.layer.position = CGPointMake(0, cell.layer.position.y);
                }
                
                //4. Define the final state (After the animation) and commit the animation
                [UIView beginAnimations:@"" context:NULL];
                [UIView setAnimationDuration:0.8];
                cell.layer.transform = CATransform3DIdentity;
                cell.alpha = 1;
                cell.layer.shadowOffset = CGSizeMake(0, 0);
                [UIView commitAnimations];
                
            }
            
            else
            {

                [UIView setAnimationsEnabled:YES];
            }
            
        }
        
        //1. Setup the CATransform3D structure
        
//        if (canLoadMore==YES) {
//            CATransform3D rotation;
//            rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//            rotation.m34 = 1.0/ -600;
//            
//            
//            //2. Define the initial state (Before the animation)
//            cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//            cell.layer.shadowOffset = CGSizeMake(10, 10);
//            cell.alpha = 0;
//            
//            cell.layer.transform = rotation;
//            cell.layer.anchorPoint = CGPointMake(0, 0.5);
//            
//            //!!!FIX for issue #1 Cell position wrong------------
//            if(cell.layer.position.x != 0){
//                cell.layer.position = CGPointMake(0, cell.layer.position.y);
//            }
//            
//            //4. Define the final state (After the animation) and commit the animation
//            [UIView beginAnimations:@"" context:NULL];
//            [UIView setAnimationDuration:0.8];
//            cell.layer.transform = CATransform3DIdentity;
//            cell.alpha = 1;
//            cell.layer.shadowOffset = CGSizeMake(0, 0);
//            [UIView commitAnimations];
//            
//
//            
//        }
//        else
//        {
//              [UIView setAnimationsEnabled:NO];
//        }
    }
    
}


//Helper function to get a random float
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (UIColor*)colorFromIndex:(int)index{
    UIColor *color;
    
    //Purple
    if(index % 3 == 0){
        color = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        //Blue
    }else if(index % 3 == 1){
        color = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        //Blk
    }else if(index % 3 == 2){
        color = [UIColor blackColor];
    }
    else if(index % 3 == 3){
        color = [UIColor colorWithRed:0.00 green:1.0 blue:0.00 alpha:1.0];
    }
    
    
    return color;
    
}



//#pragma mark - GESTURES (TAP & SWIPE)
//-(void)addTapGesture
//{
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(tapOnScrollView:)];
//    tapGesture.delaysTouchesBegan = YES;
//    [main_View addGestureRecognizer:tapGesture];
//    
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeOnScrollView:)];
//    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp |UISwipeGestureRecognizerDirectionDown ];
//    swipeGesture.delaysTouchesBegan = YES;
//    [self.view addGestureRecognizer:swipeGesture];
//}
//
//-(void)swipeOnScrollView:(UISwipeGestureRecognizer *)swipeGesture
//{
//    if (main_View.frame.origin.x == 0)
//    {
//        UIView *rootView = main_View;
//        CGRect rootFrame = rootView.frame;
//        rootFrame.origin.x -= rootFrame.size.width;
//        
//        [UIView beginAnimations:@"main_View" context:NULL];
//        rootView.frame = CGRectMake(260, 0, 320, 568);;
//        [UIView commitAnimations];
//
//    }
//    else if (main_View.frame.origin.x==260)
//    {
//        UIView *rootView = main_View;
//        CGRect rootFrame = rootView.frame;
//        rootFrame.origin.x -= rootFrame.size.width;
//        
//        [UIView beginAnimations:@"main_View" context:NULL];
//        rootView.frame = CGRectMake(0, 0, 320, 568);;
//        [UIView commitAnimations];
//    }
//   }
//-(void)tapOnScrollView:(UITapGestureRecognizer *)tapGesture
//{
//   }
//
//- (void)panRecognized:(UIPanGestureRecognizer *)rec
//{
//    CGPoint vel = [rec velocityInView:main_View];
//    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
//        UIPanGestureRecognizerDirectionUndefined,
//        UIPanGestureRecognizerDirectionUp,
//        UIPanGestureRecognizerDirectionDown,
//        UIPanGestureRecognizerDirectionLeft,
//        UIPanGestureRecognizerDirectionRight
//    };
//    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
//    if (rec.state == UIGestureRecognizerStateBegan)
//    {
//        if (vel.x > 0)
//        {
//            direction =UIPanGestureRecognizerDirectionLeft;
//            // user dragged towards the right
//            //counter++;
//        }
//        else
//        {
//            // user dragged towards the left
//            //counter--;
//        }
//
//    }
//    else if (rec.state == UIGestureRecognizerStateChanged)
//    {
//        if (vel.x > 0)
//        {
//            
//            direction =UIPanGestureRecognizerDirectionRight;
//
//            // user dragged towards the right
//            //counter++;
//        }
//        else
//        {
//            // user dragged towards the left
//            //counter--;
//        }
//
//    }
//    else if (rec.state == UIGestureRecognizerStateEnded)
//    {
//        if (vel.x > 0)
//        {
//            // user dragged towards the right
//            //counter++;
//             direction =UIPanGestureRecognizerDirectionRight;
//        }
//        else
//        {
//            // user dragged towards the left
//            //counter--;
//            direction =UIPanGestureRecognizerDirectionLeft;
//
//        }
//
//    }
////    CGPoint vel = [rec velocityInView:self.view];
//}

-(IBAction)btn_Yes_Clicked:(id)sender
{
               NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
            
            if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
                LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:verify animated:NO];
            }
            
            if ([loginStatus isEqualToString:@"0"]) {
                LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:verify animated:NO];
            }else
                
            {
                
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:kSTATUS];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:verify animated:NO];
            }
            
            
            
            
  
}
- (IBAction)btn_No_Clicked:(id)sender
{
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;

}



@end
