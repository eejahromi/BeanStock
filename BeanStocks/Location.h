//
//  Location.h
//  BeanStocks
//
//  Created by William Lundy on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <Parse/Parse.h>

@interface Location : PFObject <PFSubclassing>

@property NSString *locationName;
@property NSMutableArray *events;

+ (NSString *)parseClassName;

@end
