//
//  EventHistoryViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 10/29/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "EventHistoryViewController.h"
#import "EventHistoryDetailViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "EventListTableViewCell.h"
#import "EventListDetailViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "ContactUsViewController.h"
#import "SliderTableViewCell.h"
#import "LoginViewController.h"
#import "SubEvent.h"
#import "Constant.h"
#import "EventsViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface EventHistoryViewController ()
{
    NSMutableArray *arySubEvents;
    NSMutableData * receivedData;
    NSURLConnection *connectionEventHistoryWS;
    
}
@end

@implementation EventHistoryViewController
CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;
EGORefreshTableHeaderView *_refreshHeaderView;
@synthesize event = _event;

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // Do any additional setup after loading the view.
}



#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      lblNoEVENT.hidden=YES;
    UIFontDescriptor *alblFont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:17.0];
    UIFont *lblFont = [UIFont fontWithDescriptor:alblFont size:17.0];
    [lblNoEVENT setFont:lblFont];

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
    btn_Menu.enabled=YES;
    
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:24.0];
    
    // UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:24.0];
    UIFont *font = [UIFont fontWithDescriptor:afont size:24.0];
    _lbl_EventName.font = font;
    _lbl_EventName.text = _event.strName;
    
    
    _lbl_EventName.textColor = [UIColor lightGrayColor];
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    
    if ([_lbl_EventName.text length]>20) {
        _lbl_EventName.marqueeType = MLContinuous;
        _lbl_EventName.scrollDuration = 15.0;
        _lbl_EventName.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        _lbl_EventName.fadeLength = 10.0f;
        _lbl_EventName.continuousMarqueeExtraBuffer = 10.0f;
        _lbl_EventName.tag = 101;
    }
    
    
//    arySubEvents = [@[] mutableCopy];
//    NSArray *arySubEvents_ = _event.arySubEvents;
//    
//    
//    arySubEvents = [arySubEvents_ mutableCopy];
//    
//    [tbl_eventList reloadData];
    [self loadGIF_View];
    [self performSelector:@selector(eventHistory_WSCalled) withObject:nil afterDelay:0.0];

    
}



