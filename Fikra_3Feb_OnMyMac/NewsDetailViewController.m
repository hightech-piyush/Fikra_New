//
//  NewsDetailViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailTableViewCell.h"
#import "NotificationViewController.h"
#import "EventsViewController.h"
#import "MoreViewController.h"
#import "SliderTableViewCell.h"
#import "LoginViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "NewsViewController.h"
#import "News.h"
#import "Constant.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE


@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController
{
    
    
    CGPoint translatedPoint;
    NSInteger _firstX;
    NSInteger _firstY;
    NSInteger numberofView;
    CGSize viewSize;
    
    BOOL isBegan;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
}

@synthesize main_View,news=_news,docFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)btn_BackClicked:(id)sender
{
    {
        
        
        
        NSArray *ar = [self.navigationController viewControllers];
        
        BOOL ss;
        
        int ad;
        
        for(int s=0;s<ar.count;s++)
            
        {
            
            if([[ar objectAtIndex:s] isKindOfClass:[NewsViewController class]])
                
            {
                
                ad = s;
                
                ss = TRUE;
                
                break;
                
            }
            
            else
                
                ss = FALSE;
            
        }
        
        if(ss == TRUE)
            
            [self.navigationController popToViewController:[ar objectAtIndex:ad] animated:NO];
        
        else
            
        {
            
            NewsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"news"];
            
            [self.navigationController pushViewController:obj animated:FALSE];
            
        }
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
        [button2 setImage:[UIImage imageNamed:@"notification_inactive.png"] forState:UIControlStateSelected];
        [self.view addSubview:button2];
        
        
        
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


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [_descbg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"descrbgimg.png"]]];
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 )
    {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
    }
    
    else if ([loginStatus isEqualToString:@"0"])
    {
        UIImage *loginImage = [UIImage imageNamed:@"usericon.png"];
        [_btnLogin setImage:loginImage forState:UIControlStateNormal];
    }else
    {
        UIImage *logoutImage = [UIImage imageNamed:@"logout-icon_New.png"];
        [_btnLogin setImage:logoutImage forState:UIControlStateNormal];
        
    }
    
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"AgencyFB-Reg" size:28.0];
    [_newsTitle setFont:[UIFont fontWithDescriptor:afont size:24.0]];
    
    [_newsSubTitle setFont:[UIFont fontWithDescriptor:afont size:23.0]];
     _newsSubTitle.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
    
    [_newsSubTitle2 setFont:[UIFont fontWithDescriptor:afont size:21.0]];
   
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:18.0];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    [_txtvDesc setFont:[UIFont fontWithDescriptor:bfont size:18.0]];
   // _txtvDesc.textColor=[UIColor lightGrayColor];
    _txtvDesc.textAlignment=NSTextAlignmentNatural;
    [self setupUIForNews:_news];
    
//    if ([_newsSubTitle.text length]>30) {
//        _newsSubTitle.marqueeType = MLContinuous;
//        _newsSubTitle.scrollDuration = 15.0;
//       _newsSubTitle.animationCurve = UIViewAnimationOptionCurveEaseInOut;
//       _newsSubTitle.fadeLength = 10.0f;
//       _newsSubTitle.continuousMarqueeExtraBuffer = 10.0f;
//       _newsSubTitle.tag = 101;
//    }

}

-(void)setupUIForNews :(News *)news_
{
    NSString *title = [_news title];//[[_news title] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSString *subTitle1 = [_news subtitle1];
    NSString *strDesc = [_news description];

    strLink = [_news link];

    self.newsTitle.text = title;
    self.newsSubTitle.text = subTitle1;
    self.newsSubTitle2.text = @"LINK";
    NSLog(@"%@",strDesc);
    
    self.txtvDesc.text = strDesc;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/* ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
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
}
*/

-(IBAction)btn_Share_Clicked:(id)sender
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [documentsDirectory stringByAppendingPathComponent:@"logo_120.png"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.firebirdsql.org/file/about/ds-firebird-logo-500.png"]];
    UIImage *image = [UIImage imageNamed:@"btn_6.png"]; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    NSError * error = nil;
    [imageData writeToFile:path options:NSDataWritingAtomic error:&error];
    
    
    docFile = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
    docFile.delegate = self;
    [docFile presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
}


- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    if ([self isWhatsApplication:application]) {
        
        controller.UTI = @"net.whatsapp.image";
    }
}
- (BOOL)isWhatsApplication:(NSString *)application {
    if ([application rangeOfString:@"whats"].location == NSNotFound) { // unfortunately, no other way...
        return NO;
    } else {
        return YES;
    }
}

-(IBAction)btn_Link_Clicked:(id)sender
{
    NSString *strURL = strLink;
    NSURL *link = [NSURL URLWithString:strURL];
    [[UIApplication sharedApplication] openURL:link];

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
