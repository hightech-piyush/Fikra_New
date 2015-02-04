//
//  EventListDetailViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "EventListDetailViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "EventDetailTableViewCell.h"
#import "EventImageViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "LoginViewController.h"
#import "ContactUsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "SliderTableViewCell.h"
#import "SubEventItem.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "ConnectionViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface EventListDetailViewController ()
{
    MPMediaItem *song;
    NSString *strMP3;
    NSString *strMP3Type;
    NSString *strLoginID;
    NSMutableArray *arySubEventItems;
    NSURLConnection *uploadMP3Connection;
    NSURLConnection *reserveEventConnection;
    
    NSString *strDayDate;
    NSString *strMonth_Year;
    NSString *strHour_Minute;
    NSString *strTimeType;
}
@end

@implementation EventListDetailViewController
CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;
EGORefreshTableHeaderView *_refreshHeaderView;

BOOL isBegan;
@synthesize main_View;
@synthesize subEvent = _subEvent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

#pragma mark - View Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;

    [self.navigationController setNavigationBarHidden:YES animated:NO];

    
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
        [button setImage:[UIImage imageNamed:@"event_active.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"event_active.png"] forState:UIControlStateSelected];
        [self.view addSubview:button];
        

        [button1 addTarget:self
                    action:@selector(aMethod1)
          forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        button1.frame = CGRectMake(80,518,80,50);
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateSelected];
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
        [button setImage:[UIImage imageNamed:@"event_active.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"event_active.png"] forState:UIControlStateSelected];
        [self.view addSubview:button];
        
        
        
        [button1 addTarget:self
                    action:@selector(aMethod1)
          forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        button1.frame = CGRectMake(80,430,80,50);
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateSelected];
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

    
    //[self loadSelctedItemTable];
    
    
    // Do any additional setup after loading the view.
}

-(void)loadSelctedItemTable
{
    arySubEventItems = [@[] mutableCopy];
    
    NSArray *arySubItems = _subEvent.arySubEventItems;
    arySelectedItems = [@[] mutableCopy];
    
    for (SubEventItem *item in arySubItems)
    {
        NSDictionary *dictItem = [self getDictionaryWithItem:item];
        SubEventItem *item_ = [self getSubEventItem:dictItem];
        [arySubEventItems addObject:item_];
    }
    
    if ([arySubEventItems count]==0) {
        _lbl_SelectTourna.text=@"No Event to Participate";
       // _btnUploadMP3.enabled=NO;
         _btn_Proceed.hidden=YES;
        _lblUploadMP3.hidden=YES;
         _btnUploadMP3.hidden=YES;
         _lbl_SelectTourna.textAlignment=NSTextAlignmentCenter;
        _scrollView.scrollEnabled=NO;

    }
    else
    {
        _lbl_SelectTourna.text=@"Select Event you want to participate";
        _btnUploadMP3.enabled=YES;
        _lbl_SelectTourna.textAlignment=NSTextAlignmentCenter;
        _btn_Proceed.hidden=NO;
        _scrollView.scrollEnabled=YES;

        _scrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,540.0,0.0);

             }
    //arySubEventItems = [arySubItems mutableCopy];
}

-(NSDictionary *)getDictionaryWithItem:(SubEventItem *)item
{
    NSString *name = item.strName;
    NSString *checked = item.strChecked;
    NSString *strID = item.strID;
    
    NSString *strSelectedItems_ = [[NSUserDefaults standardUserDefaults] valueForKey:kSelectedItems];
    NSArray *arySelectedItems_ = [strSelectedItems_ componentsSeparatedByString:@","];
    
    
    if (arySelectedItems_ == nil) {
        checked = item.strChecked;
    }else
    {
        if ([arySelectedItems_ containsObject:name])
        {
            //NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
            //if ([loginStatus isEqualToString:@"0"]) {
            //checked = @"off";
            
            //}else
            //{
            checked = @"on";
            
            //}
        }else
        {
            checked = @"off";
        }
    }
    
   
    
    NSDictionary * dictItem = @{@"name":name,@"id":strID,@"checked":checked};
    
    return dictItem;
}



#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
//    LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
//    [self.navigationController pushViewController:verify animated:NO];

    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    else
    {
        view_Logout.hidden=NO;
        view_Logout_Second.hidden=NO;
        
    }
    

}

-(void)loadGIF_View
{
    self.gifView.hidden = NO;
    self.img_animation.hidden = NO;

    self.img_animation.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed: @"btn_1.png"],
                                     [UIImage imageNamed: @"btn_2.png"],
                                     [UIImage imageNamed: @"btn_3.png"],
                                     [UIImage imageNamed: @"btn_4.png"],
                                     [UIImage imageNamed: @"btn_5.png"],
                                     [UIImage imageNamed: @"btn_6.png"] ,nil];
    self.img_animation.animationDuration = 1.0f; // about 30fps with your 13 images.
    //Set gordon's frame here
    [self.img_animation startAnimating];
    
}

