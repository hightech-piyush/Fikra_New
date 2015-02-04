 //
//  EventsViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "EventsViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "EventListViewController.h"
#import "EventTableViewCell.h"
#import "SliderTableViewCell.h"
#import "MFSideMenu/MFSideMenu.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "LoginViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "MainEvent.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "SubEvent.h"
#import "SubEventItem.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
@interface EventsViewController ()
{
    NSMutableData *receivedData;
    NSDictionary *dictEvents;
    NSMutableArray *aryEvents;
    NSMutableArray *aryFiltered;
    BOOL hasFound;
    NSString *searchText;
    NSString *strUserID;
    NSURLConnection *eventConnection;
    NSURLConnection *updateURLConnection;
    NSURLConnection *ADconnection;

}
@end

@implementation EventsViewController

CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;
EGORefreshTableHeaderView *_refreshHeaderView;

BOOL isBegan;
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
#pragma mark -
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

#pragma mark INSERT EVENT INTO DATABASE

-(void)insertIntoMainEvent:(MainEvent *)event
{
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into main_event (image,name,main_event_web_id) values ('%@','%@','%@')",event.strImageURL,event.strName,event.strID];
    BOOL success = [dbobj executeNonQuery:q];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark INSERT SUB_EVENT INTO DATABASE

-(void)insertIntoSubEvent:(SubEvent *)subEvent
{
    int mainEventID = [[subEvent strMainEventID] intValue];
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into sub_event (Sub_title,current_date,description,event_date,link,location,location_img,name,price,main_event_id,sub_event_web_id,main_event_web_id,eventLink) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,'%@','%@','%@')",subEvent.strSubTitle,subEvent.strCurDate,subEvent.strDesc,subEvent.strEventDate,subEvent.strLocationImageLink,subEvent.strLocation,subEvent.strLocImage,subEvent.strSubEventName,subEvent.strPrice,mainEventID,subEvent.strID,subEvent.strMainEventID,subEvent.strLink];
    BOOL success = [dbobj executeNonQuery:q];
    if (success) {
        
    }else
    {}
    [dbobj close];
}
/*{
    int mainEventID = [[subEvent strMainEventID] intValue];
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into sub_event (Sub_title,current_date,description,event_date,link,location,location_img,name,price,main_event_id,sub_event_web_id,main_event_web_id,mp3) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,'%@','%@','%@')",subEvent.strSubTitle,subEvent.strCurDate,subEvent.strDesc,subEvent.strEventDate,subEvent.strLocationImageLink,subEvent.strLocation,subEvent.strLocImage,subEvent.strSubEventName,subEvent.strPrice,mainEventID,subEvent.strID,subEvent.strMainEventID,subEvent.strMP3];
    BOOL success = [dbobj executeNonQuery:q];
    if (success) {
        
    }else
    {}
    [dbobj close];
}*/


#pragma mark INSERT SUB_EVENT_ITEM INTO DATABASE

-(void)insertIntoSubEventItem:(SubEventItem *)item
{
    int subEventID = [[item strSubEventID] intValue];
    int mainEventID = [[item strMainEventID] intValue];
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into event_item (checked,name,sub_event_id,main_event_id,item_web_id,sub_event_web_id,main_event_web_id) values ('%@','%@',%d,%d,'%@','%@','%@')",item.strChecked,item.strName,subEventID,mainEventID,item.strID,item.strSubEventID,item.strMainEventID];
    BOOL success = [dbobj executeNonQuery:q];
    if (success) {
        
    }else
    {}
    [dbobj close];
}


#pragma mark DELETE EVENTS FROM DATABASE

