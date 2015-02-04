//
//  MoreViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "MoreViewController.h"
#import "EventsViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "MoreViewCell.h"
#import "SliderTableViewCell.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "LoginViewController.h"
#import "MorePushTableViewCell.h"
#import "Constant.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
@interface MoreViewController ()

@end

@implementation MoreViewController
CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;
EGORefreshTableHeaderView *_refreshHeaderView;

BOOL isBegan;
@synthesize main_View,imgArry,imgArry1,imgArry2,docFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    
    //    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:tbl_More.frame];
    //    view.delegate = self;
    //    [main_View insertSubview:view belowSubview:tbl_More];
    //    _refreshHeaderView = view;
    //    _refreshHeaderView.hidden=YES;
    //
    
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
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button2];
        
        
        
        [button3 addTarget:self
                    action:@selector(aMethod3)
          forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitle:@"" forState:UIControlStateNormal];
        button3.frame = CGRectMake(240,518,80,50);
        [button3 setImage:[UIImage imageNamed:@"more_active.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"more_active.png"] forState:UIControlStateSelected];
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
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateSelected];        [self.view addSubview:button2];
        
        
        
        [button3 addTarget:self
                    action:@selector(aMethod3)
          forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitle:@"" forState:UIControlStateNormal];
        button3.frame = CGRectMake(240,430,80,50);
        [button3 setImage:[UIImage imageNamed:@"more_active.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"more_active.png"] forState:UIControlStateSelected];
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
    
    // [self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.0000002];
    
    // Do any additional setup after loading the view.
}


-(void)notification_WS_Called
{
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?&device_id=%@",ConstantPATH,notificationCheckURL,app.deviceToke1]];
    
    
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
    if (connection == updateURLConnection) {
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        checkSwith_Status=[[[dictTemp valueForKey:@"Push"]objectAtIndex:0]valueForKey:@"status"];
        [tbl_More reloadData];
        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

    }
    else
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        

        NSString *strCheck=[[[dictTemp valueForKey:@"Push"]objectAtIndex:0]valueForKey:@"status"];
        
        if ([strCheck isEqualToString:@"updated"]) {
            //[self performSelector:@selector(notification_WS_Called) withObject:nil afterDelay:0.0000002];
           // [tbl_More reloadData];
[self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _gifView.hidden = NO;
    img_animation.hidden = NO;
    [self loadGIF_View];
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    

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
    btn_Menu.enabled=YES;
    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    tableData = [NSArray arrayWithObjects:@"Facebook", @"Twitter", @"Instagram",@"Youtube",@"Twitch", nil];
    tableData1 = [NSArray arrayWithObjects:@"facebook", @"Twitter", @"Instagram", @"Email", @"Sms", nil];
    tableData2 = [NSArray arrayWithObjects:@"Notification", nil];
    
    
    sliderArray=[[NSMutableArray alloc]init];
    [sliderArray addObject:@"About Us"];
    [sliderArray addObject:@"Terms Of Service"];
    [sliderArray addObject:@"Privacy Statement"];
    [sliderArray addObject:@"Contact Us"];
    imgArry =[[NSMutableArray alloc]init];
   
    [imgArry addObject:@"fb.png"];
    [imgArry addObject:@"twit.png"];
    [imgArry addObject:@"insta.png"];
    [imgArry addObject:@"youtube.png"];
    [imgArry addObject:@"twitch.png"];

    imgArry1 =[[NSMutableArray alloc]init];
    [imgArry1 addObject:@"fb.png"];
    [imgArry1 addObject:@"twit.png"];
    [imgArry1 addObject:@"insta.png"];
    [imgArry1 addObject:@"email.png"];
    [imgArry1 addObject:@"sms.png"];
    
    imgArry2 =[[NSMutableArray alloc]init];
    [imgArry2 addObject:@"notification.png"];
       [self performSelector:@selector(SubmitDataMore) withObject:nil afterDelay:0.0000002];
      _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
}


-(void)SubmitDataMore{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,SocialURL]];
    NSLog(@"sss=%@",url);
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSData *returnData1 = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
    NSError *error;
    NSDictionary *dict;
    if (returnData1) {
        dict  = [NSJSONSerialization JSONObjectWithData:returnData1
                                                options:kNilOptions
                                                  error:&error];
        NSLog(@"data=%@",dict);
    }
    
    
    if ([dict valueForKey:@"social_media"] == (id)[NSNull null]){
        NSLog(@"hhh");
        
        
    }else{
        
        arr = [dict objectForKey:@"social_media"];
        strShareText=[[[dict objectForKey:@"social_media"] objectAtIndex:0]valueForKey:@"share_content"];
    }
     [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)aMethod
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    [self.navigationController pushViewController:verify animated:NO];
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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tbl_More) {
        return 3;
    }
    else if (tableView==tbl_Slider)
    {
        return 1;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    if(isiPhone)
    {
        if (section==0) {
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,45)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            //        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,15,300,44)];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            //  tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor lightGrayColor]; //here you can change the text color of header.
            //    if (isiPhone) {
            [tempLabel setFrame:CGRectMake(15,0,300,45)];
            tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:20];
            tempLabel.font = [UIFont boldSystemFontOfSize:20];
            tempLabel.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
            //    }else
            //    {
            //
            //        [tempLabel setFrame:CGRectMake(15, 15, 300, 44)];
            //        tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:30];
            //        tempLabel.font = [UIFont boldSystemFontOfSize:40];
            //    }
            UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            [tempLabel setFont:[UIFont fontWithDescriptor:afont size:24.0]];
            tempLabel.text=@"Fikra";
            [tempView addSubview:tempLabel];
            return tempView;
        }
        else if (section==1)
        {
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,45)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            //        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,15,300,44)];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            // tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor lightGrayColor]; //here you can change the text color of header.
            //    if (isiPhone) {
            [tempLabel setFrame:CGRectMake(15, 0, 300, 45)];
            tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:20];
            tempLabel.font = [UIFont boldSystemFontOfSize:20];
            UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            [tempLabel setFont:[UIFont fontWithDescriptor:afont size:24.0]];
            //    }else
            //    {
            //
            //        [tempLabel setFrame:CGRectMake(15, 15, 300, 44)];
            //        tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:30];
            //        tempLabel.font = [UIFont boldSystemFontOfSize:40];
            //    }
            tempLabel.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
            tempLabel.text=@"Share Fikra";
            [tempView addSubview:tempLabel];
            return tempView;
            
        }
        else if (section==2){
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,50)];
            tempView.backgroundColor=background;
            return tempView;
        }
        
    }
    else
    {
        //ipad
        
        if (section==0) {
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,55)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            //        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,15,300,44)];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            //  tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor lightGrayColor]; //here you can change the text color of header.
            //    if (isiPhone) {
            [tempLabel setFrame:CGRectMake(15, 0, 300, 44)];
            tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:24];
            tempLabel.font = [UIFont boldSystemFontOfSize:24];
            //    }else
            //    {
            //
            //        [tempLabel setFrame:CGRectMake(15, 15, 300, 44)];
            //        tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:30];
            //        tempLabel.font = [UIFont boldSystemFontOfSize:40];
            //    }
            tempLabel.text=@"Fikra";
            [tempView addSubview:tempLabel];
            return tempView;
        }
        else if (section==1)
        {
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,55)];
            tempView.backgroundColor=background;
            UILabel *tempLabel=[[UILabel alloc]init];
            //        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,15,300,44)];
            tempLabel.backgroundColor=[UIColor clearColor];
            // tempLabel.shadowColor = [UIColor blackColor];
            // tempLabel.shadowOffset = CGSizeMake(0,2);
            tempLabel.textColor = [UIColor lightGrayColor]; //here you can change the text color of header.
            //    if (isiPhone) {
            [tempLabel setFrame:CGRectMake(15, 0, 300, 44)];
            tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:24];
            tempLabel.font = [UIFont boldSystemFontOfSize:24];
            //    }else
            //    {
            //
            //        [tempLabel setFrame:CGRectMake(15, 15, 300, 44)];
            //        tempLabel.font =  [UIFont fontWithName:@"Aleo-Regular" size:30];
            //        tempLabel.font = [UIFont boldSystemFontOfSize:40];
            //    }
            tempLabel.text=@"Share Fikra";
            [tempView addSubview:tempLabel];
            return tempView;
            
        }
        else if (section==2){
            UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
            
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,55)];
            tempView.backgroundColor=background;
            return tempView;
        }
        
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tbl_More) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                
                
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr valueForKey:@"fb_link"] objectAtIndex:0]]];                     }
            if (indexPath.row==1) {
                
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr valueForKey:@"twitter_link"] objectAtIndex:0]]];            }
            if (indexPath.row==2) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr valueForKey:@"instagram_link"] objectAtIndex:0]]];

                 }
            if (indexPath.row==3) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr valueForKey:@"utube_link"] objectAtIndex:0]]];
                
            }
            if (indexPath.row==4) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr valueForKey:@"twitch_link"] objectAtIndex:0]]];
                
            }
            
        }
    }
    else if (tableView==tbl_Slider) {
        if (indexPath.row==0) {
            AboutViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            [self.navigationController pushViewController:verify animated:NO];
            
        }
        else if (indexPath.row==1)
        {
            TermsofServiceViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"terms"];
            [self.navigationController pushViewController:verify animated:NO];
            
        }
        else if (indexPath.row==2)
        {
            PrivacyStatementViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
            [self.navigationController pushViewController:verify animated:NO];
            
        }
        else if (indexPath.row==3)
        {
            ContactUsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
            [self.navigationController pushViewController:verify animated:NO];
            
        }
    }
    
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [tweetSheet setInitialText:strShareText];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't send a Post right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        }
        if (indexPath.row==1) {
            
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:strShareText];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        }
        if (indexPath.row==2) {
            CGRect rect = CGRectMake(0 ,0 , 0, 0);
            NSString  *jpgPath = [[NSBundle mainBundle]pathForResource:@"icon-72" ofType:@"png"];//[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/icon-72.png"];
            
            UIImage *image = [UIImage imageWithContentsOfFile:jpgPath];
            NSData *data = UIImagePNGRepresentation(image);
            
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString * path = [documentsDirectory stringByAppendingPathComponent:@"imageName.igo"];
            
            NSError * error = nil;
            [data writeToFile:path options:NSDataWritingAtomic error:&error];
            
            
            NSURL *igImageHookFile = [[NSURL alloc] initWithString:path];//[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", jpgPath]];
            NSLog(@"JPG path %@", jpgPath);
            NSLog(@"URL Path %@", igImageHookFile);
            self.docFile.UTI = @"com.instagram.photo";
            self.docFile.URL = [NSURL fileURLWithPath:path];
            docFile.delegate = self;
            self.docFile=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
            [self.docFile presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
            
            NSURL *instagramURL = [NSURL URLWithString:@"instagram://media?id=MEDIA_ID"];
            if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
                [self.docFile presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
            }
            else {
                NSLog(@"No Instagram Found");
            }
            
        }
        if (indexPath.row==3) {
            //   NSString *arremail = [[[arr valueForKey:@"contact_email"]objectAtIndex:0]objectAtIndex:0];
            //    NSLog(@"fgfdg%@",arremail);
            MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
            mailComposeVC.mailComposeDelegate = self;
            //  [mailComposeVC setToRecipients:arremail];
            [mailComposeVC setSubject:@"Fikra app for iPhone"];
            [mailComposeVC setMessageBody:strShareText isHTML:NO];
            
            [self presentViewController:mailComposeVC animated:NO completion:nil];
            
        }
        if (indexPath.row==4) {
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            if([MFMessageComposeViewController canSendText])
            {
                 controller.body =strShareText;
                controller.messageComposeDelegate = self;
                
                // [self presentModalViewController:controller animated:YES];
                [self presentViewController:controller animated:NO completion:nil];
            }
            
            
            
        }
        
        
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==tbl_More) {
        
        
        if (section==0) {
            return [imgArry count];
        }
        if (section==1) {
            
            return [imgArry1 count];
            
        }
        if (section==2) {
            
            return [imgArry2 count];
            
        }
    }
      return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==tbl_More){
        static NSString *CellIdentifier = @"Cell";
        
        MoreViewCell *cell = nil;
        
        if(isiPhone)
        {
            if (cell == nil) {
                cell = (MoreViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"MoreViewCell" owner:self options:nil]objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
        }
        else
        {
            if (cell == nil) {
                cell = (MoreViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"MoreViewCell~ipad" owner:self options:nil]objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
        //  cell.cv.layer.borderWidth=1.0;
        //  cell.cv.layer.borderColor=[UIColor lightGrayColor].CGColor;
        UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
        [cell.lblheadline setFont:[UIFont fontWithDescriptor:afont size:21.0]];
        
        if (indexPath.section==0) {
            cell.lblheadline.text=[tableData objectAtIndex:indexPath.row];
            cell.img.image=[UIImage imageNamed:[imgArry objectAtIndex:indexPath.row]];
            
            return cell;
        }
        if (indexPath.section==1) {
            cell.lblheadline.text=[tableData1 objectAtIndex:indexPath.row];
            cell.img.image=[UIImage imageNamed:[imgArry1 objectAtIndex:indexPath.row]];
            
            return cell;
        }
        if (indexPath.section==2) {
            //static NSString *CellIdentifier = @"Cell";
            
            MorePushTableViewCell *cell = nil;
            
            if (cell == nil) {
                cell = (MorePushTableViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"MorePushTableViewCell" owner:self options:nil]objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
            [cell.lblheadline setFont:[UIFont fontWithDescriptor:afont size:21.0]];

            cell.lblheadline.text=[tableData2 objectAtIndex:indexPath.row];
            cell.img.image=[UIImage imageNamed:[imgArry2 objectAtIndex:indexPath.row]];
            [cell.swtch addTarget:self action:@selector(onoff:) forControlEvents:UIControlEventValueChanged];
            
            
            NSString *notiStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kNotificationONOFF];
            
            if ([notiStatus isEqualToString:@"0"]) {
                  [cell.swtch setOn:NO];
            }
            else
            {
                [cell.swtch setOn:YES];
            }

                      return cell;
        }
    }
       return nil;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tbl_More) {
        
        
        if(isiPhone)
        {
            if (IS_IPHONE5)
            {
                return 44;
            }
            else
            {
                return 44;
                //iphone 3.5 inch screen
            }
        }
        else
        {
            return 100;
        }
        
    }
    else if (tableView==tbl_Slider)
    {
        return 47;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView==tbl_More) {
        
        
        if (section==2) {
            return 10;
        }
        else
        {
            return 44.0;
        }
    }
    else
    {
        return 0;
    }
    return 0;
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    //[controller dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:NO completion:nil];
    //[self animateOutL];
}
- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch(result)
    {
        case MessageComposeResultCancelled: break; //handle cancelled event
        case MessageComposeResultFailed: break; //handle failed event
        case MessageComposeResultSent: break; //handle sent event
    }
    [self dismissModalViewControllerAnimated:NO];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2000) {
        if (buttonIndex==0) {
            
            
            
                   }
    }
}
- (IBAction)onoff:(id)sender {
    NSLog(@"SWITCH ON?OFF CALLED");
    [self loadGIF_View];
    
    UISwitch *sw = (UISwitch *)sender;
    NSString *str;
    Reachability *hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];
    
    hostStatus=[hostReach currentReachabilityStatus];
    
    
    if (hostStatus ==NotReachable) {
       
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connect.Please turn on your wifi/device network" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
            [al show];
        al.tag=3000;
        if(sw.on){
           [sw setOn:NO];
            
        
        }
        else{
             [sw setOn:YES];

        }
        
    }
    else{
    

    
  
        if(sw.on){
        str = @"1";
            [[NSUserDefaults standardUserDefaults] setValue:str forKey:kNotificationONOFF];
            
            [[NSUserDefaults standardUserDefaults]synchronize];

        }
    
        else{
        str = @"0";
            [[NSUserDefaults standardUserDefaults] setValue:str forKey:kNotificationONOFF];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?device_id=%@&status=%@",ConstantPATH,notificationCheckURL,app.deviceToke1,str]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
   
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( connection )
	{
		receivedData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
    }
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




@end