-(void)removeGIF_View
{
    self.gifView.hidden = YES;
    self.img_animation.hidden = YES;
}

-(void)removeGIF_View1
{
    self.gifView.hidden = YES;
    self.img_animation.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    
    _btn_Proceed = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_Proceed addTarget:self
               action:@selector(btn_Proceed_Clicked:)
     forControlEvents:UIControlEventTouchUpInside];
         UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:19.0];
    [_btn_Proceed.titleLabel setFont:[UIFont fontWithDescriptor:afont size:19.0]];
    [_btn_Proceed setBackgroundImage:[UIImage imageNamed:@"login_button.png"] forState:UIControlStateNormal];
    _btn_Proceed.frame = CGRectMake(67.0, 300.0, 197.0, 45.0);
   
    [_btn_Proceed setTitle:@"R E S E R V E" forState:UIControlStateNormal];
    [_scrollView addSubview:_btn_Proceed];
    self.gifView.hidden = YES;
    self.img_animation.hidden = YES;
      [_scrollView addSubview:_btn_Proceed];
    
    NSString *loginStatus1 = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus1 == (id)[NSNull null] || loginStatus1.length == 0 ) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSelectedItems];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    else if ([loginStatus1 isEqualToString:@"0"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSelectedItems];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
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
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];

    
    [self loadSelctedItemTable];
    
    
    str_subEventID = _subEvent.strID;
    NSLog(@"str_subEventID******%@",str_subEventID);
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    UIFontDescriptor *mfont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:14.0];

     UIFontDescriptor *cfont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Bold" size:17.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    event_CategoryArray=[[NSMutableArray alloc]init];
    [_lbl_Event setFont:[UIFont fontWithDescriptor:cfont size:23.0]];
    _lbl_Event.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    [_lbl_Address setFont:[UIFont fontWithDescriptor:afont size:17.0]];
    [_lbl_Address1 setFont:[UIFont fontWithDescriptor:afont size:17.0]];
    UIFont *mp3LabelFont = [UIFont fontWithDescriptor:mfont size:14.0];
    _lblUploadMP3.font = mp3LabelFont;
    [_lbl_SelectTourna setFont:[UIFont fontWithDescriptor:afont size:20.0]];
    [_btn_Proceed.titleLabel setFont:[UIFont fontWithDescriptor:afont size:17.0]];

    [event_CategoryArray addObject:@"PAINTING"];
    [event_CategoryArray addObject:@"DRAWING"];
    [event_CategoryArray addObject:@"MUSIC"];
    [event_CategoryArray addObject:@"DRAWING"];
    [event_CategoryArray addObject:@"PAINTING "];
    [event_CategoryArray addObject:@"MUSIC"];
    [event_CategoryArray addObject:@"PAINTING"];
    [event_CategoryArray addObject:@"Drawing"];
    [event_CategoryArray addObject:@"MUSIC"];
    [event_CategoryArray addObject:@"DRAWING"];
    
    sliderArray=[[NSMutableArray alloc]init];
    [sliderArray addObject:@"ABOUT US"];
    [sliderArray addObject:@"TERMS OF SERVICE"];
    [sliderArray addObject:@"PRIVACY STATEMENT"];
    [sliderArray addObject:@"CONTACT US"];
    
    [self setupUIforSubEvent:_subEvent];
   // [_scrollView setContentSize:CGSizeMake(320, 611)];
     _scrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,540.0,0.0);
    if ([_lbl_Event.text length]>30) {
        _lbl_Event.marqueeType = MLContinuous;
        _lbl_Event.scrollDuration = 15.0;
       _lbl_Event.animationCurve = UIViewAnimationOptionCurveEaseInOut;
       _lbl_Event.fadeLength = 10.0f;
       _lbl_Event.continuousMarqueeExtraBuffer = 10.0f;
      _lbl_Event.tag = 101;
    }
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    [tbl_eventListDetail reloadData];
    
    
    if (arySubEventItems.count==0) {
        _btn_Proceed.hidden=YES;
        
    }
    else if (arySubEventItems.count==1)
    {
         _btn_Proceed.hidden=NO;
        [_btn_Proceed setFrame:CGRectMake(67, 300, 197, 45)];

        [_scrollView addSubview:_btn_Proceed];
        
    }
    else if (arySubEventItems.count==2)
    {
        _btn_Proceed.hidden=NO;
        [_btn_Proceed setFrame:CGRectMake(67, 360, 197, 45)];

        [_scrollView addSubview:_btn_Proceed];
    }
    else if (arySubEventItems.count==3)
    {
        _btn_Proceed.hidden=NO;
        [_btn_Proceed setFrame:CGRectMake(67, 410, 197, 45)];

        [_scrollView addSubview:_btn_Proceed];
    }
    else
    {
        _btn_Proceed.hidden=NO;
        [_btn_Proceed setFrame:CGRectMake(67, 420, 197, 45)];

        [_scrollView addSubview:_btn_Proceed];

    }
    
}

