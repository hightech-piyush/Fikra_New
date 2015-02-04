//
//  LoginViewController.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "LoginViewController.h"
#import "NewsViewController.h"
#import "RegisterViewController.h"
#import "EventsViewController.h"
#import "Constant.h"
#import "ForgotPWDViewController.h"
#import "SliderTableViewCell.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "ContactUsViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface LoginViewController ()

@end

@implementation LoginViewController

CGPoint translatedPoint;
NSInteger _firstX;
NSInteger _firstY;
NSInteger numberofView;
CGSize viewSize;

BOOL isBegan;

@synthesize main_View,isChecked;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [_btn_Check_Uncheck setImage:[UIImage imageNamed:@"remember_me_check_box_i.png"] forState:UIControlStateNormal];
		[_btn_Check_Uncheck addTarget:self action:@selector(btn_chk_Unchk_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *app1=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app1.container.panMode=MFSideMenuPanModeNone;
      [self.navigationController setNavigationBarHidden:YES animated:NO];

//    for (NSString* family in [UIFont familyNames])
//    {
//        // NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"fontname are  %@", name);
//        }
//        
//    }
//    
    
    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    UIFontDescriptor *cfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel-Bold" size:15.0];
    [_txt_Password setFont:[UIFont fontWithDescriptor:cfont size:16.0]];
    [_txt_Username setFont:[UIFont fontWithDescriptor:cfont size:16.0]];
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:17.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    [_lbl_OR setFont:[UIFont fontWithDescriptor:afont size:21.0]];
    
    [_btn_login.titleLabel setFont:[UIFont fontWithDescriptor:bfont size:17.0]];
    [_btn_login setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -6)];
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

-(void)viewWillAppear:(BOOL)animated
{
   
    [_txt_Username setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_Password setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    sliderArray=[[NSMutableArray alloc]init];
    [sliderArray addObject:@"About Us"];
    [sliderArray addObject:@"Terms Of Service"];
    [sliderArray addObject:@"Privacy Statement"];
    [sliderArray addObject:@"Contact Us"];
    img_animation.hidden = YES;
    _gifContainer.hidden = YES;
    _txt_Password.secureTextEntry=YES;
    _gifView.hidden = YES;
    str_remember_username=[[NSUserDefaults standardUserDefaults]objectForKey:kUSERNAME];
    str_remember_password=[[NSUserDefaults standardUserDefaults]objectForKey:kPASSWORD];
    NSLog(@"%@",str_remember_password);
    NSLog(@"%@",str_remember_username);
    
    if ([str_remember_username length]) {
        self.isChecked =YES;
        [_btn_Check_Uncheck setImage:[UIImage imageNamed:@"remember_me_check_box_i.png"] forState:UIControlStateNormal];
        _txt_Username.text=str_remember_username;
        _txt_Password.text=str_remember_password;
        
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

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
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

- (IBAction)btn_LoginClicked:(id)sender {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([_txt_Username.text isEqualToString:@"Username"]||![_txt_Username.text length]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please provide your login details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([emailTest evaluateWithObject:_txt_Username.text] == NO) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter valid email id." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else if ([_txt_Password.text isEqualToString:@"Password"]||![_txt_Password.text length]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please provide your login details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else
    {
        _gifView.hidden = NO;
        img_animation.hidden = NO;
        _gifContainer.hidden = NO;
        [self loadGIF_View];
        [self performSelector:@selector(Login_WS_Called) withObject:nil afterDelay:0.1];
        
        
    }
    
    //    NewsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"news"];
    //    [self.navigationController pushViewController:verify animated:NO];
}

-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(void)Login_WS_Called
{  AppDelegate  *app1 = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *st=[NSString stringWithFormat:@"email=%@&password=%@&device_id=%@&login_status=1&device_type=i",_txt_Username.text,_txt_Password.text,app1.deviceToke1];
    NSLog(@"punit=%@",st);
    
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,LoginURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
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
- (IBAction)btn_ForgotPassword_Clicked:(id)sender
{
    ForgotPWDViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"forgot"];
    [self.navigationController pushViewController:verify animated:NO];
}
- (IBAction)btn_RegisterClicked:(id)sender
{
    RegisterViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"register"];
    [self.navigationController pushViewController:verify animated:NO];
}


- (IBAction)btn_PushSliderClicked:(id)sender
{
    EventsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
    [self.navigationController pushViewController:verify animated:NO];
    
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
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No Internet Connection Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if ([checkMethodWS isEqualToString:@"4646"]) {
        NSString *res;
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        
        NSLog(@"%@",dictTemp);
        
        res=[dictTemp valueForKey:@"status"];
        if ([res isEqualToString:@"1"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Email Confirmation" message:@"Please check your email for activate your account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        }
        else
        {
            
        }
        
    }
    else
    {
        
    
    if(receivedData)
    {NSString *res;
             NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        
        NSLog(@"%@",dictTemp);
          res=[[[dictTemp valueForKey:@"login"]objectAtIndex:0] valueForKey:@"status"];
        Reg_ID=[[[dictTemp valueForKey:@"login"]objectAtIndex:0] valueForKey:@"user_id"];
        NSLog(@"%@",res);
        
        
        
        
             

        NSString *screen =[[NSUserDefaults standardUserDefaults] valueForKey:kScreen];
        
    
        
        if ([res isEqualToString:@"1"]) {
            
            NSArray *aryLimit = [dictTemp objectForKey:@"lenth"];
            strPwd_Max=[[aryLimit objectAtIndex:0]valueForKey:@"password_max"];
            strPwd_Min=[[aryLimit objectAtIndex:0]valueForKey:@"password_min"];
            strPhone_Max=[[aryLimit objectAtIndex:0]valueForKey:@"phone_max"];
            strPhone_Min=[[aryLimit objectAtIndex:0]valueForKey:@"phone_min"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:strPwd_Max forKey:kPasswordMAX];
            [[NSUserDefaults standardUserDefaults] setObject:strPwd_Min forKey:kPasswordMIN];
            [[NSUserDefaults standardUserDefaults] setObject:strPhone_Max forKey:kPHOneMAX];
            [[NSUserDefaults standardUserDefaults] setObject:strPhone_Min forKey:kPHoneMIN];
            
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            

            
            if (isChecked==YES) {
                
                
                [[NSUserDefaults standardUserDefaults] setObject:_txt_Username.text forKey:kUSERNAME];
                [[NSUserDefaults standardUserDefaults] setObject:_txt_Password.text forKey:kPASSWORD];
                [[NSUserDefaults standardUserDefaults] setObject:Reg_ID forKey:kRegister_ID];

                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.navigationController popViewControllerAnimated:NO];

                
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSERNAME];
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPASSWORD];
                  [[NSUserDefaults standardUserDefaults] setObject:Reg_ID forKey:kRegister_ID];
                [[NSUserDefaults standardUserDefaults] synchronize];
               [self.navigationController popViewControllerAnimated:NO];
            }
            
            if ([screen isEqualToString:FromEvents]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateNotification object:nil];
            }else if ([screen isEqualToString:FromNews])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateNotificationNews object:nil];
            }else if ([screen isEqualToString:FromNotif])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateNotificationNotif object:nil];
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kSTATUS];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
        }
        
        else if ([res isEqualToString:@"2"]) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Account activation alert" message:@"Your account is not activated.\n Kindly activate your account" delegate:self cancelButtonTitle:@"Resend" otherButtonTitles:@"OK", nil];
            [al show];
            al.tag=565656;
        }
        else if ([res isEqualToString:@"0"])
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please check your Email Address and Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
            
        }
    }
    
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
}
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==565656) {
        if (buttonIndex==0) {
            [self performSelector:@selector(Login_Activation_WS_Called) withObject:nil afterDelay:0.1];
            
        }
    }
}
-(void)Login_Activation_WS_Called
{
    checkMethodWS=@"4646";
    NSString *st=[NSString stringWithFormat:@"email=%@&id=%@",_txt_Username.text,Reg_ID];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,LoginActivationURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sMessageLength = [NSString stringWithFormat:@"%lu", (unsigned long)[st length]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sMessageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
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
-(void)removeGIF_View
{
    _gifView.hidden = YES;
    img_animation.hidden = YES;
    _gifContainer.hidden = YES;
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


- (IBAction)btn_chk_Unchk_Clicked:(id)sender {
    
    
    if(self.isChecked ==NO){
		self.isChecked =YES;
        NSLog(@"check");
		[_btn_Check_Uncheck setImage:[UIImage imageNamed:@"remember_me_check_box_i.png"] forState:UIControlStateNormal];
		NSLog(@"%d",isChecked);
	}else{
		self.isChecked =NO;
		[_btn_Check_Uncheck setImage:[UIImage imageNamed:@"remember_me_i.png"] forState:UIControlStateNormal];
        NSLog(@"Uncheck");
        NSLog(@"%d",isChecked);
	}
    
}

-(IBAction)btn_back_Clicked:(id)sender
{
       [self.navigationController popViewControllerAnimated:NO];
}

@end
