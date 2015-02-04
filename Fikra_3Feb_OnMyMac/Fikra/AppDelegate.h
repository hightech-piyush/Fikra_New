//
//  AppDelegate.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeContainerVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDelegate>
{
     NSMutableData *receivedData;
    BOOL appLaunch;
    NSURLConnection *newsConnection;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSString  *deviceToke1;
@property (strong, nonatomic) NSString *Countrystr;
@property (strong, nonatomic) NSString *registerid;
@property (strong, nonatomic) NSString  *deviceToken;
@property BOOL ScrollEnable;
@property (strong, nonatomic) NSString *responseCheck;
@property (strong, nonatomic) HomeContainerVC *container;


@end