#pragma COMPARE DATES -



#pragma mark ---GET DATE IN EITHER STRING OR DATE TYPE
-(NSDate *)getDateFromString:(NSString *)strDate
{
    NSString *strAM_PM = [strDate substringFromIndex:20];
    NSString *strDate_ = [strDate substringToIndex:19];
    
    NSDateFormatter *tempFormatter2 = [[NSDateFormatter alloc]init];
	[tempFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *dateWithoutTime = [tempFormatter2 dateFromString:strDate_];
    
    strTimeType = strAM_PM;
    
    return dateWithoutTime;
}




-(NSString *)getStringDateFromDate:(NSDate *)buttonDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [df stringFromDate:buttonDate];
    return strDate;
}

-(BOOL)hasEventDateExceededForEvent:(SubEvent *)subEvent_
{
    NSString *strCurentDate = [subEvent_ strCurDate];
    NSString *strEventDate = [subEvent_ strEventDate];
    
    NSDate *currentDate = [self getDateFromString:strCurentDate];
    NSDate *eventDate   = [self getDateFromString:strEventDate];
    
    switch ([currentDate compare:eventDate]){
        case NSOrderedAscending:
            NSLog(@"NSOrderedAscending");
            return NO;
            break;
            
        case NSOrderedSame:
            NSLog(@"NSOrderedSame");
            return NO;
            break;
            
        case NSOrderedDescending:
            NSLog(@"NSOrderedDescending");
            return YES;
            break;
    }
}

#pragma mark -
#pragma mark Get Sub Event Item
-(SubEventItem *)getSubEventItem:(NSDictionary *)dictItem
{
    NSString *name = [dictItem valueForKey:@"name"];
    NSString *strID = [dictItem valueForKey:@"id"];
    NSString *checked = [dictItem valueForKey:@"checked"];

    SubEventItem *eventItem = [[SubEventItem alloc] init];
    
    eventItem.strID = strID;
    eventItem.strName = name;
    eventItem.strChecked = checked;
    
    return eventItem;
}

-(NSDictionary *)getItemDictWithItem:(SubEventItem *)item
{
    NSString *name = item.strName;
    NSString *checked = item.strChecked;
    NSString *strID = item.strID;
    if ([checked isEqualToString:@"off"]) {
        checked = @"on";
    }else
    {
        checked = @"off";
    }
    NSDictionary * dictItem = @{@"name":name,@"id":strID,@"checked":checked};
    return dictItem;
}

-(void)setupUIforSubEvent:(SubEvent *)subEvent
{
    NSString *subEventName = [subEvent strSubEventName];
    //NSString *subeventCheck = [subEvent strSubEventCheck];

    NSString *strEventDate = [subEvent strEventDate];
    NSString *strParts     = [subEvent strPrice];
    NSArray *aryPriceParts = [strParts componentsSeparatedByString:@" "];
    strPrice     = [aryPriceParts objectAtIndex:0];
    NSString *strCurncyType= [aryPriceParts objectAtIndex:1];
    NSString *strTitle     = [subEvent strSubTitle];
   // NSString *strDesc      = [subEvent strDesc];
    NSString *strLocation =[subEvent strLocation];
    UIFont *subTitlFont = [self getSubEventTitleFont];
    _lbl_Event.font = subTitlFont;
    
    UIFont *otherTextFont = [self getSubtitleDescAndTableFont];
    _lbl_Address.font = otherTextFont;
    _lbl_Address1.font = otherTextFont;

    //_lblTime.text=strEventDate;
   
    
    
    
    
    [self get_WeekDayDayMonthFormat_FromDate:strEventDate];
    //NSLog(@"%@",strDate_Date);
   
    
     //_lblDate.text=strEventDate;
    
   
    /*NSArray *arr = [strDate_Date componentsSeparatedByString:@" "];
    NSString *date = [arr objectAtIndex:0];
    //NSLog(@"%@",date);
    NSString *month = [arr objectAtIndex:1];
    //NSLog(@"%@",month);
    
    NSString *year = [arr objectAtIndex:2];
    //NSLog(@"%@",year);
     NSString *time = [arr objectAtIndex:3];
    
    NSString *year_month = [NSString stringWithFormat:@"%@ %@", month, year];
    NSString *newdate;
    if (date.length==1) {
        newdate = [NSString stringWithFormat:@"0%@",date];
    }
    else if (date.length==2)
    {
        newdate=date;
    }*/
    _lblDate.text =strDayDate;
    _lblMMYY.text=strMonth_Year;
    _lblTime.text=strHour_Minute;
    _lblTimeFormat.text=strTimeType;
    _lbl_Event.text = subEventName;
    _lbl_Address.text = strTitle;
    _lbl_Address1.text = strLocation;
 
    _lblPrize.text = strPrice;
    
    
    _lblCurrency.text = strCurncyType;
    
    hasExceeded = [self hasEventDateExceededForEvent:subEvent];
    if (hasExceeded)
    {
        _btn_Proceed.enabled = NO;
        _btnUploadMP3.hidden=YES;
        _lblUploadMP3.hidden=YES;
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Event is expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];

    }
    
    else
    {
        _btn_Proceed.enabled = YES;
    }
}

