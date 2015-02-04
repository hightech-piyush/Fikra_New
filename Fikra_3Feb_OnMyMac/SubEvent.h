//
//  SubEvent.h
//  Fikra
//
//  Created by Jekil_Hightech on 31/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubEvent : NSObject
@property (strong, nonatomic) NSString *strEventDate;
@property (strong, nonatomic) NSString *strCurDate;
@property (strong, nonatomic) NSString *strID;
@property (strong, nonatomic) NSString *strLocation;
@property (strong, nonatomic) NSString *strLocationImageLink;
@property (strong, nonatomic) NSString *strSubEventName;
@property (strong, nonatomic) NSString *strMainEventName;
@property (strong, nonatomic) NSString *strMainEventID;
@property (strong, nonatomic) NSString *strSubEventCheck;
@property (strong, nonatomic) NSArray  *arySubEventItems;
@property (strong, nonatomic) NSString *strLocImage;

@property (strong, nonatomic) NSString *strDesc;
@property (strong, nonatomic) NSString *strFree;
@property (strong, nonatomic) NSString *strPrice;
@property (strong, nonatomic) NSString *strSubTitle;

@property (strong, nonatomic) NSString *strMP3;
@property (strong, nonatomic) NSString *strLink;


@end
