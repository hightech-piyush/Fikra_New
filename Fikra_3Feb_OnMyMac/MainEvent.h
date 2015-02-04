//
//  MainEvent.h
//  Fikra
//
//  Created by Jekil_Hightech on 30/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainEvent : NSObject

@property (strong, nonatomic) NSString *strID;
@property (strong, nonatomic) NSString *strName;
@property (strong, nonatomic) NSString *strImageURL;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSArray *arySubEvents;

@end
