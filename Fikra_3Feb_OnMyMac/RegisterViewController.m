//
//  RegisterViewController.m
//  Fikra
//
//  Created by Hightech_Rahul on 8/19/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "NewsViewController.h"
#import "Constant.h"
#import "Nationality.h"
#import "AppDelegate.h"
#import "SliderTableViewCell.h"
#import "CirActivityIndicatorView.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "MFSideMenu/MFSideMenu.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface RegisterViewController ()
{
    NSMutableArray *aryCountries;
    NSString *strPassword;
    NSString *strContact;
    
    NSInteger pwdMaxLength;
    NSInteger pwdMinLength;
    NSInteger phoneMaxLength;
    NSInteger phoneMinLength;
    
}
@end

@implementation RegisterViewController
CGSize          _originalContentSize;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.container.panMode=MFSideMenuPanModeDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    arr = [NSArray arrayWithObjects:@"Male",@"Female", nil];

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
     _datepicker1.maximumDate = [NSDate date];
    //[_bigScrollView setContentSize:CGSizeMake(342, 700)];

    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
   //loadingView.hidden=YES;
    
       strGender = @"";
     check_WS_Method=@"";
    strDob=@"";
     _txt_ConfirmPassword.secureTextEntry=YES;
     _txt_Password.secureTextEntry=YES;
    _dp.tag=1;
      _gifView.hidden = YES;
    img_animation.hidden = YES;

      [_txt_name setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_nickName setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    [_txt_phone setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    [_txt_Password setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _lbl_Nationality.textColor=[UIColor lightGrayColor];
    _lbl_Gender.textColor=[UIColor lightGrayColor];
    _lbl_Dob.textColor=[UIColor lightGrayColor];
    [_txt_ConfirmPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_email setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
  

    UIFontDescriptor *bfont = [UIFontDescriptor fontDescriptorWithName:@"Corbel-Bold" size:15.0];
  
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
    sliderArray=[[NSMutableArray alloc]init];
 
    [sliderArray addObject:@"About Us"];
    [sliderArray addObject:@"Terms Of Service"];
    [sliderArray addObject:@"Privacy Statement"];
    [sliderArray addObject:@"Contact Us"];
    UIFontDescriptor *afont = [UIFontDescriptor fontDescriptorWithName:@"Corbel" size:18.0];
    [_btn_Register.titleLabel setFont:[UIFont fontWithDescriptor:afont size:17.0]];
    [_btn_Register setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 20 )];
   // [_btn_Register setTitleEdgeInsets:UIEdgeInsetsMake
    _btn_Register.titleLabel.text=@"CREATE  ACCOUNT";
    [_lbl_pleaseWait setFont:[UIFont fontWithDescriptor:afont size:22.0]];
    [_lbl_pleaseWaitSub setFont:[UIFont fontWithDescriptor:bfont size:15.0]];
    _lbl_pleaseWaitSub.numberOfLines=0;
    [_lbl_pleaseWaitSub sizeToFit];
    _lbl_pleaseWaitSub.lineBreakMode=NSLineBreakByWordWrapping;
    
    pickerView.hidden=YES;
    _datepicker1.hidden=YES;

      [self performSelector:@selector(Nationality_WS_Called) withObject:nil afterDelay:0.1];
    _bigScrollView.scrollEnabled=YES;
    
    _bigScrollView.contentInset=UIEdgeInsetsMake(0.0,0.0,80.0,0.0);

    
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
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No Internet Connection.Please come back again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];

    [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];

    
	
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if ([check_WS_Method isEqualToString:@"1000"]) {
        
    
    if(receivedData)
    {
         NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        aryCountries = [@[] mutableCopy];
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

        
        
        
        NSArray *arrCountry = [dictTemp objectForKey:@"nationality"];
        for (NSDictionary *dictCountry in arrCountry) {
            Nationality *nationality = [self getNationality:dictCountry];
            [aryCountries addObject:nationality];
        }
        
        NSLog(@"countries = %@",aryCountries);
         [_dp reloadAllComponents];
    }
    }
    else
    {
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
        NSLog(@"%@",dictTemp);
        
        NSString *status=[[[dictTemp valueForKey:@"register"] objectAtIndex:0]valueForKey:@"status"];
        int reg_id = [[[[dictTemp valueForKey:@"register"] objectAtIndex:0]valueForKey:@"register_id"] integerValue];
         NSString *register_id=[NSString stringWithFormat:@"%d",reg_id];
        if ([status isEqualToString:@"1"]) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:register_id forKey:kRegister_ID];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];

            [self performSelectorOnMainThread:@selector(removeWaitView) withObject:nil waitUntilDone:NO];
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Kindly verify your email account" message:@"Congratulation !!! You are successfully registered.\n Please check your email for verify your account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
            al.tag=1000;
            

            
        }
      else  if ([status isEqualToString:@"0"]) {
          UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Registation not Successfull Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [al show];
          [self performSelectorOnMainThread:@selector(removeWaitView) withObject:nil waitUntilDone:NO];

        }
      else  if ([status isEqualToString:@"2"]) {
          UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"Email Already Exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [al show];
          [self performSelectorOnMainThread:@selector(removeWaitView) withObject:nil waitUntilDone:NO];

      }

        [self performSelectorOnMainThread:@selector(removeGIF_View) withObject:nil waitUntilDone:NO];


    }
    
        //    {
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
          
          [[NSUserDefaults standardUserDefaults] setObject:strCountryID forKey:kNatinalityID];
          
          
          [[NSUserDefaults standardUserDefaults]synchronize];

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_LoginClicked:(id)sender {
    
    NewsViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"news"];
    [self.navigationController pushViewController:verify animated:NO];
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
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"please enter Valid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        }
   else if ([trimmed1 length] == 0) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"please Enter Valid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }

    
        else if ([_txt_phone.text isEqualToString:@"Contact Number"]||![_txt_phone.text length]){
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"please enter Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        }else if ([_txt_Password.text isEqualToString:@"Password"]||![_txt_Password.text length]){
                
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"please Enter password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [al show];
                
            
            }
    
      else if ([_txt_ConfirmPassword.text isEqualToString:@"Confirm Password"]||![_txt_ConfirmPassword.text length]) {
                
                
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Validation" message:@"please enter confirm password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [al show];
                
            }
    
        else if ([_txt_ConfirmPassword.text length]>15) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter password below 15 digit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        }

        else if (![_txt_ConfirmPassword.text isEqualToString:_txt_Password.text]) {
                
                
                _txt_Password.text=nil;
                _txt_ConfirmPassword.text=nil;
                
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Error" message:@"password mismatch.Please check it" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
       app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *st=[NSString stringWithFormat:@"name=%@&nick_name=%@&email=%@&phone=%@&nationality=%@&gender=%@&dob=%@&mbl_password=%@&mbl_gcm_id=%@&mbl_type=i",_txt_name.text,_txt_nickName.text,_txt_email.text,_txt_phone.text,strCountryID,strGender,strDateFormat,_txt_Password.text,app.deviceToke1];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,RegisterURL]];
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
    else if(textField ==_txt_Password)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[strPwd_Max intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }

        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    else if(textField ==_txt_ConfirmPassword)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[strPwd_Max intValue];
        NSInteger length = [currentString length];
        if (length > j) {
            return NO;
        }
        
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }

    
   else if(textField ==_txt_phone)
    {
       
        
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int j=[strPhone_Max intValue];
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(IBAction)btn_BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
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


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
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

    
@end
