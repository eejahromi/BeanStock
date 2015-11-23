//
//  Event.m
//  BeanStocks
//
//  Created by William Lundy on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "Event.h"

@implementation Event

// Parse stored variables
//@property NSString *eventName;
@dynamic eventName;

//@property NSMutableArray *eventSteps;
@dynamic eventSteps;

+ (NSString *)parseClassName
{
    return @"Event";
}
@end