#pragma mark ---CONVERT DATE INTO TEXT FORMAT
-(void)get_WeekDayDayMonthFormat_FromDate:(NSString *)strDate
{
    NSDate *date = [self getDateFromString:strDate];
    NSDateComponents *dc = [[NSCalendar currentCalendar]  components:NSYearCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
    
    
    
    NSInteger year = [dc year];
    //NSInteger weekday = [dc weekday];
    NSInteger day = [dc day];
    NSInteger month = [dc month];
    NSInteger hour = [dc hour];
    NSInteger min = [dc minute];
    
     NSString *strhour = [NSString stringWithFormat:@"%ld",(long)hour];
     NSString *strMin = [NSString stringWithFormat:@"%ld",(long)min];
    NSString *strDay = [NSString stringWithFormat:@"%ld",(long)day];
    NSString *strYear = [NSString stringWithFormat:@"%ld",(long)year];
    
    if ([strhour length]==1) {
        strhour = [NSString stringWithFormat:@"0%@",strhour];
    }
    
    if ([strMin length]==1) {
        strMin = [NSString stringWithFormat:@"0%@",strMin];
    }
    
    NSString *strMonth = [self getMonth:month];
    
    strDayDate = strDay;
    strMonth_Year = [NSString stringWithFormat:@"%@ %@",strMonth,strYear];
    strHour_Minute = [NSString stringWithFormat:@"%@:%@",strhour,strMin];
    
    //NSString *convertedDate = [NSString stringWithFormat:@"%@ %@ %d %d:%ld",strDay,strMonth,year,hour,(long)min];
    //return convertedDate;
}




#pragma mark ---IDENTIFY MONTH
-(NSString *)getMonth : (NSInteger)month
{
    NSString *strMonth = @"";
    switch (month) {
        case 1:
            strMonth = @"Jan";
            break;
            
        case 2:
            strMonth = @"Feb";
            break;
            
        case 3:
            strMonth = @"March";
            break;
            
        case 4:
            strMonth = @"April";
            break;
            
        case 5:
            strMonth = @"May";
            break;
            
        case 6:
            strMonth = @"June";
            break;
            
        case 7:
            strMonth = @"July";
            break;
            
        case 8:
            strMonth = @"Aug";
            break;
            
        case 9:
            strMonth = @"Sept";
            break;
            
        case 10:
            strMonth = @"Oct";
            break;
            
        case 11:
            strMonth = @"Nov";
            break;
            
        case 12:
            strMonth = @"Dec";
            break;
            
            
        default:
            break;
    }
    return strMonth;
}

#pragma mark -




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(UIFont *)getSubEventTitleFont
{
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    //[cell.lbl_Title setFont:[UIFont fontWithDescriptor:afont size:21.0]];
    UIFont *font = [UIFont fontWithDescriptor:afont size:23.0];
    return font;
}

-(UIFont *)getSubtitleDescAndTableFont
{
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    UIFont *font = [UIFont fontWithDescriptor:afont size:17.0];
    return font;
}

-(void)aMethod
{
}

-(void)aMethod1{
    NewsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"news"];
    [self.navigationController pushViewController:verify animated:NO];

}
-(void)aMethod2{
    
    
    NotificationViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"noti"];
    [self.navigationController pushViewController:verify animated:NO];
}
-(void)aMethod3{
    MoreViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"more"];
    [self.navigationController pushViewController:verify animated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tbl_eventListDetail) {
        return [arySubEventItems count];
    }
     return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Get the cell
    
    
    
    static NSString *CellIdentifier = @"Cell";
    NSLog(@"indexPath%ld",(long)indexPath.row);
    //NSLog(@"newsArray%lu",(unsigned long)newsArray.count);
   // j=indexPath.row;
    EventDetailTableViewCell *cell = (EventDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = (EventDetailTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"EventDetailTableViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //j=indexPath.row;
    //3. Setup the cell
    //NSDictionary *dict = [arySubEventItems objectAtIndex:indexPath.row];
    

        SubEventItem *item = [arySubEventItems objectAtIndex:indexPath.row];//[[SubEventItem alloc] init];
        NSString *strItemName = item.strName;
        //NSString *strItemID = item.strID;
     NSString *strchecked = item.strChecked;
    
       if([strchecked isEqualToString:@"on"]){
        [cell.btn_Check setImage:[UIImage imageNamed:@"checked-box.png"] forState:UIControlStateNormal];
    }else{
        [cell.btn_Check setImage:[UIImage imageNamed:@"unchecked-box.png"] forState:UIControlStateNormal];
    }
    
  

    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:19.0];
    [cell.lbl_eventCategory setFont:[UIFont fontWithDescriptor:afont size:19.0]];
    
    cell.lbl_eventCategory.text= strItemName;//[event_CategoryArray objectAtIndex:indexPath.row];
    
    if ([cell.lbl_eventCategory.text length]>20) {
        cell.lbl_eventCategory.marqueeType = MLContinuous;
        cell.lbl_eventCategory.scrollDuration = 60.0;
        cell.lbl_eventCategory.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        cell.lbl_eventCategory.fadeLength = 10.0f;
        cell.lbl_eventCategory.continuousMarqueeExtraBuffer = 10.0f;
        cell.lbl_eventCategory.tag = 101;
    }
    
    
    cell.btn_Check.tag = indexPath.row;
    
    
    if (hasExceeded)
    {
        cell.btn_Check.enabled=NO;
    }
    else
    {
        cell.btn_Check.enabled=YES;
    }
    
         [cell.btn_Check addTarget:self action:@selector(btn_check_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    

    
   

    //[cell.btn_Check setImage:[UIImage imageNamed:[dict objectForKey:@"select"]] forState:UIControlStateNormal];
    
    return cell;
   
}



- (void)btn_check_Clicked:(id)sender
{
      NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
   
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Select Tournament" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        al.tag=5555;

    }
    
    
    else if ([loginStatus isEqualToString:@"0"]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Select Tournament" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        al.tag=5555;

    }else
    {
     
        
        
    arrSelectedrowIndex=[[NSMutableArray alloc]init];
    UIButton *b = (UIButton *)sender;
    NSInteger index = b.tag;
    SubEventItem *item = [arySubEventItems objectAtIndex:index];

    NSString *strID = item.strID;
    NSLog(@"kaaanaa%@",strID);
    
    NSString *commaSep = [commaSep stringByAppendingString:strID];
    
    NSDictionary *dichtItem = [self getItemDictWithItem:item];
    SubEventItem *item_ = [self getSubEventItem:dichtItem];
    [arySubEventItems replaceObjectAtIndex:index withObject:item_];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    _selectedRow = indexPath.row;
    
    [arrSelectedrowIndex addObject:[NSNumber numberWithInteger:_selectedRow]];

    [tbl_eventListDetail reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
//    NSDictionary *dict = [arySubEventItems objectAtIndex:b.tag];
//    NSString *strName = [dict valueForKey:@"name"];
//    if ([[dict valueForKey:@"select"] isEqualToString:@"btn-1.png"]) {
//        dict = @{@"name" : strName,
//                 @"select" : @"btn-2.png"};
//        [arySubEventItems replaceObjectAtIndex:b.tag withObject:dict];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:b.tag inSection:0];
//        [tbl_eventListDetail reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }else
//    {
//        dict = @{@"name" : strName,
//                 @"select" : @"btn-1.png"};
//        [arySubEventItems replaceObjectAtIndex:b.tag withObject:dict];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:b.tag inSection:0];
//        [tbl_eventListDetail reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
    }
    
}


-(IBAction)btn_BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)eventImageClicked:(id)sender
{
    EventImageViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"eventimage"];
    verify.subEvent = _subEvent;
    [self.navigationController pushViewController:verify animated:NO];

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

- (IBAction)btn_Proceed_Clicked:(id)sender {
    
    if (hasExceeded)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Event is Expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];    }
    else
    {    Reachability *hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];
    
    hostStatus=[hostReach currentReachabilityStatus];
    if (hostStatus ==NotReachable) {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connection Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
           }
    

  
    else {
        
  

    arySelectedItems = [@[] mutableCopy];
    arySelectedID = [@[] mutableCopy];

    for (SubEventItem *item in arySubEventItems)
    {
        NSString *checked = item.strChecked;
        if ([checked isEqualToString:@"on"])
        {
            NSString *itemName = item.strName;
            if (![arySelectedItems containsObject:itemName])
            {
                [arySelectedItems addObject:itemName];
            }
        }
    }
    
    for (SubEventItem *item in arySubEventItems)
    {
        NSString *checked = item.strChecked;
        if ([checked isEqualToString:@"on"])
        {
            NSString *itemid = item.strID;
            if (![arySelectedID containsObject:itemid])
            {
                [arySelectedID addObject:itemid];
            }
        }
    }
    strSelectedID= [arySelectedID componentsJoinedByString:@","];
    NSLog(@"strSelectedItems = %@",strSelectedItems);
    
    strSelectedItems = [arySelectedItems componentsJoinedByString:@","];
    NSLog(@"strSelectedItems = %@",strSelectedItems);

    [[NSUserDefaults standardUserDefaults] setValue:strSelectedItems forKey:kSelectedItems];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (strSelectedItems.length) {
        
        NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
        
        if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Reserve" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [al show];
            al.tag=5555;
            
        }
        
        else if ([loginStatus isEqualToString:@"0"]) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Reserve" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [al show];
            al.tag=5555;
            
        }
        else
        {
               [self loadGIF_View];
            [self performSelector:@selector(Proceed_WS_Called) withObject:nil afterDelay:0.1];

        }
        

    }
    else
    {
        NSLog(@"NOT SELECTED ANY EVENT");
                  UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please select any event to participate." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        
        

    }

    }
    }
}

