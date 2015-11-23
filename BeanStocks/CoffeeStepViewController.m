//
//  CoffeeStepViewController.m
//  BeanStocks
//
//  Created by William Lundy on 11/10/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "CoffeeStepViewController.h"
#import "TimerViewController.h"
#import <PTDBean.h>
#import <PTDBeanManager.h>

@interface CoffeeStepViewController () <PTDBeanDelegate,PTDBeanManagerDelegate,TimerVCDelegate>

// Main ImageView
@property (weak, nonatomic) IBOutlet UIImageView *coffeeImage;
@property (weak, nonatomic) IBOutlet UILabel *beanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *handleImageView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIView *coffeeBackground;

@property (strong,nonatomic) NSMutableDictionary *discoveredBeans;
@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) PTDBean *customBean;

// Connected Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *connectedLED;
@property (weak, nonatomic) IBOutlet UIButton *connectedButton;

// Brew Type Properties
@property (weak, nonatomic) IBOutlet UIImageView *brewTypeLED;
@property (weak, nonatomic) IBOutlet UIButton *brewTypeButton;

// Prepped Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *preppedLED;
@property (weak, nonatomic) IBOutlet UIButton *preppedButton;

// Start Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *startLED;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (strong,nonatomic) UIView *fillView;
@property (strong,nonatomic) UIView *progressView;
@property (weak, nonatomic) IBOutlet UISlider *brewSlider;

@property (strong,nonatomic) UILabel *percentage;
@property (assign,nonatomic) int percentCount;

@property (nonatomic) BOOL coffeBrewing;
@property (nonatomic) BOOL coffeeMakerPrepped;
@end

@implementation CoffeeStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBar.translucent = YES;
    
    
    self.navigationItem.hidesBackButton = YES;
    
    self.discoveredBeans = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];
    self.customBean.delegate = self;
    
    self.connectedButton.layer.cornerRadius = 2.0;
    self.preppedButton.layer.cornerRadius = 2.0;
    
    [self.connectedButton setTitle:@"Not Found" forState:UIControlStateNormal];
    
    // UIImage variables
//    UIImage *coffeePic = [UIImage imageNamed: @"Coffee-Cup-23"];
//    UIImage *ligthblueLED = [UIImage imageNamed: @"ligthblue-led-circle-3-th"];
//    UIImage *cyanLED = [UIImage imageNamed: @"cyan-led-circle-3-th"];
//    UIImage *greenLED = [UIImage imageNamed: @"green1-led-circle-3-th"];
//    UIImage *redLED = [UIImage imageNamed: @"red-led-circle-3-th"];
//    UIImage *orangeLED = [UIImage imageNamed: @"orange-led-circle-th"];
    

    
    // Set Main Image
//    [self.coffeeImage setImage:coffeePic];
//    
//    // Set up Connected Button
//    [[self.connectedButton layer] setBorderWidth:1.0f];
//    [[self.connectedButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
//    [self.connectedLED setImage:greenLED];
//    
//    // Set up Brew Type Button
//    [[self.brewTypeButton layer] setBorderWidth:1.0f];
//    [[self.brewTypeButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
//    [self.brewTypeButton setTitle:@"Regular" forState:UIControlStateNormal];
//    [self.brewTypeLED setImage:ligthblueLED];
//    
//    // Set up Prepped Button
//    [[self.preppedButton layer] setBorderWidth:1.0f];
//    [[self.preppedButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
//    [self.preppedButton setTitle:@"Not Prepped" forState:UIControlStateNormal];
//    [self.preppedLED setImage:redLED];
// 
//    // Set up Start Button
//    [[self.startButton layer] setBorderWidth:1.0f];
//    [[self.startButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
//    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
//    [self.startLED setImage:orangeLED];
    
    [self startProgressView];
    
//    self.fillView.hidden = YES;
//    self.progressView.hidden = YES;
    
    self.timerLabel.userInteractionEnabled = YES;
    self.coffeeBackground.layer.cornerRadius = 5.0;
    
    UITapGestureRecognizer *timerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTimer:)];
    timerTap.numberOfTapsRequired = 1;
    [self.timerLabel addGestureRecognizer:timerTap];
    
    
}


-(void)selectTimer:(UIGestureRecognizer *)sender{
    UINavigationController *timerNavVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimerNavController"];
    TimerViewController *timerVC = timerNavVC.viewControllers[0];
    timerVC.delegate = self;
    [self presentViewController:timerNavVC animated:YES completion:nil];
}

#pragma mark - TimerViewController Delegate
-(void)timerViewControllerWithTimePicked:(NSString *)time{
    self.timerLabel.text = time;
}


