//
//  BeanDetailViewController.h
//  BeanStocks
//
//  Created by William Lundy on 11/5/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PTDBeanManager.h>

@interface BeanDetailViewController : UIViewController
@property (nonatomic, strong) PTDBean *bean;
@property (nonatomic, strong) PTDBeanManager *beanManager;
@end