#pragma mark - Document Directory

#pragma mark conveniences
NSString* myDocumentsDirectory() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];;
}

void myDeleteFile (NSString* path) {
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSError *deleteErr = nil;
		[[NSFileManager defaultManager] removeItemAtPath:path error:&deleteErr];
		if (deleteErr) {
			NSLog (@"Can't delete %@: %@", path, deleteErr);
		}
	}
}

#pragma mark - Get MP3 Data

-(void) openMediaLibrary {
	// show picker
	MPMediaPickerController *pickerController =	[[MPMediaPickerController alloc]
												 initWithMediaTypes: MPMediaTypeMusic];
	pickerController.prompt = @"Choose song to export";
	pickerController.allowsPickingMultipleItems = NO;
	pickerController.delegate = self;
	[self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark core audio test
BOOL coreAudioCanOpenURL (NSURL* url)
{
	OSStatus openErr = noErr;
	AudioFileID audioFile = NULL;
	openErr = AudioFileOpenURL((__bridge CFURLRef) url,
							   kAudioFileReadPermission,
							   0,
							   &audioFile);
	if (audioFile) {
		AudioFileClose (audioFile);
	}
	return openErr ? NO : YES;
}

-(void)loadGIF_View1
{
    self.gifView.hidden = NO;
    self.img_animation.hidden = NO;
    
    self.img_animation.animationImages = [NSArray arrayWithObjects:
                                          [UIImage imageNamed: @"btn_1.png"],
                                          [UIImage imageNamed: @"btn_2.png"],
                                          [UIImage imageNamed: @"btn_3.png"],
                                          [UIImage imageNamed: @"btn_4.png"],
                                          [UIImage imageNamed: @"btn_5.png"],
                                          [UIImage imageNamed: @"btn_6.png"] ,nil];
    self.img_animation.animationDuration = 1.0f; // about 30fps with your 13 images.
    //Set gordon's frame here
    [self.img_animation startAnimating];
    
}


-(void) exportMP3
{
    
    [self loadGIF_View1];
	// get the special URL
	if (! song) {
		return;
	}
    
    filename = [song valueForProperty:MPMediaItemPropertyTitle];
    NSLog(@"%@Song------",filename);
    NSURL *assetURL = [song valueForProperty:MPMediaItemPropertyAssetURL];
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:assetURL options:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog (@"compatible presets for songAsset: %@",[AVAssetExportSession exportPresetsCompatibleWithAsset:songAsset]);
    
    
    AVMutableComposition *composition = [[AVMutableComposition alloc]init];
    AVMutableCompositionTrack *track = [composition addMutableTrackWithMediaType:AVAssetExportPresetPassthrough preferredTrackID:kCMPersistentTrackID_Invalid];
    
      [track insertTimeRange:CMTimeRangeMake(kCMTimeZero, songAsset.duration) ofTrack:[[songAsset tracksWithMediaType:AVMediaTypeAudio]objectAtIndex:0] atTime:kCMTimeZero error:nil];
    NSLog (@"Track Record ------------%@",track);
    
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
                                      initWithAsset: songAsset
                                      presetName: AVAssetExportPresetAppleM4A];
    
    
    
    NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
    
    exporter.outputFileType = AVFileTypeAppleM4A;
    
    NSString *exportFile = [documentsDirectory stringByAppendingPathComponent: @"item1.MP3"];
    NSLog(@"%@",exportFile);
    NSError *error1;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:exportFile])
    {
        
        [[NSFileManager defaultManager] removeItemAtPath:exportFile error:&error1];
    }
    
    NSURL* exportURL = [NSURL fileURLWithPath:exportFile];
    
    exporter.outputURL = exportURL;
    
    // do the export
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        
        NSData *data1 = [NSData dataWithContentsOfFile: [documentsDirectory stringByAppendingPathComponent: @"item1.MP3"]];
        
        
        [data1 writeToFile:exportFile atomically:NO];
        
        //NSLog(@"%@",data1);
        
        
             int exportStatus = exporter.status;
        
        switch (exportStatus) {
                
            case AVAssetExportSessionStatusFailed: {
                
                // log error to text view
                NSError *exportError = exporter.error;
                [self removeGIF_View];
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Error Occured while uploading mp3" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                [al show];
                //      errorView.text = exportError ? [exportError description] : @"Unknown failure";
                
                //errorView.hidden = NO;
                
                break;
            }
                
            case AVAssetExportSessionStatusCompleted: {
                
                NSLog (@"AVAssetExportSessionStatusCompleted");
                NSLog(@"MP3 file name url = %@",exporter.outputURL);
               [self removeGIF_View1];
               			// set up AVPlayer
                    NSData *data = [self getDataFromMP3URL:exporter.outputURL];
                    strMP3 = [self convertDataIntoBase64String:data];
               
                
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Upload MP3" message:@"Are you sure want to upload mp3?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                [al show];
                al.tag=7896;

                
                break;
            }
                
            case AVAssetExportSessionStatusUnknown: { NSLog (@"AVAssetExportSessionStatusUnknown");
                [self removeGIF_View];
                break;
            }
            case AVAssetExportSessionStatusExporting: { NSLog (@"AVAssetExportSessionStatusExporting");
                [self removeGIF_View];
                break;
            }
                
            case AVAssetExportSessionStatusCancelled: { NSLog (@"AVAssetExportSessionStatusCancelled");
                [self removeGIF_View];
                break;
            }
                
            case AVAssetExportSessionStatusWaiting: { NSLog (@"AVAssetExportSessionStatusWaiting"); break; }
                [self removeGIF_View];
                
            default: 
            { NSLog (@"didn't get export status"); break; } }
        
    }];

    
