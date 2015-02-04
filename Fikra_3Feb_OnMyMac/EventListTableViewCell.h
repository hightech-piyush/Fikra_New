//
//  EventListTableViewCell.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/19/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"
@interface EventListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Description;
@end
