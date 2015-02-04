//
//  MyProfileViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 10/28/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "MyProfileViewController.h"
#import "Constant.h"
#import "NewsViewController.h"
#import "Nationality.h"
#import "MFSideMenu/MFSideMenu.h"
#import "EventsViewController.h"
#import "LoginViewController.h"
@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

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
    arr = [NSArray arrayWithObjects:@"Male",@"Female", nil];
    
    _datepicker1.maximumDate = [NSDate date];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    // Do any additional setup after loading the view.
}

#pragma mark ---GET DATE IN EITHER STRING OR DATE TYPE
-(NSDate *)getDateFromString:(NSString *)strDate
{
    
    NSDateFormatter *tempFormatter2 = [[NSDateFormatter alloc]init];
    [tempFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateWithoutTime = [tempFormatter2 dateFromString:strDate];
    return dateWithoutTime;
}
-(NSString *)getStringDateWithFormat_yyyy_MM_dd_FromDate:(NSDate *)date
{
    NSDateFormatter *tempFormatter2 = [[NSDateFormatter alloc]init];
    [tempFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [tempFormatter2 stringFromDate:date];
    return strDate;
}
-(NSDate *)getDateWithFormat_dd_MM_yyyy_FromString:(NSString *)strDate
{
    
    NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
    [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *date =[dateFormatterWS dateFromString:strDate];
    return date;
    
}
-(NSString *)getStringDateFromDate:(NSDate *)buttonDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [df stringFromDate:buttonDate];
    return strDate;
    
}

-(void)Nationality_WS_Called
{
    
    
    check_WS_Method=@"1000";
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,NationalityURL]];
    
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
    
    //    //[request setHTTPMethod:@"GET"];
    //      //    NSLog(@"srt:%@",recievedStr);
    //    if(responseData)
    //    {
    //        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    //         NSLog(@"%@",dictTemp);
    //        NSArray *arr = [dictTemp objectForKey:@"business_category"];
    //        NSLog(@"%@",arr);
    //        //return arr;
    //    }
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    _bigScrollView.scrollEnabled=YES;
    
    _bigScrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,810.0,0.0);

    
    //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    _bigScrollView.scrollEnabled=YES;
    
    _bigScrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,1200,0.0);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    phnMAX = [[NSUserDefaults standardUserDefaults] valueForKey:kPHOneMAX];
    NSLog(@"%@",phnMAX);
    

    
     strCountryID = [[NSUserDefaults standardUserDefaults] valueForKey:kNatinalityID];
    strGender = @"";
    check_WS_Method=@"";
    strDob=@"";
    _txt_ConfirmPassword.secureTextEntry=YES;
    _txt_Password.secureTextEntry=YES;
    view_Logout.hidden=YES;
    view_Logout_Second.hidden=YES;
    _dp.tag=1;
    [self loadGIF_View];
    
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

    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:16.0];
    
    [_lbl_Header setFont:[UIFont fontWithDescriptor:bfont size:16.0]];
    [_lbl_FirstHeader setFont:[UIFont fontWithDescriptor:bfont size:35.0]];
    
    
    [_txt_name setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_nickName setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_phone setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_Password setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_lbl_Nationality setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_lbl_Gender setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_lbl_Dob setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_ConfirmPassword setFont:[UIFont fontWithDescriptor:bfont size:17]];
    [_txt_email setFont:[UIFont fontWithDescriptor:bfont size:17]];
    
    
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:18.0];
    [_btn_Register.titleLabel setFont:[UIFont fontWithDescriptor:afont size:18.0]];
    [_btn_Register setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 20 )];
    pickerView.hidden=YES;
    _datepicker1.hidden=YES;
    
    _bigScrollView.scrollEnabled=YES;
    
    _bigScrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,600.0,0.0);
    
    [self performSelector:@selector(Nationality_WS_Called) withObject:nil afterDelay:0.1];

  

    
}


-(void)dataDisplayByWS
{
    check_WS_Method=@"100";
    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];
    
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_id=%@",ConstantPATH,ViewProfileURL,regID]];
    
    
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
	  [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"No internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];
    
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if ([check_WS_Method isEqualToString:@"1000"]) {
        
        
        if(receivedData)
        {
            NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
            NSLog(@"%@",dictTemp);
            aryCountries = [@[] mutableCopy];
            NSArray *arrCountry = [dictTemp objectForKey:@"nationality"];
            for (NSDictionary *dictCountry in arrCountry) {
                Nationality *nationality = [self getNationality:dictCountry];
                [aryCountries addObject:nationality];
            }
            
            NSLog(@"countries = %@",aryCountries);
            [_dp reloadAllComponents];
        }
          [self performSelector:@selector(dataDisplayByWS) withObject:nil afterDelay:.9];
    }

    else if ([check_WS_Method isEqualToString:@"2000"])
    
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        NSString *strDate=[[[dictTemp valueForKey:@"response"]objectAtIndex:0]valueForKey:@"response"];
        NSLog(@"%@",strDate);
        if ([strDate isEqualToString:@"1"]) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have Successfully edit your profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
            [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

        }
        else
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"updation fail Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
            [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

        }
        
        
    }
    else{
    if(receivedData)
    {
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);

        if (dictTemp) {
            NSString *strDate_=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"dob"];
            NSDate *date = [self getDateFromString:strDate_];
            NSString *strDate = [self getStringDateFromDate:date];
            NSString *stremail=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"email"];
             NSString *strGender1=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"gender"];
             NSString *strId=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"id"];
             NSString *strname=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"name"];
             NSString *strnationality=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"nationality"];
             NSString *strnationalityId=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"nationality_id"];
             NSString *strNickName=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"nick_name"];
             NSString *strPhone=[[[dictTemp valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"phone"];
            
            _txt_name.text=strname;
            if ([strGender1 isEqualToString:@"1"]) {
                _lbl_Gender.text=@"Male";
                
            }
            else
            {
                _lbl_Gender.text=@"Female";
            }
            
            _txt_email.text=stremail;
            _lbl_Nationality.text=strnationality;
            _txt_nickName.text=strNickName;
            _txt_phone.text=strPhone;
            _lbl_Dob.text=strDate;
            [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];
        
        }
        
    }
    }
}

