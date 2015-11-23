//
//  LoginViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.signUpButton.layer.cornerRadius = 5;
//    self.logInButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    UIImage *backImage = [UIImage imageNamed: @"BlueGradient"];
    
    [self.backgroundImage setImage:backImage];
    
    [[self.loginButton layer] setBorderWidth:1.0f];
    [[self.loginButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.signUpButton layer] setBorderWidth:1.0f];
    [[self.signUpButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.usernameField layer] setBorderWidth:1.0f];
    [[self.usernameField layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    [[self.passwordField layer] setBorderWidth:1.0f];
    [[self.passwordField layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    


}

- (IBAction)onLogInButtonTapped:(UIButton *)sender {
    
    if ([self.usernameField hasText] && [self.passwordField hasText]) {
        [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry, the information you provided is incorrect!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [controller addAction:action];
                [self presentViewController:controller animated:YES completion:nil];
            }else{
                [self performSegueWithIdentifier:@"CoffeeViewController" sender:self];
            }
        }];
        
    }else{

        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Some of the information is missing. Try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)resignKeyboard:(UIGestureRecognizer *)sender{
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

#pragma mark - Segue
// Going to main ViewController identifier - "ShowMainController"

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//}

@end
