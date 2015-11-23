//
//  Bean.h
//  BeanStocks
//
//  Created by William Lundy on 11/7/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <Parse/Parse.h>
#import <PTDBean.h>

@interface Bean : PFObject <PFSubclassing>

// Parse Stored Variables
@property NSUUID *beanUUID;
@property NSString *beanName;
@property NSUInteger *beanPairingPin;

// Variables not stored in Parse
@property BeanState *customBeanState;
@property PTDBean *beanPTD;

+ (NSString *)parseClassName;

@end
