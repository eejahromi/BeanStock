//
//  Event.h
//  BeanStocks
//
//  Created by William Lundy on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <Parse/Parse.h>

@interface Event : PFObject <PFSubclassing>

// Parse stored variables
@property NSString *eventName;
@property NSMutableArray *eventSteps;

+ (NSString *)parseClassName;

@end
