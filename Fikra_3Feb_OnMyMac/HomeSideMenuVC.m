//
//  HomeSideMenuVC.m
//  Directory
//
//  Created by Zafar Loynmoon on 01/09/14.
//  Copyright (c) 2014 Hightech. All rights reserved.
//

#import "HomeSideMenuVC.h"
#import "AboutViewController.h"
#import "PrivacyStatementViewController.h"
#import "TermsofServiceViewController.h"
#import "ContactUsViewController.h"
#import "SliderTableViewCell.h"
#import "MFSideMenu/MFSideMenu.h"
#import "MyProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "EventHistoryViewController.h"
@interface HomeSideMenuVC ()

@end

@implementation HomeSideMenuVC

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
      sliderArray=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:kReloadSideMenuNotification object:nil];
    
   
}

-(void)reloadTable:(NSNotification *)notification
{
    NSLog(@"reload table");
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    
    [sliderArray removeAllObjects];
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        [sliderArray addObject:@"About us"];
        [sliderArray addObject:@"Terms of service"];
        [sliderArray addObject:@"Privacy statement"];
        [sliderArray addObject:@"Contact us"];
    }
    
    else if ([loginStatus isEqualToString:@"0"])
    
    {
        [sliderArray addObject:@"About us"];
        [sliderArray addObject:@"Terms of service"];
        [sliderArray addObject:@"Privacy statement"];
        [sliderArray addObject:@"Contact us"];
    }
    else
        
    
    {
        [sliderArray addObject:@"My profile"];
        [sliderArray addObject:@"Change password"];
        [sliderArray addObject:@"Event history"];
        [sliderArray addObject:@"About us"];
        [sliderArray addObject:@"Terms of service"];
        [sliderArray addObject:@"Privacy statement"];
        [sliderArray addObject:@"Contact us"];
    }
    [_tlbview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [NSString stringWithFormat:@"Section %d", section];
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Call");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sliderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

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

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] valueForKey:kSTATUS];
    if (loginStatus == (id)[NSNull null] || loginStatus.length == 0 ) {
        
        if (indexPath.row==0) {
            //        AboutViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            //        [self.navigationController pushViewController:verify animated:NO];
            
            AboutViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==1)
        {
            
            TermsofServiceViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"terms"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else if (indexPath.row==2)
        {
            PrivacyStatementViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==3)
        {
            
            ContactUsViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }

    }
    
    else if ([loginStatus isEqualToString:@"0"])
        
    {
        if (indexPath.row==0) {
            //        AboutViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            //        [self.navigationController pushViewController:verify animated:NO];
            
            AboutViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==1)
        {
            
            TermsofServiceViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"terms"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else if (indexPath.row==2)
        {
            PrivacyStatementViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==3)
        {
            
            ContactUsViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }

    }
    else
        
        
    {
        
        if (indexPath.row==0) {
            //        AboutViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            //        [self.navigationController pushViewController:verify animated:NO];
            
            MyProfileViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myprofile"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==1)
        {
            
            ChangePasswordViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"changep"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else if (indexPath.row==2)
        {
            EventHistoryViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"eventhistory"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        if (indexPath.row==3) {
            //        AboutViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            //        [self.navigationController pushViewController:verify animated:NO];
            
            AboutViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==4)
        {
            
            TermsofServiceViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"terms"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else if (indexPath.row==5)
        {
            PrivacyStatementViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
        else if (indexPath.row==6)
        {
            
            ContactUsViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoViewController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
        }
    }
   
  
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    
//        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bbg.png"]];
//        UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0.0,300,50)];
//        tempView.backgroundColor=background;
//        UILabel *tempLabel=[[UILabel alloc]init];
//    tempLabel.textAlignment = NSTextAlignmentCenter;
//        tempLabel.backgroundColor=[UIColor clearColor];
//        // tempLabel.shadowColor = [UIColor blackColor];
//        // tempLabel.shadowOffset = CGSizeMake(0,2);
//        tempLabel.textColor = [UIColor darkGrayColor]; //here you can change the text color of header.
//        [tempLabel setFrame:CGRectMake(0,0,300,35)];
//        tempLabel.font =  [UIFont fontWithName:@"Verdana" size:17];
//        // tempLabel.font = [UIFont boldSystemFontOfSize:25];
//           tempLabel.text = @"KUWAIT TELE DIRECTORY";
//        
//        
//      //  tempLabel.text = [NSString stringWithFormat:@"%@",[[noticearr objectAtIndex:section] objectAtIndex:0]];
//        
//        //    for (int i=0; i<=[headerdata count]; i++) {
//        //        tempLabel.text=[NSString stringWithFormat:@"%@",[headerdata objectAtIndex:i]];
//        //
//        //        NSLog(@"pppp%@",tempLabel.text);
//        //    }
//        //    NSLog(@"kkk%@",tempLabel.text);
//        [tempView addSubview:tempLabel];
//        return tempView;
//        
//        
//   
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    
//      return 44;
//    
//}


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
