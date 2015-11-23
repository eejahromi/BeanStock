//
//  SignUpViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backImage = [UIImage imageNamed: @"BlueGradient"];
    
    [self.backgroundImage setImage:backImage];
    
    [[self.signUpButton layer] setBorderWidth:1.0f];
    [[self.signUpButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    
//    self.signUpButton.layer.cornerRadius = 5;
}

- (IBAction)onSignUpButtonTapped:(UIButton *)sender {
    if ([self.usernameField hasText] && [self.passwordField hasText] && [self.emailField hasText]) {
        PFUser *user = [PFUser user];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        user.email =self.emailField.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry there was an error. Please try again later!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [controller addAction:action];
                [self presentViewController:controller animated:YES completion:nil];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
    }else{
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Some of the information is missing. Try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}


@end
