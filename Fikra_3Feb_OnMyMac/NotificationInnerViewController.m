//
//  NotificationInnerViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "NotificationInnerViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "EventsViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "SliderTableViewCell.h"
#import "MFSideMenu/MFSideMenu.h"
#import "LoginViewController.h"
#import "Constant.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE



@interface NotificationInnerViewController ()

@end

@implementation NotificationInnerViewController
{
    
    
    CGPoint translatedPoint;
    NSInteger _firstX;
    NSInteger _firstY;
    NSInteger numberofView;
    CGSize viewSize;
    
    BOOL isBegan;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
}
@synthesize main_View,notification = _notification;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    CGRect myFrame = lbleventDetail.frame;
    // Resize the frame's width to 280 (320 - margins)
    // width could also be myOriginalLabelFrame.size.width
    myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y, 236, myFrame.size.height);
    lbleventDetail.frame = myFrame;
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
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    [_lbl_event_Title setFont:[UIFont fontWithDescriptor:afont size:24.0]];
    
    [_lbl_event_Name setFont:[UIFont fontWithDescriptor:afont size:22.0]];
    _lbl_event_Name.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    [_lbl_event_first setFont:[UIFont fontWithDescriptor:afont size:20.0]];
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_event_Second setFont:[UIFont fontWithDescriptor:bfont size:18.0]];
    UIFontDescriptor *bcfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [_lbl_header setFont:[UIFont fontWithDescriptor:bcfont size:16.0]];
    [_lbl_headersecond setFont:[UIFont fontWithDescriptor:bcfont size:35.0]];
    // Do any additional setup after loading the view.
}
#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        [[NSUserDefaults standardUserDefaults] setValue:FromNotif forKey:kScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
        LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:verify animated:NO];
    }
    
    else if ([loginStatus isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults] setValue:FromNotif forKey:kScreen];
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
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];

    // UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    //  [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    // [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    
    
    [lbleventDetail sizeToFit];
    lbleventDetail.numberOfLines=0;
    lbleventDetail.textAlignment = NSTextAlignmentLeft;
    lbleventDetail.textColor= [UIColor colorWithRed:127/255.0f green:127/255.0f blue:127/255.0f alpha:1];
    
    [self setupUI:_notification];
    
    if ([_lbl_event_Name.text length]>25) {
        _lbl_event_Name.marqueeType = MLContinuous;
        _lbl_event_Name.scrollDuration = 15.0;
        _lbl_event_Name.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        _lbl_event_Name.fadeLength = 10.0f;
        _lbl_event_Name.continuousMarqueeExtraBuffer = 10.0f;
        _lbl_event_Name.tag = 101;
    }
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
}

-(void)setupUI:(Notification *)notification
{
    NSString *title = [notification strTitle];
    NSString *message = [notification strMsg];
    
    _lbl_event_Name.text = title;
    _lbl_event_first.text = message;
}

#pragma mark - Tab bar button Clicked

-(void)aMethod
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    [self.navigationController pushViewController:verify animated:NO];
    
    
    
//    if ([tag isEqualToString:@"for all"]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        container = (HomeContainerVC *)self.window.rootViewController;
//        
//        self.navController = [storyboard instantiateViewControllerWithIdentifier:@"noti"];
//        //navController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
//        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
//        
//        [container setLeftMenuViewController:leftSideMenuViewController];
//        [container setCenterViewController:self.navController];
//    }else if([tag isEqualToString:@"for event"])
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        container = (HomeContainerVC *)self.window.rootViewController;
//        
//        self.navController = [storyboard instantiateViewControllerWithIdentifier:@"event"];
//        //navController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
//        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
//        
//        [container setLeftMenuViewController:leftSideMenuViewController];
//        [container setCenterViewController:self.navController];
//    }else
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        container = (HomeContainerVC *)_window.rootViewController;
//        navController = [storyboard instantiateViewControllerWithIdentifier:@"news"];
//        
//        //NewsViewController *newsVC = [storyboard instantiateViewControllerWithIdentifier:@"news"];
//        
//        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
//        //  UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
//        
//        [container setLeftMenuViewController:leftSideMenuViewController];
//        // [container setRightMenuViewController:rightSideMenuViewController];
//        [container setCenterViewController:navController];
//    }

    
    
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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(IBAction)btn_BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tbl_Slider)
    {
        return 1;
    }
    return 0;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView==tbl_Slider)
        
    {
        return [sliderArray count];
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==tbl_Slider)
    {
        static NSString *CellIdentifier = @"Cell";
        
        //j=indexPath.row;
        SliderTableViewCell *cell = (SliderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = (SliderTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"SliderTableViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //j=indexPath.row;
        //3. Setup the cell
        
        UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
        [cell.lbl_AboutUS setFont:[UIFont fontWithDescriptor:afont size:24.0]];
         // cell.lbl_year.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
        // cell.lbl_year.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
        cell.lbl_AboutUS.text = [sliderArray objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tbl_Slider)
    {
        return 47;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}*/



#pragma mark - UIScrollViewDelegate Methods

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