//	NSURL *assetURL = [song valueForProperty:MPMediaItemPropertyAssetURL];
//	AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:assetURL options:nil];
//    
//	//NSLog (@"Core Audio %@ directly open library URL %@",coreAudioCanOpenURL (assetURL) ? @"can" : @"cannot", assetURL);
//	
//	NSLog (@"compatible presets for songAsset: %@",
//		   [AVAssetExportSession exportPresetsCompatibleWithAsset:songAsset]);
//	
//	
//	/* approach 1: export just the song itself
//	 */
//	AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
//									  initWithAsset: songAsset
//									  presetName: AVAssetExportPresetAppleM4A];
//	NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
//	exporter.outputFileType = @"com.apple.m4a-audio";
//	NSString *exportFile = [myDocumentsDirectory() stringByAppendingPathComponent: @"exported.m4a"];
//	// end of approach 1
//    
//	// set up export (hang on to exportURL so convert to PCM can find it)
//	myDeleteFile(exportFile);
//	NSURL * exportURL = [NSURL fileURLWithPath:exportFile];
//	exporter.outputURL = exportURL;
//
//	// do the export
//	[exporter exportAsynchronouslyWithCompletionHandler:^{
//		int exportStatus = exporter.status;
//		switch (exportStatus) {
//			case AVAssetExportSessionStatusFailed: {
//				// log error to text view
//				NSError *exportError = exporter.error;
//				NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//				break;
//			}
//			case AVAssetExportSessionStatusCompleted: {
//               
//				NSLog (@"AVAssetExportSessionStatusCompleted");
//                NSLog(@"MP3 file name url = %@",exporter.outputURL);
//
//				// set up AVPlayer
//                NSData *data = [self getDataFromMP3URL:exporter.outputURL];
//                strMP3 = [self convertDataIntoBase64String:data];
//               
//                [self performSelectorInBackground:@selector(uploadMP3_WS_Called) withObject:nil];
//				break;
//			}
//			case AVAssetExportSessionStatusUnknown: { NSLog (@"AVAssetExportSessionStatusUnknown"); break;}
//			case AVAssetExportSessionStatusExporting: { NSLog (@"AVAssetExportSessionStatusExporting"); break;}
//			case AVAssetExportSessionStatusCancelled: { NSLog (@"AVAssetExportSessionStatusCancelled"); break;}
//			case AVAssetExportSessionStatusWaiting: { NSLog (@"AVAssetExportSessionStatusWaiting"); break;}
//			default: { NSLog (@"didn't get export status"); break;}
//		}
//	}];
}