-(void)deleteFromMainEvent
{
    [self databaseOpen];
    NSString *dq=[NSString stringWithFormat:@"Delete from main_event"]; //event_item sub_event
    BOOL success = [dbobj executeNonQuery:dq];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark DELETE SUB_EVENT FROM DATABASE

-(void)deleteFromSubEvent
{
    [self databaseOpen];
    NSString *dq=[NSString stringWithFormat:@"Delete from sub_event"]; //event_item sub_event
    BOOL success = [dbobj executeNonQuery:dq];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark DELETE SUB_EVENT_ITEM FROM DATABASE

-(void)deleteFromSubEventItem
{
    [self databaseOpen];
    NSString *dq=[NSString stringWithFormat:@"Delete from event_item"]; //event_item sub_event
    BOOL success = [dbobj executeNonQuery:dq];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark SELECT EVENTS TO GET EVENTS ENTRIES

-(NSArray *)selectFromMainEvent
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from main_event"];
    NSArray * aryEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSMutableArray *aryEvents__ = [@[] mutableCopy];
    for (NSDictionary *dictEvent in aryEvents_) {
        NSString *strID = [dictEvent valueForKey:@"main_event_web_id"];
        MainEvent *event = [self selectFromMainEventWhereEventID:strID];
        [aryEvents__ addObject:event];
    }
    
     return aryEvents__;
}


-(NSArray *)selectFromMainEvent_ForRealData
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from main_event"];
    NSArray * aryEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    
    return aryEvents_;
}

#pragma mark SELECT EVENT FOR SPECIFIC EVENT ID

-(MainEvent *)selectFromMainEventWhereEventID:(NSString *)eventID
{
    //int event_id = [eventID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from main_event where main_event_web_id = %@",eventID];
    NSArray * aryEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictEvent = [aryEvents_ objectAtIndex:0];
    
    NSString *strID = [dictEvent valueForKey:@"main_event_web_id"];//[NSString stringWithFormat:@"%d",[ intValue]];
    NSString *strImage = [dictEvent valueForKey:@"image"];
    NSString *strName = [dictEvent valueForKey:@"name"];
    NSArray *arySubEvents = [self selectFromSubEventWhereMainEventID:strID];
    NSURL *fileURL = [NSURL fileURLWithPath:strImage];
    
    MainEvent *event = [[MainEvent alloc] init];
    event.strID = strID;
    event.imageURL = fileURL;
    event.strName = strName;
    event.arySubEvents = arySubEvents;
    return event;
}


#pragma mark SELECT SUB EVENTS FOR MAIN EVENT ID

-(NSArray *)selectFromSubEventWhereMainEventID:(NSString *)eventID
{
    int event_id = [eventID intValue];
    
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from sub_event where main_event_web_id = %d",event_id];
    NSArray * arySubEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    NSMutableArray *arySubEvents = [@[] mutableCopy];
    for (NSDictionary *dict in arySubEvents_) {
        NSString *strID = [dict valueForKey:@"sub_event_web_id"];
        SubEvent *subEvent = [self selectFromSubEventWhereSubEventID:strID];
        [arySubEvents addObject:subEvent];
    }

    return arySubEvents;
}


#pragma mark SELECT SUB EVENT FOR SPECIFIC SUB EVENT ID

-(SubEvent *)selectFromSubEventWhereSubEventID:(NSString *)subID
{
    //int sub_ID = [subID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from sub_event where sub_event_web_id = %@",subID];
    NSArray * arySubEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictSubEvent = [arySubEvents_ objectAtIndex:0];
    
    NSString *strID = [dictSubEvent valueForKey:@"sub_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictSubEvent valueForKey:@"sub_event_web_id"] intValue]];
    NSString *subTitle = [dictSubEvent valueForKey:@"Sub_title"];
    NSString *curDate = [dictSubEvent valueForKey:@"current_date"];
    NSString *event_date = [dictSubEvent valueForKey:@"event_date"];
    NSString *desc = [dictSubEvent valueForKey:@"description"];
    NSString *link = [dictSubEvent valueForKey:@"link"];
    NSString *location = [dictSubEvent valueForKey:@"location"];
    NSString *location_img = [dictSubEvent valueForKey:@"location_img"];
    NSString *name = [dictSubEvent valueForKey:@"name"];
    NSString *price = [dictSubEvent valueForKey:@"price"];
    NSString *main_event_id = [dictSubEvent valueForKey:@"main_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictSubEvent valueForKey:@"main_event_id"] intValue]];
    NSString *eventLink = [dictSubEvent valueForKey:@"eventLink"];
    
    NSArray *arySubEventItems = [self selectFromItemWhereSubEventID:strID];
    
    
    SubEvent *subEvent = [[SubEvent alloc] init];
    subEvent.strID = strID;
    subEvent.strSubTitle = subTitle;
    subEvent.strCurDate = curDate;
    subEvent.strEventDate = event_date;
    subEvent.strDesc = desc;
    subEvent.strLocationImageLink = link;
    subEvent.strLocation = location;
    subEvent.strLocImage = location_img;
    subEvent.strSubEventName = name;
    subEvent.strPrice = price;
    subEvent.strMainEventID = main_event_id;
    subEvent.arySubEventItems = arySubEventItems;
    subEvent.strLink = eventLink;
    
    return subEvent;
}
/*{
    //int sub_ID = [subID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from sub_event where sub_event_web_id = %@",subID];
    NSArray * arySubEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictSubEvent = [arySubEvents_ objectAtIndex:0];
    
    NSString *strID = [dictSubEvent valueForKey:@"sub_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictSubEvent valueForKey:@"sub_event_web_id"] intValue]];
    NSString *subTitle = [dictSubEvent valueForKey:@"Sub_title"];
    NSString *curDate = [dictSubEvent valueForKey:@"current_date"];
    NSString *event_date = [dictSubEvent valueForKey:@"event_date"];
    NSString *desc = [dictSubEvent valueForKey:@"description"];
    NSString *link = [dictSubEvent valueForKey:@"link"];
    NSString *location = [dictSubEvent valueForKey:@"location"];
    NSString *location_img = [dictSubEvent valueForKey:@"location_img"];
    NSString *name = [dictSubEvent valueForKey:@"name"];
    NSString *price = [dictSubEvent valueForKey:@"price"];
    NSString *main_event_id = [dictSubEvent valueForKey:@"main_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictSubEvent valueForKey:@"main_event_id"] intValue]];
    NSString *strMP3 = [dictSubEvent valueForKey:@"mp3"];
    
    NSArray *arySubEventItems = [self selectFromItemWhereSubEventID:strID];

    
    SubEvent *subEvent = [[SubEvent alloc] init];
    subEvent.strID = strID;
    subEvent.strSubTitle = subTitle;
    subEvent.strCurDate = curDate;
    subEvent.strEventDate = event_date;
    subEvent.strDesc = desc;
    subEvent.strLocationImageLink = link;
    subEvent.strLocation = location;
    subEvent.strLocImage = location_img;
    subEvent.strSubEventName = name;
    subEvent.strPrice = price;
    subEvent.strMainEventID = main_event_id;
    subEvent.arySubEventItems = arySubEventItems;
    subEvent.strMP3 = strMP3;
    return subEvent;
}*/


#pragma mark SELECT SUB EVENT ITEMS FOR SUB EVENT ID

-(NSArray *)selectFromItemWhereSubEventID:(NSString *)subID
{
    //int sub_ID = [subID intValue];
    
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from event_item where sub_event_web_id = %@",subID];
    NSArray * arySubEvents_=[dbobj executeQuery:cq];
    [dbobj close];
    NSMutableArray *arySubEventItems = [@[] mutableCopy];
    for (NSDictionary *dict in arySubEvents_) {
        NSString *strID = [dict valueForKey:@"item_web_id"];
        SubEventItem *item = [self selectFromItemWhereItemID:strID];
        [arySubEventItems addObject:item];
    }
    return arySubEventItems;
}



#pragma mark SELECT SUB EVENT ITEM FOR SPECIFIC ITEM ID

-(SubEventItem *)selectFromItemWhereItemID:(NSString *)itemID
{
    //int item_ID = [itemID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from event_item where item_web_id = %@",itemID];
    NSArray * aryItems_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictItem = [aryItems_ objectAtIndex:0];
    
    NSString *strID = [dictItem valueForKey:@"item_web_id"];//[NSString stringWithFormat:@"%d",[[dictItem valueForKey:@"item_web_id"] intValue]];
    NSString *checked = [dictItem valueForKey:@"checked"];
    NSString *name = [dictItem valueForKey:@"name"];
    NSString *sub_event_id = [dictItem valueForKey:@"sub_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictItem valueForKey:@"sub_event_web_id"] intValue]];
    NSString *main_event_id = [dictItem valueForKey:@"main_event_web_id"];//[NSString stringWithFormat:@"%d",[[dictItem valueForKey:@"main_event_web_id"] intValue]];
    
    
    SubEventItem *item = [[SubEventItem alloc] init];
    item.strID = strID;
    item.strChecked = checked;
    item.strName = name;
    item.strSubEventID = sub_event_id;
    item.strMainEventID = main_event_id;
    return item;
}




//CREATE TABLE "main_event" ("id" INTEGER PRIMARY KEY  NOT NULL , "image" TEXT, "name" TEXT, "main_event_web_id" TEXT)

//CREATE TABLE "sub_event" ("id" INTEGER PRIMARY KEY  NOT NULL , "Sub_title" TEXT, "current_date" TEXT, "description" TEXT, "event_date" TEXT, "link" TEXT, "location" TEXT, "location_img" TEXT, "name" TEXT, "price" TEXT, "main_event_id" INTEGER, "sub_event_web_id" TEXT, "main_event_web_id" TEXT)

//CREATE TABLE "event_item" ("id" INTEGER PRIMARY KEY  NOT NULL , "checked" TEXT, "name" TEXT, "sub_event_id" INTEGER, "main_event_id" INTEGER)

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

#pragma mark - View Method

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update_YorN_WebService_Called) name:kUpdateNotification object:nil];
    
    [self loadGIF_View];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    hasFound = NO;
view_Advertisement.hidden=YES;
    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:event_Table.frame];
    view.delegate = self;
    [main_View insertSubview:view belowSubview:event_Table];
    _refreshHeaderView = view;
    _refreshHeaderView.hidden=YES;
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
    //[self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];
    NSString *struserdefaultsvalue=[[NSUserDefaults standardUserDefaults] valueForKey:@"AD"];
    NSLog(@"%@",struserdefaultsvalue);
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"AD"] isEqualToString:@"YES"]) {
        [self performSelector:@selector(Advertise_WebService_called) withObject:nil afterDelay:4.0008];
        
    }else
    {
        view_Advertisement.hidden=YES;
        view_Logout_Second.hidden=YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"AD"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:4.0008];
    }

    
  

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[event_Table reloadData];
    
    
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
    isPullDrag=YES;
    animating=TRUE;
    isAnimatedLastRow=TRUE;
    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    
    [_txt_Search setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    UIFont *font = [UIFont fontWithDescriptor:afont size:16.0];
    _txt_Search.font = font;
    
    btn_Menu.enabled=YES;
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    //    if ([aryEvents count]==0) {
    //        UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    //        UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:16.0];
    //        [_lbl_Header setFont:lblFont];
    //        _lbl_Header.hidden = NO;
    //    }else
    //    {
    //        UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    //        UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:16.0];
    //        [_lbl_Header setFont:lblFont];
    //        _lbl_Header.hidden = YES;
    //    }
    
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    
    
    [self.view endEditing:YES];
}


