//
//  NotificationViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "EventsViewController.h"
#import "MoreViewController.h"
#import "NotificationTableViewCell.h"
#import "SliderTableViewCell.h"
#import "NotificationInnerViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "Constant.h"
#import "MFSideMenu/MFSideMenu.h"
#import "LoginViewController.h"
#import "Notification.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
@interface NotificationViewController ()
{
    NSURLConnection *updateURLConnection;
    NSURLConnection *notificationConnection;
    NSMutableArray *aryNotifications;
    NSMutableArray *notifDataArray;
    NSString *strDate_DB;
    NSString *searchText;
    BOOL hasFound;
    NSMutableArray *aryFiltered;
}
@end

@implementation NotificationViewController
CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;
EGORefreshTableHeaderView *_refreshHeaderView;
BOOL isBegan;
@synthesize main_View;


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

-(void)insertIntoNotification:(Notification *)notification withDate:(NSString *)strDate
//{
//    [self databaseOpen];
//    NSString *q=[NSString stringWithFormat:@"Insert into notification (title,message,notif_date) values ('%@','%@','%@')",notification.strTitle,notification.strMsg,strDate];
//    BOOL success = [dbobj executeNonQuery:q];
//    if (success)
//    {
//    }
//    else
//    {
//    }
//    [dbobj close];
//}
{
    [self databaseOpen];
    NSString *q=[NSString stringWithFormat:@"Insert into notification (title,message,notif_date,notification_web_id) values ('%@','%@','%@','%@')",notification.strTitle,notification.strMsg,strDate,notification.strID];
    BOOL success = [dbobj executeNonQuery:q];
    if (success)
    {
    }
    else
    {
    }
    [dbobj close];
}
//CREATE TABLE "notification" ("id" INTEGER PRIMARY KEY  NOT NULL , "title" TEXT, "message" TEXT, "notif_date" TEXT)
#pragma mark DELETE NEWS FROM DATABASE

-(void)deleteFromNotification
{
    [self databaseOpen];
    NSString *dq=[NSString stringWithFormat:@"Delete from notification"];
    BOOL success = [dbobj executeNonQuery:dq];
    if (success) {
        
    }else
    {}
    [dbobj close];
}

#pragma mark SELECT FROM NOTIFICAITON TO GET NOTIFICAITONs For real Data

-(NSArray *)selectFromNotification_ForRealData
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from notification"];
    NSArray * aryNotifs_=[dbobj executeQuery:cq];
    [dbobj close];
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

    return aryNotifs_;
}


#pragma mark SELECT FROM NOTIFICAITON TO GET NOTIFICAITONs

-(NSArray *)selectFromNotification
{
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from notification"];
    NSArray * aryNotifs_=[dbobj executeQuery:cq];
    [dbobj close];
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    
    
    NSMutableArray *aryNotifs__ = [@[] mutableCopy];
    for (NSDictionary *dictNews in aryNotifs_) {
        NSString *strID = [dictNews valueForKey:@"notification_web_id"];
        Notification *notificaiton = [self selectFromNotificationWhereNotifID:strID];
        [aryNotifs__ addObject:notificaiton];
    }
    
    return aryNotifs__;
}

#pragma mark SELECT NOTIFICAITON FOR SPECIFIC NOTIF ID

