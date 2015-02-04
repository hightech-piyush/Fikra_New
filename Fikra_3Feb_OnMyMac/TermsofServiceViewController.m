//
//  TermsofServiceViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "TermsofServiceViewController.h"
#import "SliderTableViewCell.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "EventsViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "Constant.h"
#import "NotificationViewController.h"
#import "LoginViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface TermsofServiceViewController ()

@end

@implementation TermsofServiceViewController

CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;

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

-(void)About_WSCalled
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,CMSURL]];
    
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
    if(receivedData)
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        
        _txt_View.text=[[[dictTemp objectForKey:@"Terms of Service"]objectAtIndex:0] valueForKey:@"content"];
        NSLog(@"%@",_txt_View.text);
        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

        // newsArray = [@[] mutableCopy];
    }
}

-(IBAction)btn_BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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
    
    MoreViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"more"];
    [self.navigationController pushViewController:verify animated:NO];
    
}

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
    
    _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];

    sliderArray=[[NSMutableArray alloc]init];
    [sliderArray addObject:@"About Us"];
    [sliderArray addObject:@"Terms Of Service"];
    [sliderArray addObject:@"Privacy Statement"];
    [sliderArray addObject:@"Contact Us"];
      _txt_View.textAlignment=NSTextAlignmentJustified;
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
     [self loadGIF_View];
    [self performSelector:@selector(About_WSCalled) withObject:nil afterDelay:0.1];
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