-(void)Advertise_WebService_called
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *st=[NSString stringWithFormat:@"device_id=%@&device_type=i",app.deviceToke1];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@device_id=%@&device_type=i",ConstantPATH,kAdvertisementURL,app.deviceToke1]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //  NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data!=nil) {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        if (dictTemp==nil) {
            view_Advertisement.hidden=YES;
            view_Logout_Second.hidden=YES;
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"AD"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:3.0];
        }
        
        else
        {
            NSString *str=[dictTemp valueForKey:@"advertisement"];
            
            if (str == (id)[NSNull null]) {
                // tel is null
                NSLog(@"asdasdasdasdasd%@",str);
                view_Advertisement.hidden=YES;
                view_Logout_Second.hidden=YES;
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"AD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:3.0];
            }
            else{
                [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
                id ads = [dictTemp valueForKey:@"advertisement"];
                
                if ([ads isKindOfClass:[NSArray class]]) {
                    NSArray *aryAds = (NSArray *)ads;
                    if ([aryAds count]!=0 ) {
                        NSArray *arr=[[dictTemp valueForKey:@"advertisement"]valueForKey:@"comp_name"];
                        lbl_Advertisement.text=[arr objectAtIndex:0];
                        NSArray *arr_image=[[dictTemp valueForKey:@"advertisement"]valueForKey:@"image"];
                        
                        NSArray *arr_link=[[dictTemp valueForKey:@"advertisement"]valueForKey:@"link"];
                        str_link_advertisement=[arr_link objectAtIndex:0];
                        NSArray *arr_ID=[[dictTemp valueForKey:@"advertisement"]valueForKey:@"id"];
                        str_advertisementID=[arr_ID objectAtIndex:0];
                        
                        lbl_Advertisement.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
                        UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:32.0];
                        
                        [lbl_Advertisement setFont:[UIFont fontWithDescriptor:afont size:32.0]];
                        
                        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageURLPath,[arr_image objectAtIndex:0]]];
                        NSData *data = [NSData dataWithContentsOfURL:imageURL];
                        img_Advertisement.image=[UIImage imageWithData:data];
                        [view_Advertisement.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
                        [view_Advertisement.layer setBorderWidth: 2.0];
                        view_Advertisement.layer.cornerRadius=10.0;
                        view_Advertisement.hidden=NO;
                        view_Logout_Second.hidden=NO;
                        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"AD"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    else
                    {
                        view_Advertisement.hidden=YES;
                        view_Logout_Second.hidden=YES;
                        [self loadGIF_View];
                        [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.0];
                        
                    }
                }
                
                
            }
        }
    }
    else
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connection for advertisement" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        al.tag=9654;
    }
    
    
}

