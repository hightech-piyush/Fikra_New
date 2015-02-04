//
//  AppDelegate.m
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import "AppDelegate.h"

#import "NewsViewController.h"
#import "HomeSideMenuVC.h"
#import "Constant.h"
#import "MFSideMenuContainerViewController.h"
#import "EventsViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"


@implementation AppDelegate
@synthesize navController,deviceToke1,ScrollEnable,Countrystr,responseCheck,registerid,container,deviceToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"AD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self createEditableCopyOfDatabaseIfNeeded];

   
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
//
    
    
//    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//    {
//        // iOS 8 Notifications
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [application registerForRemoteNotifications];
//    }
//    else
//    {
//        // iOS < 8 Notifications
//        [application registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
//    }
 
    
   // self.deviceToke1 = @"328555f0e142d51a39f9a9664e8aada3ff54d58abe918201f5742301fc786ea8";
     // [self install_Register_WS_Called];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    container = (HomeContainerVC *)_window.rootViewController;
    navController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navController];

    return YES;
}



- (void)createEditableCopyOfDatabaseIfNeeded
{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"FikraDB.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    // The writable database does not exist, so copy the default to the appropriate location.
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"FikraDB.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToke
//{
//    NSCharacterSet *angleBrackets = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
//    deviceToken = [[deviceToke description] stringByTrimmingCharactersInSet:angleBrackets];
//    
//    deviceToken = [ deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"Trimm=%@", deviceToken);
//    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:deviceToken delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alt show];
//    
//     [self install_Register_WS_Called];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"TOKEN"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSCharacterSet *angleBrackets = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString *deviceToke = [[deviceToken description] stringByTrimmingCharactersInSet:angleBrackets];
    NSLog(@"Device=%@",deviceToke);
    
    deviceToke1 = [deviceToke stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Trimm=%@",deviceToke1);
    
[self install_Register_WS_Called];

    
    
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo {
    
    NSDictionary *dictNotif = [userInfo valueForKey:@"aps"];
    
    NSString *tag = [dictNotif valueForKey:@"tag"];
    
    NSString *strAlert = [dictNotif valueForKey:@"alert"];
    ShowAlert(strAlert, @"");
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:@"hasPush"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    if ([tag isEqualToString:@"for all"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        container = (HomeContainerVC *)self.window.rootViewController;
        NotificationViewController *notifVC = [storyboard instantiateViewControllerWithIdentifier:@"noti"];
        self.navController = [[UINavigationController alloc] initWithRootViewController:notifVC];
        //self.navController = [storyboard instantiateViewControllerWithIdentifier:@"noti"];
        //navController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
        
        [container setLeftMenuViewController:leftSideMenuViewController];
        [container setCenterViewController:self.navController];
    }else if([tag isEqualToString:@"for event"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        container = (HomeContainerVC *)self.window.rootViewController;
        EventsViewController *eventVC = [storyboard instantiateViewControllerWithIdentifier:@"event"];
        self.navController = [[UINavigationController alloc] initWithRootViewController:eventVC];

        //self.navController = [storyboard instantiateViewControllerWithIdentifier:@"event"];
        //navController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
        
        [container setLeftMenuViewController:leftSideMenuViewController];
        [container setCenterViewController:self.navController];
    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        container = (HomeContainerVC *)_window.rootViewController;
        
        NewsViewController *newsVC = [storyboard instantiateViewControllerWithIdentifier:@"news"];
        self.navController = [[UINavigationController alloc] initWithRootViewController:newsVC];

        
        //navController = [storyboard instantiateViewControllerWithIdentifier:@"news"];
    
        //NewsViewController *newsVC = [storyboard instantiateViewControllerWithIdentifier:@"news"];

        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"homesidemenu"];
        //  UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
        
        [container setLeftMenuViewController:leftSideMenuViewController];
        // [container setRightMenuViewController:rightSideMenuViewController];
        [container setCenterViewController:navController];
    }
    
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)install_Register_WS_Called
{
    
    
    
    NSString *st=[NSString stringWithFormat:@"device_id=%@&type=i",deviceToke1];
    NSLog(@"punit=%@",st);
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConstantPATH,InstallRegisiterURL]];
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    newsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if( newsConnection )
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
    if (connection == newsConnection){
    if (receivedData)
    {
        NSString *responseString=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"response=%@",responseString);
        
        
    }
    }
}

@end
