//
//  EventImageViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "EventImageViewController.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "EventsViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"
#import "NotificationViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "LoginViewController.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface EventImageViewController ()

@end

@implementation EventImageViewController
@synthesize aryImageURLs = _aryImageURLs;
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







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btn_BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}





#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    img_Array=[[NSMutableArray alloc]init];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
//    [img_Array addObject:@"temp1.png"];
//    [img_Array addObject:@"temp2.png"];
//   [img_Array addObject:@"temp3.png"];
    
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
    
    _icarousel.delegate = nil;
    _icarousel.dataSource = nil;

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

    _icarousel.delegate = self;
    _icarousel.dataSource = self;
    
    _icarousel.type = iCarouselTypeCoverFlow2;
    _icarousel.pagingEnabled = YES;
    [_icarousel setBounces:NO];
    
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
}

#pragma mark - iCarousal
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 1;//[img_Array count];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //UILabel *label = nil;
    UIImageView *iv = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later _icarousel.bounds
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        //        NSURL *url = [NSURL URLWithString:[arr objectAtIndex:index]];
        //        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        //        UIImage *image = [[UIImage alloc] initWithData:data];
        
        iv = [[UIImageView alloc] initWithFrame:view.bounds];
        //        [iv setImage: image];
        iv.tag = 1;
        
        
        //        label = [[UILabel alloc] initWithFrame:view.bounds];
        //        label.backgroundColor = [UIColor clearColor];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        label.font = [label.font fontWithSize:50];
        //        label.tag = 1;
        //        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        //label = (UILabel *)[view viewWithTag:1];
        iv = (UIImageView *)[view viewWithTag:1];
    }
    
    //set background color
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //    view.backgroundColor = [UIColor colorWithRed:red
    //                                           green:green
    //                                            blue:blue
    //                                           alpha:1.0];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [arr[index] stringValue];
    
    //UIImage *img = [UIImageimageNamed:[img_Array objectAtIndex:index]];
    NSString *strImage = [_subEvent strLocationImageLink];
    NSString *strImageURL = [NSString stringWithFormat:@"%@%@",ImageURLPath,strImage];
    NSURL *imageURL = [NSURL URLWithString:strImageURL];
    
    [iv setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"event_active.png"]];
    
    //NSURL *url = [NSURL URLWithString:[jpegFiles objectAtIndex:index]];
    //[iv setImage:[UIImage imageWithContentsOfFile:<#(NSString *)#>]];
    //[iv setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    //NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    //UIImage *image = [[UIImage alloc] initWithData:data];
    //[iv setImage: image];
    [view addSubview:iv];
    return view;
    
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //    NSLog(@"%s", __FUNCTION__);
    int ind = (int)[carousel currentItemIndex];
    NSLog(@"%d",ind);
    //    NSDictionary *dict = [_jpegFiles objectAtIndex:ind];
    //    NSString *type = [dict valueForKey:@"type"];
    //    if ([type isEqualToString:@"video"]) {
    //        [_ivPlay setHidden:NO];
    //    }else
    //    {
    //        [_ivPlay setHidden:YES];
    //    }
    
    [_icarousel scrollToItemAtIndex:ind animated:YES];
    //vid_g = ind;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSString *strURL = [_subEvent strLink];
    NSURL *link = [NSURL URLWithString:strURL];
    [[UIApplication sharedApplication] openURL:link];
    
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




- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
