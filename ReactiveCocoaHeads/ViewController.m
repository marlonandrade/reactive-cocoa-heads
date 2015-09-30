//
//  ViewController.m
//  ReactiveCocoaHeads
//
//  Created by Marlon Andrade on 9/30/15.
//  Copyright © 2015 Marlon Andrade. All rights reserved.
//

#import "ViewController.h"

#import "SignInService.h"

@interface ViewController ()

@end

@implementation ViewController

// REGRAS
// login -> valido com 3 ou mais caracteres
// password -> valido com 3 ou mais caracteres
// botao -> valido se login e password valido

- (BOOL)_isLoginValid {
  return self.loginTextField.text.length >= 3;
}

- (BOOL)_isPasswordValid {
  return self.passwordTextField.text.length >= 3;
}

- (void)_setupLoginValid {
  UIColor *backgroundColor = [UIColor clearColor];
  UIColor *textColor = [UIColor blackColor];
  
  if (![self _isLoginValid]) {
    backgroundColor = [UIColor redColor];
    textColor = [UIColor redColor];
  }
  
  self.loginLabel.textColor = textColor;
  self.loginTextField.backgroundColor = backgroundColor;
}

- (void)_setupPasswordValid {
  UIColor *backgroundColor = [UIColor clearColor];
  UIColor *textColor = [UIColor blackColor];
  
  if (![self _isPasswordValid]) {
    backgroundColor = [UIColor redColor];
    textColor = [UIColor redColor];
  }
  
  self.passwordLabel.textColor = textColor;
  self.passwordTextField.backgroundColor = backgroundColor;
}

- (void)_setupSubmitValid {
  self.submitButton.enabled = [self _isLoginValid] && [self _isPasswordValid];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self _setupLoginValid];
  [self _setupPasswordValid];
  [self _setupSubmitValid];
}

- (IBAction)loginEditing:(id)sender {
  NSLog(@"%@", self.loginTextField.text);
  [self _setupLoginValid];
  [self _setupSubmitValid];
}

- (IBAction)passwordEditing:(id)sender {
  NSLog(@"%@", self.passwordTextField.text);
  [self _setupPasswordValid];
  [self _setupSubmitValid];
}

- (IBAction)submitTouched:(id)sender {
  NSLog(@"%@ - %@",
        self.loginTextField.text,
        self.passwordTextField.text);
  
  SignInService *signInService = [[SignInService alloc] init];
  [signInService signInWithLogin:self.loginTextField.text
                        password:self.passwordTextField.text
                       completed:^(BOOL success) {
                         if (success) {
                           [self performSegueWithIdentifier:@"SignInSegue"
                                                     sender:self];
                         }
                       }];
}

@end
