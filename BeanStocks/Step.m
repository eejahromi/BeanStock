//
//  Step.m
//  BeanStocks
//
//  Created by William Lundy on 11/8/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "Step.h"

@implementation Step

// Parse Stored Variables
//@property NSString *stepName;
@dynamic stepName;

//@property StepType trigger;
@dynamic trigger;

//@property Bean *stepBean;
@dynamic stepBean;

+ (NSString *)parseClassName {
    return @"Step";
}

@end