-(void)eventHistory_WSCalled
{
    
      _gifView.hidden = NO;
    img_animation.hidden = NO;
    
    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];
    NSString *st = [NSString stringWithFormat:@"user_id=%@",regID];
    NSLog(@"ST=%@",st);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",ConstantPATH,eventHistoryURL,st]];
    //NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPMethod:@"GET"];
    //[request setHTTPBody:data];
    
   connectionEventHistoryWS = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( connectionEventHistoryWS )
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
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == connectionEventHistoryWS) {
        if(receivedData)
        {
            
            NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
            // newsArray = [@[] mutableCopy];
            if (dictTemp)
            {
                
                NSArray *aryTemp = [dictTemp valueForKey:@"sub_event"];
                
                if (![aryTemp isKindOfClass:[NSNull class]]) {
                    arySubEvents = [@[] mutableCopy];
                    for (NSDictionary *dictSubEvent in aryTemp) {
                        SubEvent *subEvent = [self getSubEvents:dictSubEvent];
                        [arySubEvents addObject:subEvent];
                    }
                    
                    [tbl_eventList reloadData];
                    
                    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
                }else
                {
                   
                    lblNoEVENT.hidden=NO;
                    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
                }
                
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

#pragma mark Get Sub Event
-(SubEvent *)getSubEvents:(NSDictionary *)dictSubEvent
{
    /*NSString *name = [dictSubEvent valueForKey:@"name"];
    NSString *Check = [dictSubEvent valueForKey:@"checked"];
    NSString *strID = [dictSubEvent valueForKey:@"id"];
    NSString *strLocation = [dictSubEvent valueForKey:@"location"];
    NSString *strLocLink = [dictSubEvent valueForKey:@"location_img"];
    NSString *strDate = [dictSubEvent valueForKey:@"event_date"];
    NSString *strCurDate = [dictSubEvent valueForKey:@"current_date"];

    NSString *strSubTitle = [dictSubEvent valueForKey:@"Sub_title"];
    NSString *strFree = [dictSubEvent valueForKey:@"free"];
    NSString *strPrice = [dictSubEvent valueForKey:@"price"];
    NSString *strDesc = [dictSubEvent valueForKey:@"description"];
    
    //NSString *strImageURL = [NSString stringWithFormat:@"%@%@",ImageURLPath,strImage];
    
    //NSURL *imageURL = [NSURL URLWithString:strImageURL];
    
    NSMutableArray *arySubEventItem = [@[] mutableCopy];
    //arySubEventItem = [dictSubEvent valueForKey:@"event_item"];
    
    SubEvent *subEvent = [[SubEvent alloc] init];
    
    subEvent.strID = strID;
    subEvent.strSubEventName = name;
    subEvent.strLocation = strLocation;
    subEvent.strLocationImageLink = strLocLink;
    subEvent.strEventDate = strDate;
    subEvent.strCurDate = strCurDate;

    //subEvent.arySubEventItems = arySubEventItem;
    //subEvent.strMainEventID = _event.strID;
    //subEvent.strMainEventName = _event.strName;
    subEvent.strSubEventCheck= Check;
    subEvent.strSubTitle = strSubTitle;
    subEvent.strPrice = strPrice;
    subEvent.strDesc = strDesc;
    subEvent.strFree = strFree;
    
    return subEvent;*/
    
    
    NSString *name = [dictSubEvent valueForKey:@"name"];
    //NSString *Check = [dictSubEvent valueForKey:@"checked"];
    NSString *strID = [dictSubEvent valueForKey:@"id"];
    NSString *strLocation = [dictSubEvent valueForKey:@"location"];
    NSString *strLink = [dictSubEvent valueForKey:@"link"];
    
    NSString *strLocLink = [dictSubEvent valueForKey:@"location_img"];
    NSString *strDate = [dictSubEvent valueForKey:@"event_date"];
    NSString *strCurDate = [dictSubEvent valueForKey:@"current_date"];
    
    NSString * strMP3 = [dictSubEvent valueForKey:@"mp3"];
    
    NSString *strSubTitle = [dictSubEvent valueForKey:@"Sub_title"];
    //NSString *strFree = [dictSubEvent valueForKey:@"free"];
    NSString *strPrice = [dictSubEvent valueForKey:@"price"];
    NSString *strDesc = [dictSubEvent valueForKey:@"description"];
    SubEvent *subEvent = [[SubEvent alloc] init];
    
    subEvent.strID = strID;
    subEvent.strSubEventName = name;
    subEvent.strLocation = strLocation;
    subEvent.strLocationImageLink = strLocLink;
    subEvent.strEventDate = strDate;
    subEvent.strCurDate = strCurDate;
    //subEvent.arySubEventItems = arySubEventItem_M;
    //subEvent.strMainEventID = eventID;
    //subEvent.strMainEventName = eventName;
    //subEvent.strSubEventCheck= Check;
    subEvent.strSubTitle = strSubTitle;
    subEvent.strPrice = strPrice;
    subEvent.strDesc = strDesc;
    //subEvent.strFree = strFree;
    subEvent.strMP3 = strMP3;
    subEvent.strLink = strLink;
    
    return subEvent;
    
}

#pragma mark-

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
    return [arySubEvents count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Get the cell
    
    static NSString *CellIdentifier = @"Cell";
    
    
    EventListTableViewCell *cell = (EventListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = (EventListTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"EventListTableViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    SubEvent *subEvent = [arySubEvents objectAtIndex:indexPath.row];
    NSString *strName = subEvent.strSubEventName;
    NSString *strDesc = subEvent.strDesc;
    //3. Setup the cell
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    [cell.lbl_Title setFont:[UIFont fontWithDescriptor:afont size:21.0]];
    cell.lbl_Title.text = strName;//[event_title_Array objectAtIndex:indexPath.row];
    if ([cell.lbl_Title.text length]>30) {
        cell.lbl_Title.marqueeType = MLContinuous;
        cell.lbl_Title.scrollDuration = 15.0;
        cell.lbl_Title.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        cell.lbl_Title.fadeLength = 10.0f;
        cell.lbl_Title.continuousMarqueeExtraBuffer = 10.0f;
        cell.lbl_Title.tag = 101;
    }
    
    
    //        if ( cell.lbl_Title.center.x < -( cell.lbl_Title.bounds.size.width/2)) {
    //
    //            cell.lbl_Title.center = CGPointMake(self.view.bounds.size.width + ( cell.lbl_Title.bounds.size.width/2),  cell.lbl_Title.center.y);}
    
    cell.lbl_Description.text = strDesc;
    
    //cell.lbl_Description.text=[event_Description_Array objectAtIndex:0];
    //  cell.detailTextLabel.text = [NSString stringWithFormat:@"details for row number %ld",(long)indexPath.row];
    
    return cell;
}




-(void)time:(NSTimer *)thetimer{
    
    NSDictionary *dict = (NSDictionary *)thetimer.userInfo;
    NSIndexPath *indexPath = [dict valueForKey:@"indexPath"];
    
    static NSString *CellIdentifier = @"Cell";
    
    
    EventListTableViewCell *cell = (EventListTableViewCell *)[tbl_eventList cellForRowAtIndexPath:indexPath];
    
    cell.lbl_Title.center = CGPointMake( cell.lbl_Title.center.x-3.5, cell.lbl_Title.center.y);
    
    
    
    if ( cell.lbl_Title.center.x < -  cell.lbl_Title.bounds.size.width/2) {
        cell.lbl_Title.center = CGPointMake(320 +( cell.lbl_Title.bounds.size.width/2), cell.lbl_Title.center.y);
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubEvent *subEvent = [arySubEvents objectAtIndex:indexPath.row];
    EventHistoryDetailViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"eventhistorydetail"];
    verify.subEvent = subEvent;
    [self.navigationController pushViewController:verify animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)btn_BackClicked:(id)sender
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    [self.navigationController pushViewController:verify animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tbl_eventList) {
        
        
        return 68;
    }
    else if (tableView==tbl_Slider)
    {
        return 47;
    }
    return 0;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
