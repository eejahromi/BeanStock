//
//  BeanManager.m
//  BeanStocks
//
//  Created by Ehsan on 11/9/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "BeanManager.h"

@implementation BeanManager

/*
 *  BeanManager sharedInstance
 *  creates a singleton instance of the PTDBeanManager class
 *
 *  How to use:
 *  -import the header into the file you want to use this manager (i.e ViewController.m)
 *  #import "BeanManager.h"
 *
 *  -then create an instance of the manager with a PTDBeanManager pointer and call sharedInstance
 *  PTDBeanManager *manager = [BeanManager sharedInstance];
 *
 *  -then call any properties or methods in that was provided in PTDBeanManager
 *  NSLog(@"%lu",(unsigned long)manager.state);
 *
 */


+(PTDBeanManager *)sharedInstance{
    static PTDBeanManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        sharedInstance = [[PTDBeanManager alloc]init];
    });
    
    return sharedInstance;
}

@end
