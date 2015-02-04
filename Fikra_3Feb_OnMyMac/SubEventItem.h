//
//  SubEventItem.h
//  Fikra
//
//  Created by Jekil_Hightech on 31/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubEventItem : NSObject
@property (strong, nonatomic) NSString *strID;
@property (strong, nonatomic) NSString *strName;
@property (strong, nonatomic) NSString *strSubEventID;
@property (strong, nonatomic) NSString *strSubEventName;
@property (strong, nonatomic) NSString *strMainEventName;
@property (strong, nonatomic) NSString *strMainEventID;
@property (strong, nonatomic) NSString *strChecked;
@end