-(NSData *)getDataFromMP3URL:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}


-(NSString *)convertDataIntoBase64String:(NSData *)data
{
    NSString *strMP3_Local = [data base64EncodedStringWithOptions:kNilOptions];//[self Base64Encode:data];
    return strMP3_Local;
}

-(NSString *)Base64Encode:(NSData *)data{
    
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength+1);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //Start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp = '\0';
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4.
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    /* http://en.wikipedia.org/wiki/Base64
     
     Text content     M         a         n
     ASCII            77        97        110
     8 Bit pattern    01001101  01100001  01101110
     
     6 Bit pattern    010011    010110    000101    101110
     Index            19        22        5         46
     Base64-encoded   T         W         F         u
     */
    
    while (inpos < inLength){
        switch (cycle) {
                
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos] & 0xFC) >> 2];
                cycle = 1;
                break;
                
            case 1:
                temp = (inputBuffer[inpos++] & 0x03) << 4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
                
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0) >> 4];
                temp = (inputBuffer[inpos++] & 0x0F) << 2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
                
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0) >> 6];
                cycle = 4;
                break;
                
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++] & 0x3f];
                cycle = 0;
                break;
                
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
}

#pragma mark MPMediaPickerControllerDelegate
- (void)mediaPicker: (MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
	[self dismissViewControllerAnimated:YES completion:nil];
	if ([mediaItemCollection count] < 1) {
		return;
	}

	song = [[mediaItemCollection items] objectAtIndex:0];
       [self performSelector:@selector(exportMP3) withObject:nil afterDelay:0.0001];
    //[self exportMP3];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Upload MP3 Webservice
- (IBAction)uploadMP3_Clicked:(id)sender
{
    
    
    
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Select Tournament" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        al.tag=5555;

    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please Login first" message:@"You have to login for Select Tournament" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        al.tag=5555;

    }else
    {
        UIImage *logoutImage = [UIImage imageNamed:@"logout-icon_New.png"];
        [_btnLogin setImage:logoutImage forState:UIControlStateNormal];
        
        SubEvent *subEvent_ = _subEvent;
        strMP3Type = subEvent_.strMP3;
        [self openMediaLibrary];
    }
    
}