-(Notification *)selectFromNotificationWhereNotifID:(NSString *)notifID
{
    //int event_id = [eventID intValue];
    [self databaseOpen];
    NSString *cq=[NSString stringWithFormat:@"select * from notification where notification_web_id = %@",notifID];
    NSArray * aryNotifs_=[dbobj executeQuery:cq];
    [dbobj close];
    
    NSDictionary *dictNotif = [aryNotifs_ objectAtIndex:0];
    
    NSString *strID = [dictNotif valueForKey:@"id"];
    NSString *message = [dictNotif valueForKey:@"message"];
    NSString *title = [dictNotif valueForKey:@"title"];
    
    Notification *notificaiton = [[Notification alloc] init];
    notificaiton.strID = strID;
    notificaiton.strMsg = message;
    notificaiton.strTitle = title;
    
    return notificaiton;
    
}


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update_YorN_WebService_Called_notif) name:kUpdateNotificationNotif object:nil];

    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self loadGIF_View];

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

    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:tbl_notification.frame];
    view.delegate = self;
    [main_View insertSubview:view belowSubview:tbl_notification];
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
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"event_inactive.png"] forState:UIControlStateSelected];
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
        [button2 setImage:[UIImage imageNamed:@"notification_active.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_active.png"] forState:UIControlStateSelected];
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
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"news_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button1];
        
        
        
        
        [button2 addTarget:self
                    action:@selector(aMethod2)
          forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitle:@"" forState:UIControlStateNormal];
        button2.frame = CGRectMake(160,430,80,50);
        [button2 setImage:[UIImage imageNamed:@"notification_active.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_active.png"] forState:UIControlStateSelected];        [self.view addSubview:button2];
        
        
        
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
    
    [self performSelector:@selector(update_YorN_WebService_Called_notif) withObject:nil afterDelay:3.0];

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    

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
  _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
        date_Array=[[NSMutableArray alloc]init];
    description_Array=[[NSMutableArray alloc]init];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy. "];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
    [description_Array addObject:@"In Corporation with the Ministry Yousth and affairs in embessy."];
  
    [date_Array addObject:@"14-8-2014"];
    [date_Array addObject:@"15-8-2014"];
    [date_Array addObject:@"16-8-2014"];
    [date_Array addObject:@"17-8-2014"];
    [date_Array addObject:@"18-8-2014 "];
    
    btn_Menu.enabled=YES;
//    [date_Array addObject:@"19-8-2014"];
//    [date_Array addObject:@"20-8-2014"];
//    [date_Array addObject:@"21-8-2014"];
    
    [_txt_Search setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:16.0];
    UIFont *font = [UIFont fontWithDescriptor:afont size:16.0];
    _txt_Search.font = font;
    

    //[self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];


}