- (IBAction)btn_advertisement_Closed:(id)sender
{
    view_Advertisement.hidden=YES;
    view_Logout_Second.hidden=YES;
    [self loadGIF_View];
    
    [self performSelector:@selector(AdvertiseView_WebService_called) withObject:nil afterDelay:0.0];
    
}


-(void)update_YorN_WebService_Called
{
    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
    [_lblNoFound setFont:lblFont];
    _lblNoFound.hidden = YES;
    _gifView.hidden = NO;
    img_animation.hidden = NO;
    [self loadGIF_View];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?screen=events&device_id=%@",ConstantPATH,UpdateURL,app.deviceToke1]];
    
    
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

-(void)removeGIF_View
{
    _gifView.hidden = YES;
    img_animation.hidden = YES;
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
#pragma mark - WEBSERVICE CALLED
-(void)mainEvents_WS_Called
{
    
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
        strUserID = @"0";
    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
        strUserID = @"0";

    }else
    {
        NSString *strReg_ID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];
        UIImage *logoutImage = [UIImage imageNamed:@"logout-icon_New.png"];
        [_btnLogin setImage:logoutImage forState:UIControlStateNormal];
        strUserID = strReg_ID;
    }
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@user_id=%@&device_id=%@&status=0",ConstantPATH,MainEventURL,strUserID,app.deviceToke1]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    eventConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( eventConnection )
    {
        receivedData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2000) {
        if (buttonIndex==0) {
            
            
            [self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];
        }
    }
    if (alertView.tag==9654) {
        if (buttonIndex==0) {
            
            view_Advertisement.hidden=YES;
            view_Logout_Second.hidden=YES;
            [self loadGIF_View];
            [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.0];
            
        }
    }

}


