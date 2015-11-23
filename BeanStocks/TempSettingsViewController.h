//
//  FanSettingsViewController.h
//  BeanStocks
//
//  Created by Ehsan on 11/19/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TempSettingDelegate <NSObject>

-(void)tempSettingsWithTemperature:(NSString *)temperature;

@end

@interface TempSettingsViewController : UIViewController

@property (weak,nonatomic) id <TempSettingDelegate> delegate;

@end
