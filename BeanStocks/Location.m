//
//  Location.m
//  BeanStocks
//
//  Created by William Lundy on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "Location.h"

@implementation Location

// Parse properties
//@property NSString *locationName;
@dynamic locationName;

//@property NSMutableArray *events;
@dynamic events;

+ (NSString *)parseClassName
{
        return @"Event";
    
}

@end