-(void)registration_WS_Called
{
    check_WS_Method=@"2000";
    
    if ([_lbl_Gender.text isEqualToString:@"Male"]) {
        strGender=@"1";
    }
    else
    {
        strGender=@"2";
    }
    NSString *regID = [[NSUserDefaults standardUserDefaults] valueForKey:kRegister_ID];

   
    NSString *st=[NSString stringWithFormat:@"user_id=%@&name=%@&nick_name=%@&email=%@&phone=%@&nationality=%@&gender=%@&dob=%@",regID,_txt_name.text,_txt_nickName.text,_txt_email.text,_txt_phone.text,strCountryID,strGender,strDateFormat];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,postEditProfile]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
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



-(IBAction)btn_RegisterClicked:(id)sender
{
    
    [self.view endEditing:YES];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    NSString *rawString = [_txt_name text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    NSString *rawString1 = [_txt_phone text];
    NSString *trimmed1 = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter Valid Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
    else if ([_txt_name.text isEqualToString:@"Name"]||![_txt_name.text length]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter First Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([_txt_email.text isEqualToString:@"Email"]||![_txt_email.text length]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter Email Id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }else if ([emailTest evaluateWithObject:_txt_email.text] == NO) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Enter Valid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([trimmed1 length] == 0) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Enter Valid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
  
    
    else if ([_txt_phone.text isEqualToString:@"Contact Number"]||![_txt_phone.text length]){
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Enter Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([_txt_phone.text length]>13) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Contact Number below 15 digit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    else if ([_lbl_Nationality.text isEqualToString:@"Nationality"]) {
        
        
        
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Select Nationality" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    }
    
    else if ([_lbl_Gender.text isEqualToString:@"Gender"]) {
        
        
        
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Select Gender" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    }
    else if ([_lbl_Dob.text isEqualToString:@"DOB"]) {
        
        
        
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please Select Date of Birth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    }
    else
    {   //loadingView.hidden=NO;
        //  [etActivity startAnimating];
        _gifView.hidden = NO;
        img_animation.hidden = NO;
        [self loadGIF_View];
        [self performSelector:@selector(registration_WS_Called) withObject:nil afterDelay:0.1];
        NSLog(@"ShouldNOTCOME");
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeGIF_View
{
    _gifView.hidden = YES;
    img_animation.hidden = YES;
   
}

-(void)removeWaitView
{
    //loadingView.hidden=YES;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{if (_dp.tag==1) {
    NSString *title =  [[aryCountries objectAtIndex:row] name];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    return attString;
}
    if (_dp.tag==2) {
        NSString *title = [arr objectAtIndex:row];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        return attString;
    }
    return nil;
}

-(Nationality *)getNationality:(NSDictionary *)dictCountry
{
    NSString *countryID = [NSString stringWithFormat:@"%ld",(long)[[dictCountry valueForKey:@"id"] integerValue]];
    NSString *name = [dictCountry valueForKey:@"name"];
    
    Nationality *nationality = [[Nationality alloc] init];
    nationality.countryID = countryID;
    nationality.name = name;
    
    NSLog(@"%@",nationality);
    return nationality;
}

#pragma mark - Picker Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_dp.tag==1) {
        
        
        return aryCountries.count;
    }
    else if (_dp.tag==2)
    {
        return arr.count;
    }
    
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_dp.tag==1) {
        
        return [[aryCountries objectAtIndex:row] name];
    }
    else if (_dp.tag==2)
    {
        [arr objectAtIndex:row];
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_dp.tag==1) {
        
        Nationality *nationality = [aryCountries objectAtIndex:row];
        _lbl_Nationality.text = [nationality name];
        NSLog(@"%@",_lbl_Nationality.text);
        strCountryID=[nationality countryID];
        NSLog(@"%@",strCountryID);
    }
    
    else if (_dp.tag==2) {
        _lbl_Gender.text=[arr objectAtIndex:row];
        strGender = [arr objectAtIndex:row];
    }
    
    // app.Countrystr= [nationality countryID];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}
- (IBAction)doneArea:(id)sender {
    if (_dp.tag==1) {
        NSInteger row;
        row = [_dp selectedRowInComponent:0];
        Nationality *nationality = [aryCountries objectAtIndex:row];
        _lbl_Nationality.text = [nationality name];
        NSLog(@"%@",_lbl_Nationality.text);
        strCountryID=[nationality countryID];
        NSLog(@"%@",strCountryID);
        
        //        [_dp reloadAllComponents];
        //        _area.textColor=[UIColor whiteColor];
        //        _area.text=[[arrayBankArea valueForKey:@"nameeng"] objectAtIndex:row];
        //        _areaString=[[arrayBankArea valueForKey:@"area_id"] objectAtIndex:row];
        //        [_dp selectRow:0 inComponent:0 animated:YES];
        pickerView.hidden=YES;
    } else {
        NSInteger row;
        row = [_dp selectedRowInComponent:0];
        //        [_dp reloadAllComponents];
        //        _chsebk.textColor=[UIColor whiteColor];
        //        _chsebk.text=[[arrayBank valueForKey:@"name"] objectAtIndex:row];
        //        _bankString=[[arrayBank valueForKey:@"bank_id"] objectAtIndex:row];
        //        [_dp selectRow:0 inComponent:0 animated:YES];
        _lbl_Gender.text=[arr objectAtIndex:row];
        strGender = [arr objectAtIndex:row];
        pickerView.hidden=YES;
    }
    
}


-(IBAction)menuLClicked:(id)sender
{
    [self. menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField ==_txt_name)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    else if(textField ==_txt_nickName)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    if(textField ==_txt_phone)
    {
        
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[phnMAX intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else
        return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        [self.navigationController popViewControllerAnimated:NO];
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
- (IBAction)btn_Nationality_Clicked:(id)sender {
    
    [self.view endEditing:YES];
    
    
    //  NSArray *ac=[arrayBankArea valueForKey:@"nameeng"];
    //  if (ac.count) {
    _toolbar1.hidden=YES;
    _datepicker1.hidden=YES;
    pickerView.hidden=NO;
    _dp.hidden=NO;
    _tb.hidden=NO;
    [_dp selectRow:0 inComponent:0 animated:YES];
    _dp.tag=1;
    [_dp reloadAllComponents];
    //  }
    
    
    
}

- (IBAction)btn_Gender_Clicked:(id)sender {
    [self.view endEditing:YES];
    pickerView.hidden=NO;
    _toolbar1.hidden=YES;
    _datepicker1.hidden=YES;
    strGender = [arr objectAtIndex:0];
    NSLog(@"strGender%@",strGender);
    _dp.hidden=NO;
    _tb.hidden=NO;
    _dp.tag=2;
    [_dp reloadAllComponents];
}
- (IBAction)btn_DOB_Clicked:(id)sender {
    [self.view endEditing:YES];
    [_datepicker1 setBackgroundColor:[UIColor whiteColor]];
    [_toolbar1 setTintColor:[UIColor whiteColor]];
    
    strDob = _lbl_Dob.text;
    pickerView.hidden=NO;
    _toolbar1.hidden=NO;
    _datepicker1.hidden=NO;
    _dp.hidden=YES;
    _tb.hidden=YES;
    
}
- (IBAction)btndone2:(id)sender
{
    pickerView.hidden=YES;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    [df setDateFormat:@"dd-MM-yyyy"];
   
    _lbl_Dob.text = [NSString stringWithFormat:@"%@",
                     [df stringFromDate:_datepicker1.date]];
    NSString *strDate = [_lbl_Dob text];
    NSDate *yyyy_MM_dd_Date = [self getDateWithFormat_dd_MM_yyyy_FromString:strDate];
    strDateFormat = [self getStringDateWithFormat_yyyy_MM_dd_FromDate:yyyy_MM_dd_Date];
    NSLog(@"yyyy_MM_dd %@",strDateFormat);
    
       _toolbar1.hidden=YES;
    _datepicker1.hidden=YES;
    _dp.hidden=YES;
    _tb.hidden=YES;
    
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 200, 320,500);
    //    keyBoardView.contentInset = contentInsets;
    //    keyBoardView.scrollIndicatorInsets = contentInsets;
    //    CGRect aRect = self.view.frame;
    
    //    CGPoint scrollPoint = CGPointMake(0, 100);
    //    [keyBoardView setContentOffset:scrollPoint animated:YES];
    
    
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



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 200, 320,500);
    //    keyBoardView.contentInset = contentInsets;
    //    keyBoardView.scrollIndicatorInsets = contentInsets;
    //    CGRect aRect = self.view.frame;
    
        CGPoint scrollPoint = CGPointMake(0, -20);
        [_bigScrollView setContentOffset:scrollPoint animated:YES];
    
    _bigScrollView.scrollEnabled=YES;
    
  //  _bigScrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,700.0,0.0);
    [self.view endEditing:YES];
}



@end
