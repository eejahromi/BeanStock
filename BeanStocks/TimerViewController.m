//
//  TimerViewController.m
//  BeanStocks
//
//  Created by Ehsan on 11/17/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timerSetButtonPressed:(UIButton *)sender {
    NSDate *date = [self.datePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *time = [formatter stringFromDate:date];
    [self.delegate timerViewControllerWithTimePicked:time];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
