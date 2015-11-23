//
//  Bean.m
//  BeanStocks
//
//  Created by William Lundy on 11/7/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "Bean.h"
#import <Parse/PFObject+Subclass.h>

@implementation Bean

// Parse Variables
//@property NSUUID *beanUUID;
//@property NSString *beanName;
//@property NSUInteger *beanPairingPin;

@dynamic beanUUID;
@dynamic beanName;
@dynamic beanPairingPin;


// Non Parse Variables
//@property BeanState *customBeanState;
//@property PTDBean *bean;
@synthesize customBeanState = _customBeanState;
@synthesize beanPTD = _beanPTD;


// Setters and Getters
- (void)setBeanPTD:(PTDBean *)beanPTD
{
    _beanPTD = beanPTD;
}

- (PTDBean *)beanPTD
{
    return _beanPTD;
}

- (void)setCustomBeanState:(BeanState *)customBeanState
{
    _customBeanState = customBeanState;
}

-(BeanState *)customBeanState
{
    return _customBeanState;
}


+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Bean";
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.beanPTD = nil;
        self.customBeanState = BeanState_Unknown;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@", self.beanName, self.beanUUID, self.beanPTD];
    
}
@end