-(void)startProgressView{
    self.progressView = [[UIView alloc]initWithFrame:CGRectMake(0,0,150,150)];
    self.percentage = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.percentage.center = self.progressView.center;
    self.percentage.textAlignment = NSTextAlignmentCenter;
    self.percentage.textColor = [UIColor whiteColor];
    self.percentage.userInteractionEnabled = YES;
    self.percentage.font = [UIFont fontWithName:@"Arial" size:20];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTapsRequired = 1;
    [self.percentage addGestureRecognizer:tap];
    
    self.fillView = [[UIView alloc]initWithFrame:CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y + 120, 150, 10)];
    self.fillView.backgroundColor = [UIColor colorWithRed:90/255.0 green:72/255.0 blue:60/255.0 alpha:1.0];
    
    self.progressView.center = CGPointMake(self.view.bounds.size.width/2.0,165);
    self.progressView.layer.cornerRadius = self.progressView.bounds.size.width/2.0;
    self.progressView.clipsToBounds = YES;
    self.progressView.layer.borderWidth = 4.0;
    self.progressView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    
    [self.view addSubview:self.progressView];
    [self.progressView addSubview:self.fillView];
    [self.progressView addSubview:self.percentage];
    [self.view bringSubviewToFront:self.handleImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.fillView.frame = CGRectMake(0,150,150,-120);
    } completion:^(BOOL finished) { self.percentage.text = @"Brew Now!"; }];
}

-(void)tapped:(UIGestureRecognizer *)sender{
    [self makeCoffee];
}
- (IBAction)brewStrengthControl:(UISlider *)sender {
    self.fillView.backgroundColor = [UIColor colorWithRed:90/255.0 green:72/255.0 blue:60/255.0 alpha:sender.value/10.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BeanManagerDelegate Callbacks

- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager{
    NSLog(@"SSState: %lu",(unsigned long)manager.state);
    NSLog(@"SSState: %lu",(unsigned long)self.beanManager.state);
    
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        
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
        
        return;
    }
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error{
    NSUUID * key = bean.identifier;
    NSLog(@"BBBState: %lu",(unsigned long)self.customBean.state);
    if (![self.discoveredBeans objectForKey:key]) {
        // New bean
        NSLog(@"BeanManager:didDiscoverBean:error %@", bean);
        [self.discoveredBeans setObject:bean forKey:key];
        
        //[self.discoveredBeans.allValues objectAtIndex:0];
        for (PTDBean *bean in self.discoveredBeans.allValues) {
            [self isCoffeeMachineFound:bean];
        }
    }
    //self.beanLabel.text = @"Bean found! Tap to connect.";
    [self.connectedButton setTitle:@"Connect now!" forState:UIControlStateNormal];
}

-(BOOL)isCoffeeMachineFound:(PTDBean *)bean{
    if ([bean.name isEqualToString:@"CoffeeBean"] || [bean.name isEqualToString:@"Coffee Bean"]) {
        self.customBean = bean;
        return YES;
    }else{
        [self.connectedButton setTitle:@"Not found!" forState:UIControlStateNormal];
        return NO;
    }

}

- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    //self.beanLabel.text = @"Connected!";
    [self.connectedButton setTitle:@"Connected" forState:UIControlStateNormal];
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
        
        return;
    }
}

-(void)bean:(PTDBean *)bean serialDataReceived:(NSData *)data{
    NSString *stringReceived = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([stringReceived isEqualToString:@"Button One Pressed"]) {
        //NSLog(@"Button one pressed");
        self.coffeeMakerPrepped = YES;
        [self.preppedButton setTitle:@"Coffee Prepped!" forState:UIControlStateNormal];
    } else if([stringReceived isEqualToString:@"Button Two Pressed"]){
        NSLog(@"Button Two pressed");
    }else if ([stringReceived isEqualToString:@"Power Toggled"]){
        NSLog(@"Power Toggled");
    }else if ([stringReceived isEqualToString:@"Brew Toggled"]){
        NSLog(@"Brew Toggled");
    }else{
        NSLog(@"Unrecognized: %@",stringReceived);
    }
}

#pragma mark - Connect to Coffee Machine
- (IBAction)connectToMachine:(UIButton *)sender {
    if (self.customBean.state == BeanState_Discovered) {
        self.customBean.delegate = self;
        [self.beanManager connectToBean:self.customBean error:nil];
    }
}

#pragma mark - Make Coffee
- (void)makeCoffee{
    //[self.customBean setLedColor:[UIColor blueColor]];
    [self.customBean sendSerialString:@"TogglePower\n"];
    self.percentage.text = @"";
    
    
    if (!self.coffeBrewing && self.coffeeMakerPrepped) {
        self.fillView.frame = CGRectMake(self.progressView.bounds.origin.x, self.progressView.bounds.origin.y + 140, 150, 10);
        self.coffeBrewing = YES;
        self.coffeeMakerPrepped = NO;
        [UIView animateWithDuration:10.0 animations:^{
            self.fillView.frame = CGRectMake(0,150,150,-120);
        } completion:^(BOOL finished) {
            self.percentage.text = @"READY!";
            [self.preppedButton setTitle:@"Coffee not prepped!" forState:UIControlStateNormal];
            self.coffeBrewing = NO;
        }];
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.beanManager disconnectBean:self.customBean error:nil];
    [self.discoveredBeans removeAllObjects];
    
    NSLog(@"BEAN STATE: %ld",(long)self.customBean.state);
    NSLog(@"COUNT: %lu",self.discoveredBeans.count);
}


@end
