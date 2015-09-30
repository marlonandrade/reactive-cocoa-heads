//
//  ViewController.m
//  ReactiveCocoaHeads
//
//  Created by Marlon Andrade on 9/30/15.
//  Copyright © 2015 Marlon Andrade. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa/ReactiveCocoa.h"

#import "SignInService.h"

@interface ViewController ()

@end

@implementation ViewController

// REGRAS
// login -> valido com 3 ou mais caracteres
// password -> valido com 3 ou mais caracteres
// botao -> valido se login e password valido

- (void)viewDidLoad {
  [super viewDidLoad];
  
  RACSignal *loginValidSignal =
    [[[self.loginTextField.rac_textSignal
      map:^NSNumber*(NSString *text) {
        return @(text.length);
      }]
      map:^NSNumber*(NSNumber *size) {
        return @(size.integerValue >= 3);
      }]
      distinctUntilChanged];
  
  RACSignal *passwordValidSignal =
    [[[self.passwordTextField.rac_textSignal
      map:^NSNumber*(NSString *text) {
        return @(text.length);
      }]
      map:^NSNumber*(NSNumber *size) {
        return @(size.integerValue >= 3);
      }]
      distinctUntilChanged];
  
  typedef UIColor* (^ValidLabelBlock)(NSNumber*);
  ValidLabelBlock validLabel = ^UIColor*(NSNumber *isValid) {
    return isValid.boolValue ?
      [UIColor blackColor] :
      [UIColor redColor];
  };
  
  typedef UIColor* (^ValidTextFieldBlock)(NSNumber*);
  ValidTextFieldBlock validTextField = ^UIColor*(NSNumber *isValid) {
    return isValid.boolValue ?
      [UIColor clearColor] :
      [UIColor redColor];
  };
  
  RAC(self.loginLabel, textColor) = [loginValidSignal map:validLabel];
  RAC(self.loginTextField, backgroundColor) = [loginValidSignal map:validTextField];
  
  RAC(self.passwordLabel, textColor) = [passwordValidSignal map:validLabel];
  RAC(self.passwordTextField, backgroundColor) = [passwordValidSignal map:validTextField];
  
  RACSignal *formValidSignal =
    [RACSignal combineLatest:@[ loginValidSignal, passwordValidSignal ]
                      reduce:^NSNumber*(NSNumber *loginValid, NSNumber *passwordValid) {
                        return @(loginValid.boolValue && passwordValid.boolValue);
                      }];
  
  RAC(self.submitButton, enabled) = formValidSignal;
  
  [[[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside]
   flattenMap:^id(id value) {
     return [self _signInSignal];
   }]
   subscribeNext:^(NSNumber *signInSuccess) {
     if (signInSuccess.boolValue) {
       [self performSegueWithIdentifier:@"SignInSegue"
                                 sender:self];
     }
   }];
}

- (RACSignal *)_signInSignal {
  SignInService *signInService = [[SignInService alloc] init];
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [signInService signInWithLogin:self.loginTextField.text
                          password:self.passwordTextField.text
                         completed:^(BOOL success) {
                           [subscriber sendNext:@(success)];
                           [subscriber sendCompleted];
                         }];
    
    return nil;
  }];
}

@end
