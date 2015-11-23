//
//  FanSettingsViewController.m
//  BeanStocks
//
//  Created by Ehsan on 11/19/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "TempSettingsViewController.h"

@interface TempSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *temperatureTextField;

@end

@implementation TempSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Settings";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onSetTemperaturePressed:(UIButton *)sender {
    
    [self.temperatureTextField resignFirstResponder];
    int temperatureEntered = [self.temperatureTextField.text intValue];
    if (temperatureEntered < 1 || temperatureEntered > 50) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:@"Number has to be between 0 and 50!"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *temperatureString = [NSString stringWithFormat:@"%d\n",temperatureEntered];
        [self.delegate tempSettingsWithTemperature:temperatureString];
        NSLog(@"NUMBER: %@",temperatureString);

    }
}

@end
