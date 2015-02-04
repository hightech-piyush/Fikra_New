//
//  HomeSideMenuVC.h
//  Directory
//
//  Created by Zafar Loynmoon on 01/09/14.
//  Copyright (c) 2014 Hightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
@interface HomeSideMenuVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *listarr;
     NSMutableArray *sliderArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tlbview;

@end
