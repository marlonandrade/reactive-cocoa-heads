//
//  SignInService.m
//  ReactiveCocoaHeads
//
//  Created by Marlon Andrade on 9/30/15.
//  Copyright © 2015 Marlon Andrade. All rights reserved.
//

#import "SignInService.h"

@implementation SignInService

- (void)signInWithLogin:(NSString *)login
               password:(NSString *)password
              completed:(SignInCallback)callback {
  BOOL success =
    [login isEqualToString:@"login"] &&
    [password isEqualToString:@"password"];
  
  callback(success);
}

@end
