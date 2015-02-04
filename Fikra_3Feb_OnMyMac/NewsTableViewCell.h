//
//  NewsTableViewCell.h
//  Fikra
//
//  Created by Jekil_Hightech on 18/08/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"
@interface NewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_Event;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_year;
@end