#pragma mark - CONNECTION DELEGATES
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength: 0];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}

-(void)connectionLostview
{
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connect.Tap Retry to try again" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
    [al show];
    al.tag=2000;

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
    
    if (connection == updateURLConnection) {
        //ShowAlert(@"Warning", @"No Internet Connect.Tap Retry to try again");
        

        //[self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.1];
        NSArray *aryEvents_ = [self selectFromMainEvent];
        
        
        
        if ([aryEvents_ count]==0) {
            
            
            Reachability *hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];
            
            hostStatus=[hostReach currentReachabilityStatus];
            if (hostStatus ==NotReachable) {
                [self performSelector:@selector(connectionLostview) withObject:nil];
            }
            else{
                
                [self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];
                
            }
            
            
        }else
        {
            if (aryEvents) {
                [aryEvents removeAllObjects];
            }else
            {
                aryEvents = [@[] mutableCopy];
            }
            
//            for (NSDictionary *dictEvent in aryEvents_)
//            {
//                MainEvent *event = [self getMainEvents:dictEvent];
//                [aryEvents addObject:event];
//            }
            
            aryEvents = [aryEvents_ mutableCopy];
            
            [event_Table reloadData];
            [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    }else
    {
        dbobj = nil;
        NSArray *aryEvents_ = [self selectFromMainEvent];
        
        
        
        if ([aryEvents_ count]==0) {
            
            
            Reachability *hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];
            
            hostStatus=[hostReach currentReachabilityStatus];
            
            
            if (hostStatus ==NotReachable) {
                
                [self performSelector:@selector(connectionLostview) withObject:nil];
            }
            else{
                
                [self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];
                
            }
            
            
        }else
        {
            if (aryEvents) {
                [aryEvents removeAllObjects];
            }else
            {
                aryEvents = [@[] mutableCopy];
            }
            
//            for (NSDictionary *dictEvent in aryEvents_)
//            {
//                MainEvent *event = [self getMainEvents:dictEvent];
//                [aryEvents addObject:event];
//            }
            
            aryEvents = [aryEvents_ mutableCopy];
            
            [event_Table reloadData];
            [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
        }

    }
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == eventConnection) {
        if(receivedData)
        {
            NSDictionary *dictEvents_ = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            
            NSLog(@"%@",dictEvents_);
            
            if (dictEvents_)
            {
                dictEvents = @{};
                dictEvents = dictEvents_;
                
                NSArray *aryEvents_ = [dictEvents valueForKey:@"event"];
                if ([aryEvents_ count]>0) {
                    dbobj = nil;
                    [self deleteFromMainEvent];
                    dbobj = nil;
                    [self deleteFromSubEvent];
                    dbobj = nil;
                    [self deleteFromSubEventItem];
                }
                aryEvents = [@[] mutableCopy];
                
                for (NSDictionary *dictEvent in aryEvents_)
                {
                    MainEvent *event = [self getMainEvents:dictEvent];
                    dbobj = nil;
                    [self insertIntoMainEvent:event];
                    [aryEvents addObject:event];
                }
                
                NSArray *aryEvents__ = [self selectFromMainEvent];
                
                aryEvents = [aryEvents__ mutableCopy];
                NSLog(@"%@",aryEvents);
                if ([aryEvents count]==0) {
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
                [event_Table reloadData];
                [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

                //[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
            }
        }
    }
    else if  (connection == ADconnection)
    {
        
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        // newsArray = [@[] mutableCopy];
        NSString *strURL = str_link_advertisement;
        NSURL *link = [NSURL URLWithString:strURL];
        [[UIApplication sharedApplication] openURL:link];
        
    }

            else if  (connection == updateURLConnection)
        {

        if(receivedData)
        {
            NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
            NSArray *aryStatus = [dictTemp valueForKey:@"Regiaster_check"];
            NSDictionary *dictStatus = [aryStatus objectAtIndex:0];
            NSString *status = [dictStatus valueForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                
                if (aryEvents) {[aryEvents removeAllObjects];}
                else{aryEvents = [@[] mutableCopy];}
                
                [self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];
            }else
            {
                dbobj = nil;

                NSArray *aryEvents_ = [self selectFromMainEvent];
                if ([aryEvents_ count]==0) {[self performSelector:@selector(mainEvents_WS_Called) withObject:nil afterDelay:0.2];}
                else
                {
                    if (aryEvents) {[aryEvents removeAllObjects];}
                    else{aryEvents = [@[] mutableCopy];}
                    
                    aryEvents = [aryEvents_ mutableCopy];
                    if ([aryEvents count]==0) {
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
                    [event_Table reloadData];
                    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
                }
            }
        }
    
    }
}

#pragma mark Get Sub Event Item
-(SubEventItem *)getSubEventItem:(NSDictionary *)dictItem forSubEventID:(NSString *)subEventID andSubEventName:(NSString *)subEventname ofMainEventID:(NSString *)eventID andMainEventName:(NSString *)eventName
{
    NSString *name = [dictItem valueForKey:@"name"];
    NSString *strID = [dictItem valueForKey:@"id"];
    NSString *checked = [dictItem valueForKey:@"checked"];
    
    SubEventItem *eventItem = [[SubEventItem alloc] init];
    
    eventItem.strID = strID;
    eventItem.strName = name;
    eventItem.strSubEventID = subEventID;
    eventItem.strMainEventID = eventID;
    eventItem.strSubEventName = subEventname;
    eventItem.strMainEventName = eventName;
    eventItem.strChecked = checked;
    
    return eventItem;
}

#pragma mark Get Sub Event
-(SubEvent *)getSubEvents:(NSDictionary *)dictSubEvent forMainEventID:(NSString *)eventID andEventName:(NSString *)eventName
{
    NSString *name = [dictSubEvent valueForKey:@"name"];
    NSString *Check = [dictSubEvent valueForKey:@"checked"];
    NSString *strID = [dictSubEvent valueForKey:@"id"];
    NSString *strLocation = [dictSubEvent valueForKey:@"location"];
    NSString *strLink = [dictSubEvent valueForKey:@"link"];

    NSString *strLocLink = [dictSubEvent valueForKey:@"location_img"];
    NSString *strDate = [dictSubEvent valueForKey:@"event_date"];
    NSString *strCurDate = [dictSubEvent valueForKey:@"current_date"];
    
    NSString * strMP3 = [dictSubEvent valueForKey:@"mp3"];
    
    NSString *strSubTitle = [dictSubEvent valueForKey:@"Sub_title"];
    NSString *strFree = [dictSubEvent valueForKey:@"free"];
    NSString *strPrice = [dictSubEvent valueForKey:@"price"];
    NSString *strDesc = [dictSubEvent valueForKey:@"description"];
    
    //NSString *strImageURL = [NSString stringWithFormat:@"%@%@",ImageURLPath,strImage];
    
    //NSURL *imageURL = [NSURL URLWithString:strImageURL];
    
    NSMutableArray *arySubEventItem = [@[] mutableCopy];
    arySubEventItem = [dictSubEvent valueForKey:@"event_item"];
    
    NSMutableArray *arySubEventItem_M = [@[] mutableCopy];
    for (NSDictionary *dictSubEventItem in arySubEventItem) {
        
        SubEventItem *item = [self getSubEventItem:dictSubEventItem forSubEventID:strID andSubEventName:name ofMainEventID:eventID andMainEventName:eventName];
        dbobj = nil;

        [self insertIntoSubEventItem:item];
        [arySubEventItem_M addObject:item];
    }
    
    SubEvent *subEvent = [[SubEvent alloc] init];
    
    subEvent.strID = strID;
    subEvent.strSubEventName = name;
    subEvent.strLocation = strLocation;
    subEvent.strLocationImageLink = strLocLink;
    subEvent.strEventDate = strDate;
    subEvent.strCurDate = strCurDate;
    subEvent.arySubEventItems = arySubEventItem_M;
    subEvent.strMainEventID = eventID;
    subEvent.strMainEventName = eventName;
    subEvent.strSubEventCheck= Check;
    subEvent.strSubTitle = strSubTitle;
    subEvent.strPrice = strPrice;
    subEvent.strDesc = strDesc;
    subEvent.strFree = strFree;
    subEvent.strMP3 = strMP3;
    subEvent.strLink = strLink;

    return subEvent;
}


#pragma mark Get Main Event
-(MainEvent *)getMainEvents:(NSDictionary *)dictEvent
{
    NSString *name = [dictEvent valueForKey:@"name"];
    NSString *strID = [dictEvent valueForKey:@"id"];
    
    NSString *strImage = [dictEvent valueForKey:@"image"];;
    NSString *strImageURL = [NSString stringWithFormat:@"%@%@",ImageURLPath,strImage];
    NSLog(@"%@",strImageURL);
    
    NSURL *imageURL = [NSURL URLWithString:strImageURL];
    
    NSArray *arySubEvents = @[];
    arySubEvents = [dictEvent valueForKey:@"sub_event"];
    
    NSMutableArray *arySubEvents_M = [@[] mutableCopy];
    for (NSDictionary *dictSubEvent in arySubEvents) {
        SubEvent *subEvent = [self getSubEvents:dictSubEvent forMainEventID:strID andEventName:name];
        dbobj = nil;

        [self insertIntoSubEvent:subEvent];
        [arySubEvents_M addObject:subEvent];
    }
    
    NSString *imageName = [strImageURL lastPathComponent];
    NSString *localImagePath = [self getDownloadEventImage:imageURL forImageName:imageName];
    NSURL *localImageURL = [NSURL fileURLWithPath:localImagePath];
    
    MainEvent *event = nil;//[MainEvent sharedInstance];
    event = [[MainEvent alloc] init];
    
    event.strID = strID;
    event.imageURL = localImageURL;
    event.strName = name;
    event.strImageURL = localImagePath;
    event.arySubEvents = arySubEvents_M;
    return event;
}

-(NSString *)getDownloadEventImage:(NSURL *)imageURL forImageName:(NSString *)imageName
{
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:imagePath atomically:YES];
    return imagePath;
}


#pragma mark -




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
    
    if ([searchText length]==0) {
        
        _refreshHeaderView.hidden=YES;

        searchText = string;
    }else
    {
        if ([string length]==0) {
            searchText =[searchText substringToIndex:[searchText length]-1];
            _refreshHeaderView.hidden=NO;

        }else
        {
            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
        }
        
    }
    
    if ([searchText length]==0) {
        _refreshHeaderView.hidden=YES;
        NSArray *aryEvents_ = [self selectFromMainEvent];//[dictEvents valueForKey:@"event"];
        aryEvents = [@[] mutableCopy];
        
//        for (NSDictionary *dict in aryEvents_) {
//            MainEvent *event = [self getMainEvents:dict];
//            [aryEvents addObject:event];
//        }
        
        aryEvents = [aryEvents_ mutableCopy];
        NSLog(@"ary Events = %@",aryEvents);
        if ([aryEvents count]==0) {
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
        hasFound = NO;
        [event_Table reloadData];
        
    }else
    {
        _refreshHeaderView.hidden=YES;

        NSArray *aryEvents_ = [self selectFromMainEvent_ForRealData];//[dictEvents valueForKey:@"event"];
        NSArray *aryFoundEvents = [aryEvents_ filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name beginswith[cd] %@", searchText]];
        NSLog(@"ary found = %@",aryFoundEvents);
        
        aryFiltered = [@[] mutableCopy];
        for (NSDictionary *dict in aryFoundEvents) {
            
            NSString *strID = [dict valueForKey:@"main_event_web_id"];//[NSString stringWithFormat:@"%d",[[dict valueForKey:@"id"] intValue]];
            MainEvent *event = [self selectFromMainEventWhereEventID:strID];
            [aryFiltered addObject:event];
        }
        
        NSLog(@"ary Props = %@",aryFiltered);
        if ([aryFiltered count]==0) {
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
        hasFound = YES;
        [event_Table reloadData];
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}




#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{  NSLog(@"scrollViewWillBeginDragging");
    _refreshHeaderView.hidden=NO;
    
    [_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{  NSLog(@"scrollViewDidEndDecelerating");
    
    
    
    //[main_View removeGestureRecognizer:swipegestureRecognizer];
}
- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[event_Table setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{ NSLog(@"scrollViewDidEndDragging");
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}






#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.1];
 	//[self mainEvents_WS_Called];
	[self reloadTableViewDataSource];
    
    
}
#pragma mark - Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    //[main_View addGestureRecognizer:swipegestureRecognizer];
    _refreshHeaderView.loading = YES;
   	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.03];
    
}

- (void)doneLoadingTableViewData

{
    
    _refreshHeaderView.loading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:event_Table];
    
    [self dataSourceDidFinishLoadingNewData];
     _refreshHeaderView.hidden=YES;
}




#pragma mark - Tab bar button Clicked

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txt_Search resignFirstResponder];
    
  //  [self.view endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (hasFound) {
        return [aryFiltered count];
    }else
    {
        return [aryEvents count];
    }
//    if (tableView==event_Table) {
//        
//        
//        return [event_Array count];
//    }
//    else if (tableView==tbl_Slider)
//    {
//        return [sliderArray count];
//    }
//    return 0;

}

