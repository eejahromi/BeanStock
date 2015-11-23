//
//  BeanManager.h
//  BeanStocks
//
//  Created by Ehsan on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PTDBeanManager.h>

@interface BeanManager : NSObject

+(PTDBeanManager *)sharedInstance;

@end
