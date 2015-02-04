//
//  Notification.h
//  Fikra
//
//  Created by Jekil_Hightech on 12/09/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
@property (strong, nonatomic) NSString *strID;
@property (strong, nonatomic) NSString *strTitle;
@property (strong, nonatomic) NSString *strMsg;
@property (strong, nonatomic) NSString *strNotifDate;
@property (strong, nonatomic) NSArray *aryDateNotifs;
@property (strong, nonatomic) NSDictionary *dictNotifs;
@end