#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        
        [[NSUserDefaults standardUserDefaults] setValue:FromEvents forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults] setValue:FromEvents forKey:kScreen];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Get the cell
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = (EventTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"EventTableViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     j=indexPath.row;
    
    
    
    MainEvent *event = [[MainEvent alloc] init];
    if (hasFound) {
        event = [aryFiltered objectAtIndex:indexPath.row];
        
    }else
    {
        event = [aryEvents objectAtIndex:indexPath.row];
    }
    NSString *name = event.strName;
    NSURL *imageURL = event.imageURL;
    //3. Setup the cell
    cell.lbl_Date.text = name;
    
    
    
    if ([cell.lbl_Date.text length]>22) {
        cell.lbl_Date.marqueeType = MLContinuous;
        cell.lbl_Date.scrollDuration = 15.0;
        cell.lbl_Date.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        cell.lbl_Date.fadeLength = 10.0f;
        cell.lbl_Date.continuousMarqueeExtraBuffer = 10.0f;
        cell.lbl_Date.tag = 101;
    }
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    [cell.lbl_Date setFont:[UIFont fontWithDescriptor:afont size:28.0]];
    [cell.img_Event.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
    [cell.img_Event.layer setBorderWidth: 2.0];
    [cell.img_Event setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"event_active.png"]];
    //cell.img_Event.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[img_eventArray objectAtIndex:indexPath.row ]]];
    //  cell.detailTextLabel.text = [NSString stringWithFormat:@"details for row number %ld",(long)indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 193;

//    if (tableView==event_Table) {
//        
//        
//        return 193;
//    }
//    else if (tableView==tbl_Slider)
//    {
//        return 47;
//    }
//    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainEvent *event = [[MainEvent alloc] init];
    if (hasFound) {
        event = [aryFiltered objectAtIndex:indexPath.row];
    }else
    {
        event = [aryEvents objectAtIndex:indexPath.row];
    }
    
    id arySubEvents_ = [event arySubEvents];
   
    if ([arySubEvents_ isKindOfClass:NSClassFromString(@"NSString")])
    {
        NSString *alertMsg = [NSString stringWithFormat:@"No Sub Events F or %@",event.strName];
        ShowAlert(@"", alertMsg);
        return;
    }else
    {
        
        [[NSUserDefaults standardUserDefaults] setValue:FromEvents forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        EventListViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"eventlist"];
        verify.event = event;
        [self.navigationController pushViewController:verify animated:NO];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // [UIView setAnimationsEnabled:NO];
    if(tableView == event_Table)
    {
        NSInteger i=aryEvents.count;
        //  NSLog(@"j=%ld",(long)j);
        // NSLog(@"i=%ld",(long)i);
        
        
        if (i==j+1)
        {
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
                [UIView setAnimationsEnabled:NO];
            }
        }
        
        //1. Setup the CATransform3D structure
        
    }
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

-(void)Advertise_send_WS_Called


{
    NSString *st=[NSString stringWithFormat:@"key=click&adv_id=%@",str_advertisementID];
    NSLog(@"KEYSEND=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,ADCountURL]];
    
    
    
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    // NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSString *data1=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"data1 = %@",data1);
    
    if ([data1 isEqualToString:@"0"]) {
        NSString *strURL = str_link_advertisement;
        NSURL *link = [NSURL URLWithString:strURL];
        [[UIApplication sharedApplication] openURL:link];
        
    }
    
    else  if ([data1 isEqualToString:@"1"]) {
        NSString *strURL = str_link_advertisement;
        NSURL *link = [NSURL URLWithString:strURL];
        [[UIApplication sharedApplication] openURL:link];
        
    }
    
    
    
}

-(void)AdvertiseView_WebService_called
{
    NSString *st=[NSString stringWithFormat:@"key=view&adv_id=%@",str_advertisementID];
    NSLog(@"KEYSEND=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,ADCountURL]];
    
    
    
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    // NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSString *data1=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"data1 = %@",data1);
    
    if ([data1 isEqualToString:@"0"]) {
        view_Advertisement.hidden=YES;
        view_Logout_Second.hidden=YES;
        [self loadGIF_View];
        [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.0];
    }
    
    else  if ([data1 isEqualToString:@"1"]) {
        view_Advertisement.hidden=YES;
        view_Logout_Second.hidden=YES;
        [self loadGIF_View];
        [self performSelector:@selector(update_YorN_WebService_Called) withObject:nil afterDelay:0.0];
        
    }
    
}

-(IBAction)btn_Advertisement_image_Clicked:(id)sender
{
    
    
    [self performSelector:@selector(Advertise_send_WS_Called) withObject:nil afterDelay:0.0];
    
    
}


@end
