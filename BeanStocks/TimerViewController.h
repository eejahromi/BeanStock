//
//  TimerViewController.h
//  BeanStocks
//
//  Created by Ehsan on 11/17/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimerVCDelegate <NSObject>

-(void)timerViewControllerWithTimePicked:(NSString *)time;

@end

@interface TimerViewController : UIViewController

@property (weak,nonatomic) id <TimerVCDelegate> delegate;
@end
