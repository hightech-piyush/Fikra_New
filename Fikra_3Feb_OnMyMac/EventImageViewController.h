//
//  EventImageViewController.h
//  Fikra
//
//  Created by Hightech_Rahul on 8/30/14.
//  Copyright (c) 2014 HighTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "SubEvent.h"
@interface EventImageViewController : UIViewController<iCarouselDataSource,iCarouselDelegate>
{
    NSMutableArray *img_Array;
    
    IBOutlet UIView *view_Logout;
    IBOutlet UIView *view_Logout_Second;
 
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_Warning;
-(IBAction)btn_Yes_Clicked:(id)sender;
- (IBAction)btn_No_Clicked:(id)sender;

-(IBAction)btn_BackClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;
-(IBAction)menuLClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) NSMutableArray *aryImageURLs;
@property (strong, nonatomic) IBOutlet iCarousel *icarousel;

@property (strong, nonatomic) SubEvent *subEvent;
@end


