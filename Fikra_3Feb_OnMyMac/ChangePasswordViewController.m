//
//  ChangePasswordViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 10/29/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NewsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "LoginViewController.h"
#import "EventsViewController.h"
#import "NotificationViewController.h"
#import "MoreViewController.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
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

    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:17.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    // Do any additional setup after loading the view.
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    
    pswrdMAX = [[NSUserDefaults standardUserDefaults] valueForKey:kPasswordMAX];
    NSLog(@"%@",pswrdMAX);

    
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    [self removeGIF_View];
    [_txt_oldPswrd setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_ConfimPaswrd setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_txt_NewPaswrd setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel-Bold" size:15.0];
    [_txt_NewPaswrd setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_ConfimPaswrd setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_oldPswrd setFont:[UIFont fontWithDescriptor:bfont size:17]];
     _lbl_Warning.textColor= [UIColor colorWithRed:51/255.0f green:204/255.0f blue:255/255.0f alpha:1];
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

}

-(IBAction)btn_BackClicked:(id)sender
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

-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
          [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField ==_txt_oldPswrd)
    {
        
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[pswrdMAX intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }

        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    else if(textField ==_txt_NewPaswrd)
    {
        
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[pswrdMAX intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }

        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else if(textField ==_txt_ConfimPaswrd)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[pswrdMAX intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }
        
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    
    
    else
        return YES;
    
    //    if ([searchText length]==0) {
    //
    //
    //        searchText = string;
    //    }else
    //    {
    //        if ([string length]==0) {
    //            searchText =[searchText substringToIndex:[searchText length]-1];
    //
    //        }else
    //        {
    //            searchText = [NSString stringWithFormat:@"%@%@",searchText,string];
    //        }
    //        
    //    }
    
}



-(IBAction)btn_ChangePswrdClicked:(id)sender
{
    if ([_txt_oldPswrd.text isEqualToString:@"Old Password"]||![_txt_oldPswrd.text length]){
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter Old password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        
        
    }
    else if ([_txt_NewPaswrd.text length]>15) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter password below 15 digit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else if ([_txt_NewPaswrd.text length]<5)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter your password having minimum 5 characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    } else if ([_txt_ConfimPaswrd.text isEqualToString:@"Confirm Password"]||![_txt_ConfimPaswrd.text length]) {
        
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Enter Confirm Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    }
    
    else if ([_txt_ConfimPaswrd.text length]>15) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter password below 15 digit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else if (![_txt_NewPaswrd.text isEqualToString:_txt_ConfimPaswrd.text]) {
        
        
        _txt_NewPaswrd.text=nil;
        _txt_ConfimPaswrd.text=nil;
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Password Mismatch" message:@"Please Verify Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    }
    else
    {
        [self loadGIF_View];
        [self performSelector:@selector(changePswrd_WSCalled) withObject:nil afterDelay:0.1];

    }

}

-(void)changePswrd_WSCalled
{
    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];
    NSString *st = [NSString stringWithFormat:@"user_id=%@&old_password=%@&new_password=%@",regID,_txt_oldPswrd.text,_txt_NewPaswrd.text];
    NSLog(@"ST=%@",st);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,ChangePswrdURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
 NSURLConnection *  uploadMP3Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( uploadMP3Connection )
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
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];
    
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    NSLog(@"%@",dictTemp);
    
    NSString *status=[[[dictTemp valueForKey:@"response"]objectAtIndex:0] valueForKey:@"status"];
    if ([status isEqualToString:@"0"])
    
    {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Operation failed, try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
         [self.view endEditing:YES];
    }
   else if ([status isEqualToString:@"1"])
        
    {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Information" message:@"Password changed successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        _txt_NewPaswrd.text=nil;
        _txt_ConfimPaswrd.text=nil;
        _txt_oldPswrd.text=nil;
        [self.view endEditing:YES];
        
    }
   else if ([status isEqualToString:@"2"])
       
   {
       
       UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter correct old password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       [al show];
        [self.view endEditing:YES];

   }
     [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
