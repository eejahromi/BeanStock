//
//  AddBeanViewController.m
//  BeanStocks
//
//  Created by Ehsan on 11/3/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//


#import <PTDBeanManager.h>
#import "AddBeanViewController.h"
#import "BeanTableViewCell.h"
#import "BeanDetailViewController.h"
#import "PTDBean.h"
#import "BeanManager.h"
#import "AppDelegate.h"

@interface AddBeanViewController () <PTDBeanManagerDelegate, PTDBeanDelegate, UITableViewDataSource, UITableViewDelegate>

// all the beans returned from a scan
@property (nonatomic, strong) NSMutableDictionary *beans;
// how we access the beans
@property (nonatomic, strong) PTDBeanManager *beanManager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddBeanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the beans Dictionary
    self.beans = [NSMutableDictionary dictionary];
    // instantiating the bean starts a scan. make sure you have you delegates implemented
    // to receive bean info
    
    self.beanManager = [[PTDBeanManager alloc] initWithDelegate:self];
    //self.beanManager = [[BeanManager sharedInstance] initWithDelegate:self];
    
//    AppDelegate *application = [[UIApplication sharedApplication] delegate];
//    self.beanManager = application.beanManager;
//    self.beanManager.delegate = self;
//    [self.tableView reloadData];
//    self.beanManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // the next vc grabs the delegate to receive callbacks
    // when the view appears , we want to grab them back.
    self.beanManager.delegate = self;
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

static NSString *CellIdentifier = @"BeanListCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTDBean * bean = [self.beans.allValues objectAtIndex:indexPath.row];
    
    BeanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.bean = bean;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beans.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Beans";
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    PTDBean * bean = [self.beans.allValues objectAtIndex:indexPath.row];
    BeanDetailViewController *destController = segue.destinationViewController;
    destController.bean = bean;
    destController.beanManager = self.beanManager;
}

#pragma mark - Private functions

- (PTDBean*)beanForRow:(NSInteger)row{
    return [self.beans.allValues objectAtIndex:row];
}

#pragma mark - BeanManagerDelegate Callbacks

- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager{
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        
        // TODO: - Implement AlertViewController
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Bluetooth"
                                              message:@"Turn on Bluetooth to continue"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Turn on bluetooth to continue" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
        return;
    }
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error{
    NSUUID * key = bean.identifier;
    if (![self.beans objectForKey:key]) {
        // New bean
        NSLog(@"BeanManager:didDiscoverBean:error %@", bean);
        [self.beans setObject:bean forKey:key];
    }
    [self.tableView reloadData];
}

- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
        return;
    }
    
    [self.beanManager stopScanningForBeans_error:&error];
    if (error) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
        return;
    }
    [self.tableView reloadData];
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDisconnectBean:(PTDBean*)bean error:(NSError*)error{
    [self.tableView reloadData];
}

#pragma mark Actions

- (IBAction)handleRefresh:(id)sender {
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        NSError *error;
        [self.beanManager startScanningForBeans_error:&error];
        if (error) {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Error"
                                                  message:[error localizedDescription]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           NSLog(@"OK action");
                                       }];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [alert show];
        }
    }
    [(UIRefreshControl *)sender endRefreshing];
}



@end
