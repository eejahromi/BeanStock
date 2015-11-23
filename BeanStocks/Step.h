//
//  Step.h
//  BeanStocks
//
//  Created by William Lundy on 11/8/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <Parse/Parse.h>
#import "Bean.h"

typedef NS_ENUM(NSInteger, StepType) {
    /**
     *  Used for initialization and unknown error states
     */
    StepType_Unknown = 0,
    /**
     *  Step is a manual step
     */
    StepType_Manual,
    /**
     *  Step is a time based step
     */
    StepType_Timed,
    /**
     *  Step is Distance triggered
     */
    StepType_Distance,
    
};

@interface Step : PFObject <PFSubclassing>

// Parse Stored Variables
@property NSString *stepName;
@property StepType trigger;
@property Bean *stepBean;

// TODO: timer and progress bar

+ (NSString *)parseClassName;

@end
