//
//  ForgotPWDViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 8/28/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "ForgotPWDViewController.h"
#import "Constant.h"
#import "SliderTableViewCell.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "LoginViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#import "ContactUsViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface ForgotPWDViewController ()

@end

@implementation ForgotPWDViewController
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

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [_forgot_TextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:15.0];
    [brn_Forgot_PWD .titleLabel setFont:[UIFont fontWithDescriptor:afont size:17.0]];
    UIFontDescriptor *cfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel-Bold" size:15.0];
    [_forgot_TextField setFont:[UIFont fontWithDescriptor:cfont size:16.0]];
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
    
    [super viewWillAppear:animated];
    _gifView.hidden = YES;
    img_animation.hidden = YES;
    sliderArray=[[NSMutableArray alloc]init];
    [sliderArray addObject:@"About Us"];
    [sliderArray addObject:@"Terms Of Service"];
    [sliderArray addObject:@"Privacy Statement"];
    [sliderArray addObject:@"Contact Us"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
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


-(IBAction)Forgot_Clicked:(id)sender
{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([_forgot_TextField.text isEqualToString:@"Email"]||![_forgot_TextField.text length]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([emailTest evaluateWithObject:_forgot_TextField.text] == NO) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"PLease Enter Valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else
    { // lblLoading.text=@"Saving your information, please wait...";
        // loadView.hidden=NO;
        _gifView.hidden = NO;
        img_animation.hidden = NO;
        [self loadGIF_View];
        [self.view endEditing:YES];
        [self performSelector:@selector(Forgot_WS_Called) withObject:nil afterDelay:0.1];
      
        
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



-(void)Forgot_WS_Called
{
    checkMethodWS=@"2222";
    NSString *st=[NSString stringWithFormat:@"email=%@",_forgot_TextField.text];
    NSLog(@"URL=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,ForgotURL]];
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
    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:YES];
    ShowAlert(@"Warning", @"Internet Connection Failed");
 
	
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
    else  if ([checkMethodWS isEqualToString:@"2222"])
    {
        
    if(receivedData)
    {NSString *res;
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        
        NSLog(@"%@",dictTemp);
    res=[[[dictTemp valueForKey:@"forget_pwd"]objectAtIndex:0] valueForKey:@"status"];
        RegID=[[[dictTemp valueForKey:@"forget_pwd"]objectAtIndex:0] valueForKey:@"reg_id"];

        NSLog(@"%@",res);
        
        if ([res isEqualToString:@"1"]) {
            
          
            NSLog(@"SuCCESS");
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Please verify your Email Address" message:@"We have sent you your new password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
            al.tag=2000;
            
        }else if ([res isEqualToString:@"2"])
        {
            ShowAlert(@"Warning", @"Email id is not registered");
        }else if ([res isEqualToString:@"0"])
        {
            ShowAlert(@"Warning", @"Email id is not registered");
        }
        
        else if ([res isEqualToString:@"3"]) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Account activation alert" message:@"Your account is not activated.\n Kindly activate your account" delegate:self cancelButtonTitle:@"Resend" otherButtonTitles:@"OK", nil];
            [al show];
            al.tag=565656;
        }

        else
        {
           //  [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please check your Email Address " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
          //  [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
         
            
        }
           [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2000) {
        if (buttonIndex==0) {
           [self.navigationController popViewControllerAnimated:NO];
        }
    }
   else if (alertView.tag==565656) {
        if (buttonIndex==0) {
            [self performSelector:@selector(Login_Activation_WS_Called) withObject:nil afterDelay:0.1];
            
        }
    }

}

-(void)Login_Activation_WS_Called
{
    checkMethodWS=@"4646";
    NSString *st=[NSString stringWithFormat:@"email=%@&id=%@",_forgot_TextField.text,RegID];
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
    
}



#pragma mark - Login Clicked Method
- (IBAction)btn_LoginClicked:(id)sender
{
    LoginViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:verify animated:NO];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tbl_Slider)
    {
        return 1;
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