-(void)uploadMP3_WS_Called
{
    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];
    NSString *st = [NSString stringWithFormat:@"user_id=%@&mp3_file=%@&sub_event_id=%@&extension=mp3&file_name=%@",regID,strMP3,str_subEventID,filename];
   // NSLog(@"ST=%@",st);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,MP3_UploadURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    //uploadMP3Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        
        NSString *status = [[[dictTemp valueForKey:@"file"]objectAtIndex:0]valueForKey:@"status"];
        
        if ([status isEqualToString:@"0"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"operation failed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"1"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Mp3 file inserted successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"2"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Mp3 file updated successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [al show];
        }
        
        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    }];
    
   // [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        if (error) {
//           
//        } else {
//            NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//          NSDictionary *  returnDict             = [NSJSONSerialization JSONObjectWithData:data
//                                                                     options: NSJSONReadingMutableContainers
//                                                                       error: &error];
//            
//        }];
    
    
//    if( uploadMP3Connection )
//	{
//		receivedData = [NSMutableData data];
//	}
//	else
//	{
//		NSLog(@"theConnection is NULL");
//    }
//    
    //mp3_upload.php
}

#pragma mark - Process Webservice
-(void)Proceed_WS_Called
{
  //  sub_event_id , reg_id , item_id , paid_by , price , device_id , item_name

    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];

    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

      NSString *st=[NSString stringWithFormat:@"sub_event_id=%@&reg_id=%@&item_id=%@&paid_by=i&price=%@&device_id=%@&item_name=%@",str_subEventID,regID,strSelectedID,strPrice,app.deviceToke1,strSelectedItems];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,ProceedURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    reserveEventConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( reserveEventConnection )
	{
		receivedData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
    }

}

#pragma mark - Connection Delegates

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength: 0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == uploadMP3Connection)
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        
          NSString *status = [[[dictTemp valueForKey:@"file"]objectAtIndex:0]valueForKey:@"status"];
        
        if ([status isEqualToString:@"0"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"operation failed" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"1"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Mp3 file inserted successfully" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"2"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Mp3 file updated successfully" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }

        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
        

    }
    else
    {
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        //  NSString *status=[[dictTemp valueForKey:@"participate"]valueForKey:@"status"];
        
        NSArray *aryStatus = [dictTemp valueForKey:@"participate"];
        NSDictionary *dictStatus = [aryStatus objectAtIndex:0];
        NSString *status = [dictStatus valueForKey:@"status"];

        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

        if ([status isEqualToString:@"0"]) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Participation Unsuccessfull" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"1"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Thank you for Registration. Our Support Team will contact you soon." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"2"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Participation Successfully Updated" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        else if ([status isEqualToString:@"3"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Event has been expired, You can not participate now." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }

        else if ([status isEqualToString:@"5"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Participation limit over" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            [al show];
        }
        
        else if ([status isEqualToString:@"10"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Sign in Information" message:@"You are signed in another device.\n Please sign in again to participate." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            
            al.tag = 6000;
            al.delegate = self;
            [al show];
        }
        


    }
    
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==5555) {
        if (buttonIndex==0) {
            LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self.navigationController pushViewController:verify animated:NO];
        }
    }
    if (alertView.tag==7896) {
        if (buttonIndex==0) {
            [self loadGIF_View];
           [self performSelectorInBackground:@selector(uploadMP3_WS_Called) withObject:nil];
        }
    }
    if (alertView.tag==6000) {
        if (buttonIndex==0) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPASSWORD];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSERNAME];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRegister_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self.navigationController pushViewController:verify animated:NO];
        }
    }

    
}


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
