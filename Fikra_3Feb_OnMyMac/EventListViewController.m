//
//  EventListViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "EventListViewController.h"
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
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE


@interface EventListViewController ()
{
    NSMutableArray *arySubEvents;

}
@end

@implementation EventListViewController
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
//    event_title_Array=[[NSMutableArray alloc]init];
//    event_Description_Array=[[NSMutableArray alloc]init];
//    [event_title_Array addObject:@"GX"];
//    [event_title_Array addObject:@"PX"];
//    [event_title_Array addObject:@"MEGA EVENT"];
//    [event_title_Array addObject:@"NEWS EVENT"];
//    [event_title_Array addObject:@"GXTP "];
//    [event_title_Array addObject:@"MXKSLDI"];
//    [event_title_Array addObject:@"GREAT BASH"];
//    [event_title_Array addObject:@"BEAT OF MUSIC"];
//    [event_title_Array addObject:@"BLALA"];
//    [event_title_Array addObject:@"AJJ"];
//
//    [event_Description_Array addObject:@"sf sadf sad sdaf asdf dsa ff sadf sadf as fas dfsd "];
//    [event_Description_Array addObject:@"ashsad fasdsad fsda fsdf f sad fsadf sad fvin"];
//    [event_Description_Array addObject:@"jeksadf sdaf sadf sad fil"];
//    [event_Description_Array addObject:@"mosad fads fsda fshsin"];
//    [event_Description_Array addObject:@"piysdaf sadf asd fsad fsd fadsush "];
//    [event_Description_Array addObject:@"Rasadf husadf asdf ssaf sad fl"];
//    [event_Description_Array addObject:@"mohsadf sadfsdfs df sin"];
//    [event_Description_Array addObject:@"assdf sd fsad fsad fsa hvin"];
//    [event_Description_Array addObject:@"Rasdf sdf sa fas hul"];
//    [event_Description_Array addObject:@"mohsafsdfsf sdaf ssa dfsin"];
//    sliderArray=[[NSMutableArray alloc]init];
//    [sliderArray addObject:@"ABOUT US"];
//    [sliderArray addObject:@"TERMS OF SERVICE"];
//    [sliderArray addObject:@"PRIVACY STATEMENT"];
//    [sliderArray addObject:@"CONTACT US"];
    
    arySubEvents = [@[] mutableCopy];
    NSArray *arySubEvents_ = _event.arySubEvents;
    
    /*for (NSDictionary *dictSubEvent in arySubEvents_) {
        //SubEvent *subEvent = [self getSubEvents:dictSubEvent];
        [arySubEvents addObject:subEvent];
    }*/
    
    arySubEvents = [arySubEvents_ mutableCopy];
    
    [tbl_eventList reloadData];
    
    

}

#pragma mark Get Sub Event
-(SubEvent *)getSubEvents:(NSDictionary *)dictSubEvent
{
    NSString *name = [dictSubEvent valueForKey:@"name"];
      NSString *Check = [dictSubEvent valueForKey:@"checked"];
    NSString *strID = [dictSubEvent valueForKey:@"id"];
    NSString *strLocation = [dictSubEvent valueForKey:@"location"];
    NSString *strLocLink = [dictSubEvent valueForKey:@"location_img"];
    NSString *strDate = [dictSubEvent valueForKey:@"event_date"];
    
    NSString *strSubTitle = [dictSubEvent valueForKey:@"Sub_title"];
    NSString *strFree = [dictSubEvent valueForKey:@"free"];
    NSString *strPrice = [dictSubEvent valueForKey:@"price"];
    NSString *strDesc = [dictSubEvent valueForKey:@"description"];

    //NSString *strImageURL = [NSString stringWithFormat:@"%@%@",ImageURLPath,strImage];
    
    //NSURL *imageURL = [NSURL URLWithString:strImageURL];
    
    NSMutableArray *arySubEventItem = [@[] mutableCopy];
    arySubEventItem = [dictSubEvent valueForKey:@"event_item"];
    
    SubEvent *subEvent = [[SubEvent alloc] init];
    
    subEvent.strID = strID;
    subEvent.strSubEventName = name;
    subEvent.strLocation = strLocation;
    subEvent.strLocationImageLink = strLocLink;
    subEvent.strEventDate = strDate;
    subEvent.arySubEventItems = arySubEventItem;
    subEvent.strMainEventID = _event.strID;
    subEvent.strMainEventName = _event.strName;
    subEvent.strSubEventCheck= Check;
    subEvent.strSubTitle = strSubTitle;
    subEvent.strPrice = strPrice;
    subEvent.strDesc = strDesc;
    subEvent.strFree = strFree;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    EventListDetailViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"eventlistdetail"];
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
    [self.navigationController popViewControllerAnimated:NO];
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

@end