-(void)update_YorN_WebService_Called_notif
{
    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
    [_lblNoFound setFont:lblFont];
    _lblNoFound.hidden = YES;
    _gifView.hidden = NO;
    img_animation.hidden = NO;
    [self loadGIF_View];
    //str_WebServiceCheck=@"6000";
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?screen=notify&device_id=%@",ConstantPATH,UpdateURL,app.deviceToke1]];
    
    
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

-(void)notification_WS_Called
{//Pending
    
    NSString *register_id = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    NSString *strRegiste_id;
    if (register_id == (id)[NSNull null] || register_id.length == 0 ) {
        strRegiste_id=@"0";
    }
  else if ([register_id isEqualToString:@"0"]) {
        
        strRegiste_id=@"0";
        
    }

    else
    {
        strRegiste_id=register_id;
    }

    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSURL *URL=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@device_id=%@&status=0",ConstantPATH,NotificationURL,app.deviceToke1]];
    //NSURL *URL=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,NotificationURL]];
    
    NSLog(@" URL TO PARSE  %@",URL);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    notificationConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( notificationConnection )
    {
        receivedData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    
    
//    NSData *fli=[NSData dataWithContentsOfURL:URL];
//    
//    NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:fli options:kNilOptions error:nil];
//    NSLog(@"%@",dictTemp);
    
    
//   notification_Array=[[NSMutableArray alloc]init];
//    notification_Array= [dictTemp objectForKey:@"notification"];
    
    [tbl_notification reloadData];
  }


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    if ([searchText length]==0) {
//        searchText = string;
//    }else
//    {
//        if ([string length]==0) {
//            searchText =[searchText substringToIndex:[searchText length]-1];
//        }else
//        {
//            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
//        }
//        
//    }
//    
//    if ([searchText length]==0) {
//        
//        NSArray *aryEvents_ = [dictnews valueForKey:@"news"];
//        aryNews = [@[] mutableCopy];
//        
//        for (NSDictionary *dict in aryEvents_) {
//            News *news = [self getNews:dict];
//            [aryNews addObject:news];
//        }
//        NSLog(@"ary Events = %@",aryNews);
//        hasFound = NO;
//        [NewsTable reloadData];
//        
//    }else
//    {
//        NSArray *aryEvents_ = [self selectFromNews_ForRealData];//[dictnews valueForKey:@"news"];
//        NSArray *aryFoundEvents = [aryEvents_ filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"title beginswith[cd] %@", searchText]];
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
//        hasFound = YES;
//        [NewsTable reloadData];
//    }
//    
//    return YES;
//}
//
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}

#pragma mark -


//**********************DONT DELETE COMMENT CODE***********************
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==2000) {
//        if (buttonIndex==0) {
//            
//            
//            [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];
//        }
//    }
//}


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
//    NSArray *aryNotifs_DB = [self selectFromNotification];
//    if ([aryNotifs_DB count]==0) {
////        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connect.Tap Retry to try again" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
////        [al show];
////        al.tag=2000;
//        [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];
//
//        
//          }
//    if (notification_Array) {
//        [notification_Array removeAllObjects];
//    }else
//    {
//        notification_Array = [@[] mutableCopy];
//    }
//    
//    
//    
//    NSMutableArray *aryNotif_DB_Filtered = [aryNotifs_DB mutableCopy];
//    
//    
//    NSMutableArray *filtered;
//    filtered = [NSMutableArray new];
//    while (aryNotif_DB_Filtered.count > 0){
//        NSDictionary *uniqueDate =@{};
//        NSArray *filteredDate;
//        NSMutableArray *newDate;
//        
//        uniqueDate = aryNotif_DB_Filtered[0];
//        
//        
//        filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
//        [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
//        newDate = [NSMutableArray new];
//        for (NSDictionary *oneDate in filteredDate) {
//            Notification *notification = [self getNotification:oneDate];
//            [newDate addObject:notification];
//        }
//        uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
//        [filtered addObject:uniqueDate];
//    };
//    NSLog(@"%@",filtered);
    
    
    NSArray *aryNotifs_DB = [self selectFromNotification_ForRealData];
    if ([aryNotifs_DB count]==0) {
        [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];
    }
    if (notification_Array) {
        [notification_Array removeAllObjects];
    }else
    {
        notification_Array = [@[] mutableCopy];
    }
    
    NSMutableArray *aryNotif_DB_Filtered = [aryNotifs_DB mutableCopy];
    
    
    NSMutableArray *filtered;
    filtered = [NSMutableArray new];
    while (aryNotif_DB_Filtered.count > 0){
        NSDictionary *uniqueDate;
        NSArray *filteredDate;
        NSMutableArray *newDate;
        
        uniqueDate = aryNotif_DB_Filtered[0];
        
        
        filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
        [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
        newDate = [NSMutableArray new];
        for (NSDictionary *oneDate in filteredDate) {
            Notification *notification = [self getNotification:oneDate];
            [newDate addObject:notification];
        }
        uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
        [filtered addObject:uniqueDate];
    };
    
    NSLog(@"%@",filtered);

    
    notification_Array = filtered;
    
    [tbl_notification reloadData];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == notificationConnection) {
        if(receivedData)
        {
            NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
            // newsArray = [@[] mutableCopy];
            if (dictTemp)
            {
                dictNotifs = @{};
                dictNotifs =dictTemp;
                
                
                NSArray *aryNotifs = [dictTemp valueForKey:@"notification"];
                
                if ([aryNotifs count]==0) {
                    [self deleteFromNotification];
                }
               
                for (NSArray * aryNotif in aryNotifs) {
                    NSString *strDate = @"";
                    NSMutableArray *aryNotifLocal = [@[] mutableCopy];
                    NSDictionary *dictNotifLocal = @{};
                    
                    for (int i = 0; i<aryNotif.count; i++)
                    {
                        strDate = [aryNotif objectAtIndex:0];
                        if (i!=0)
                        {
                            NSDictionary *dictNotif = [aryNotif objectAtIndex:i];
                            Notification *notification = [self getNotification:dictNotif];
                            [aryNotifLocal addObject:notification];
                            
                            [self insertIntoNotification:notification withDate:strDate];
                        }
                    }
                    dictNotifLocal = @{strDate:aryNotifLocal};
                    [notification_Array addObject:dictNotifLocal];

                }
                
                NSArray *aryNotifs_ = [self selectFromNotification_ForRealData];
                NSLog(@"LOCAL NEWS = %@",aryNotifs_);
                
                NSMutableArray *aryNotif_DB_Filtered = [aryNotifs_ mutableCopy];
                
                
                NSMutableArray *filtered;
                filtered = [NSMutableArray new];
                while (aryNotif_DB_Filtered.count > 0){
                    NSDictionary *uniqueDate;
                    NSArray *filteredDate;
                    NSMutableArray *newDate;
                    
                    uniqueDate = aryNotif_DB_Filtered[0];
                    
                    
                    filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
                    [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
                    newDate = [NSMutableArray new];
                    for (NSDictionary *oneDate in filteredDate) {
                        Notification *notification = [self getNotification:oneDate];
                        [newDate addObject:notification];
                    }
                    uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
                    [filtered addObject:uniqueDate];
                };
                
                NSLog(@"%@",filtered);
                
                
                notification_Array = filtered;
                
                
                NSLog(@"countries = %@",notification_Array);
                if ([notification_Array count]==0) {
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
                [tbl_notification reloadData];
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
                if (notification_Array) {
                    [notification_Array removeAllObjects];
                }else
                {
                    notification_Array = [@[] mutableCopy];
                }
                [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];
            }else
            {
                NSArray *aryNotifs_DB = [self selectFromNotification_ForRealData];
                if ([aryNotifs_DB count]==0) {
                    [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.2];
                }
                if (notification_Array) {
                    [notification_Array removeAllObjects];
                }else
                {
                    notification_Array = [@[] mutableCopy];
                }
                
                NSMutableArray *aryNotif_DB_Filtered = [aryNotifs_DB mutableCopy];
                
                
                NSMutableArray *filtered;
                filtered = [NSMutableArray new];
                while (aryNotif_DB_Filtered.count > 0){
                    NSDictionary *uniqueDate;
                    NSArray *filteredDate;
                    NSMutableArray *newDate;
                    
                    uniqueDate = aryNotif_DB_Filtered[0];
                    
                    
                    filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
                    [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
                    newDate = [NSMutableArray new];
                    for (NSDictionary *oneDate in filteredDate) {
                        Notification *notification = [self getNotification:oneDate];
                        [newDate addObject:notification];
                    }
                    uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
                    [filtered addObject:uniqueDate];
                };
                
                NSLog(@"%@",filtered);
                
                notification_Array = filtered;
                
                [tbl_notification reloadData];
                
            }
            
        }
        
    }
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

-(void)removeGIF_View
{
    _gifView.hidden = YES;
    img_animation.hidden = YES;
}



-(Notification *)getNotification:(NSDictionary *)dictNotif /*forDate:(NSString *)strDate*/
{
    
    NSString *strID = [dictNotif valueForKey:@"id"];
    NSString *message = [dictNotif valueForKey:@"message"];
    NSString *title = [dictNotif valueForKey:@"title"];

    Notification *notificaiton = [[Notification alloc] init];
    notificaiton.strID = strID;
    notificaiton.strMsg = message;
    notificaiton.strTitle = title;

    return notificaiton;
}



#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
         }

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{      //[main_View removeGestureRecognizer:swipegestureRecognizer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    NSLog(@"egoRefreshTableHeaderDidTriggerRefresh");
    //btn_Menu.enabled=NO;
    // isScroll=YES;
     // isPullDrag=YES;
    
    //tbl_notification.scrollEnabled=NO;
    [self performSelector:@selector(update_YorN_WebService_Called_notif) withObject:nil afterDelay:3.0];
	[self reloadTableViewDataSource];
    
    
}
#pragma mark - Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSLog(@"reloadTableViewDataSource");
	//isScroll=YES;
    //UITableView*table;
    //if (table==tbl_notification) {
        //isPullDrag=YES;
        
        //[main_View addGestureRecognizer:swipegestureRecognizer];
        _refreshHeaderView.loading = YES;
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];

   // }
    
    
}

- (void)doneLoadingTableViewData{
    
    NSLog(@"doneLoadingTableViewData");
    //isScroll=YES;
    //isPullDrag=YES;
    //btn_Menu.enabled=YES;
    
	//tbl_notification.allowsSelection=YES;
    _refreshHeaderView.loading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tbl_notification];
    _refreshHeaderView.hidden=YES;
    //[self RefreshData];
  	
}

-(void)RefreshData
{
    tbl_notification.scrollEnabled=YES;
 
}




#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tbl_notification)
    {
        if (hasFound) {
            return aryFiltered.count;
            
        }
        else
        {
            return notification_Array.count;
            
        }
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tbl_notification) {
        if (hasFound) {
            NSDictionary *dicDateNotfs = [aryFiltered objectAtIndex:section];
            NSArray *aryKeys = [dicDateNotfs allKeys];
            NSArray *aryNotifs = [dicDateNotfs valueForKey:[aryKeys objectAtIndex:0]];
            
            //NSArray *arr = [notification_Array objectAtIndex:section];
            return aryNotifs.count;
        }
        else
        {
            NSDictionary *dicDateNotfs = [notification_Array objectAtIndex:section];
            NSArray *aryKeys = [dicDateNotfs allKeys];
            NSArray *aryNotifs = [dicDateNotfs valueForKey:[aryKeys objectAtIndex:0]];
            
            //NSArray *arr = [notification_Array objectAtIndex:section];
            return aryNotifs.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Get the cell
    
    if (tableView==tbl_notification) {
        
        
        static NSString *CellIdentifier = @"Cell";
        
        
        NotificationTableViewCell *cell = (NotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = (NotificationTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"NotificationTableViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //3. Setup the cell
        NSLog(@"section = %ld",(long)indexPath.section);
        NSDictionary *dicDateNotfs = @{};
        if (hasFound)
        {
            dicDateNotfs = [aryFiltered objectAtIndex:indexPath.section];
            
        }
        else
        {
            dicDateNotfs = [notification_Array objectAtIndex:indexPath.section];
        }
        NSArray *aryKeys = [dicDateNotfs allKeys];
        NSArray *aryNotifs =[dicDateNotfs valueForKey:[aryKeys objectAtIndex:0]]; //[aryKeys objectAtIndex:0];
        
        
        Notification *notification = [aryNotifs objectAtIndex:indexPath.row];
        NSString *message = notification.strMsg;
        
        cell.lbl_Description.text = message;
        //[[[notification_Array objectAtIndex:indexPath.section] objectAtIndex:(indexPath.row+1)] objectForKey:@"message"];
        
        cell.lbl_Description.textColor= [UIColor colorWithRed:127/255.0f green:127/255.0f blue:127/255.0f alpha:1];
        
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tbl_notification) {
        return 79;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tbl_notification) {
        
        NSDictionary *dicDateNotfs = @{};
        if (hasFound)
        {
            dicDateNotfs = [aryFiltered objectAtIndex:indexPath.section];
            
        }
        else
        {
            dicDateNotfs = [notification_Array objectAtIndex:indexPath.section];
            
        }
        
        NSArray *aryKeys = [dicDateNotfs allKeys];
        NSArray *aryNotifs =[dicDateNotfs valueForKey:[aryKeys objectAtIndex:0]]; //[aryKeys objectAtIndex:0];
        
        
        Notification *notification = [aryNotifs objectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setValue:FromNotif forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NotificationInnerViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"notisecond"];
        verify.notification = notification;
        [self.navigationController pushViewController:verify animated:NO];
        
    }
    
}
#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
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




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView==tbl_notification) {
        
    
    
    if(isiPhone)
    {
        
        return 35.0;
        //iphone 3.5 inch screen
        
    }
    else
    {
        return 47;
    }
    }
    else
    {
        return 0;
    }
    return 0;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==tbl_notification) {
        
        
        if(isiPhone)
        {
            
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"search.png"]];
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,50)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            // tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1]; //here you can change the text color of header.
            [tempLabel setFrame:CGRectMake(8,-3,300,35)];
            //tempLabel.font =  [UIFont fontWithName:@"Verdana" size:17];
            UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
            [tempLabel setFont:[UIFont fontWithDescriptor:bfont size:17.0]];
            // tempLabel.font = [UIFont boldSystemFontOfSize:25];
            
            NSDictionary *dict = @{};
            
            if (hasFound)
            {
                dict = [aryFiltered objectAtIndex:section];
                
            }
            else
            {
                dict = [notification_Array objectAtIndex:section];
                
            }
            
            
            NSArray *aryKeys = [dict allKeys];
            NSString *strKey = [aryKeys objectAtIndex:0];
            tempLabel.text = [NSString stringWithFormat:@"%@",strKey];//[[notification_Array objectAtIndex:section] objectAtIndex:0]
            // tempLabel.text = [NSString stringWithFormat:@"%@",[[date_Array objectAtIndex:section] objectAtIndex:0]];
            
            //    for (int i=0; i<=[headerdata count]; i++) {
            //        tempLabel.text=[NSString stringWithFormat:@"%@",[headerdata objectAtIndex:i]];
            //
            //        NSLog(@"pppp%@",tempLabel.text);
            //    }
            //    NSLog(@"kkk%@",tempLabel.text);
            [tempView addSubview:tempLabel];
            return tempView;
            
            
        }
        else
        {
            
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bbg.png"]];
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,55)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            // tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor blueColor]; //here you can change the text color of header.
            [tempLabel setFrame:CGRectMake(10,10,300,35)];
            tempLabel.font =  [UIFont fontWithName:@"Verdana" size:22];
            // tempLabel.font = [UIFont boldSystemFontOfSize:25];
            tempLabel.text = @"Monday 23/7/2014";
            // tempLabel.text = [NSString stringWithFormat:@"%@",[[date_Array objectAtIndex:section] objectAtIndex:0]];
            
            //    for (int i=0; i<=[headerdata count]; i++) {
            //        tempLabel.text=[NSString stringWithFormat:@"%@",[headerdata objectAtIndex:i]];
            //
            //        NSLog(@"pppp%@",tempLabel.text);
            //    }
            //    NSLog(@"kkk%@",tempLabel.text);
            [tempView addSubview:tempLabel];
            return tempView;
        }
        
    }
    else
    {
        return 0;
    }
    return  0;
    // -(void)btnyes:(id)sender{
    
    //    }
    
    //-(void)btnno:(id)sender{
    
    //    }
    
    
    
}



