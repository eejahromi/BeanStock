//
//  AppDelegate.h
//  BeanStocks
//
//  Created by Ehsan on 11/3/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PTDBeanManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) PTDBeanManager *beanManager;

@end