#pragma mark - Tab bar button Clicked

-(void)aMethod
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController pushViewController:verify animated:NO];

}

-(void)aMethod1{
    
    NewsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"news"];
    [self.navigationController pushViewController:verify animated:NO];
   }
-(void)aMethod2{
    
   
    
    
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

#pragma mark - TEXTFILED DELEGATE
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    searchText = textField.text;
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([searchText length]==0) {
        searchText = string;
    }else
    {
        if ([string length]==0) {
            searchText =[searchText substringToIndex:[searchText length]-1];
        }else
        {
            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
        }
        
    }
    
    if ([searchText length]==0) {
        
        
        NSArray *aryNotifs_ = [self selectFromNotification_ForRealData];
        NSLog(@"LOCAL NEWS = %@",aryNotifs_);
        
        NSMutableArray *aryNotif_DB_Filtered = [aryNotifs_ mutableCopy];
        
        
        NSMutableArray *filtered;
        filtered = [NSMutableArray new];
        while (aryNotif_DB_Filtered.count > 0)
        {
            NSDictionary *uniqueDate;
            NSArray *filteredDate;
            NSMutableArray *newDate;
            
            uniqueDate = aryNotif_DB_Filtered[0];
            
            
            filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
            [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
            newDate = [NSMutableArray new];
            for (NSDictionary *oneDate in filteredDate) {
                Notification *notification = [self getNotification:oneDate];
                [newDate addObject:notification];
            }
            uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
            [filtered addObject:uniqueDate];
        };
        
        NSLog(@"%@",filtered);
        
        
        notification_Array = filtered;
        
        
        NSLog(@"countries = %@",notification_Array);
        if ([notification_Array count]==0) {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = NO;
            tbl_notification.tableFooterView = nil;
            
        }else
        {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = YES;
            tbl_notification.tableFooterView = nil;
            
        }
        hasFound = NO;
        [tbl_notification reloadData];
    }else
    {
        
        NSArray *arynots = [self selectFromNotification_ForRealData];
        NSArray *aryFoundNots = [arynots filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"message CONTAINS[cd] %@", searchText]];
        NSLog(@"aryfounds %@",aryFoundNots);
        
        
        aryFiltered = [@[] mutableCopy];
        
        NSMutableArray *aryNotif_DB_Filtered = [aryFoundNots mutableCopy];
        
        
        NSMutableArray *filtered;
        filtered = [NSMutableArray new];
        while (aryNotif_DB_Filtered.count > 0){
            NSDictionary *uniqueDate;
            NSArray *filteredDate;
            NSMutableArray *newDate;
            
            uniqueDate = aryNotif_DB_Filtered[0];
            
            
            filteredDate = [aryNotif_DB_Filtered filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"notif_date LIKE %@",uniqueDate[@"notif_date"]]];
            [aryNotif_DB_Filtered removeObjectsInArray:filteredDate];
            newDate = [NSMutableArray new];
            for (NSDictionary *oneDate in filteredDate) {
                Notification *notification = [self getNotification:oneDate];
                [newDate addObject:notification];
            }
            uniqueDate = @{uniqueDate[@"notif_date"]:newDate};
            [filtered addObject:uniqueDate];
        };
        
        NSLog(@"%@",filtered);
        
        
        aryFiltered = filtered;
        
        
        NSLog(@"countries = %@",aryFiltered);
        if ([aryFiltered count]==0) {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = NO;
            tbl_notification.tableFooterView = nil;
            _refreshHeaderView.hidden=YES;
        }else
        {
            UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:28.0];
            [_lblNoFound setFont:lblFont];
            _lblNoFound.hidden = YES;
            tbl_notification.tableFooterView = nil;
        }
        hasFound = YES;
        [tbl_notification reloadData];
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
