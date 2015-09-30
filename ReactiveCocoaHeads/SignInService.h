//
//  SignInService.h
//  ReactiveCocoaHeads
//
//  Created by Marlon Andrade on 9/30/15.
//  Copyright © 2015 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SignInCallback)(BOOL);

@interface SignInService : NSObject

- (void)signInWithLogin:(NSString *)login
               password:(NSString *)password
              completed:(SignInCallback)callback;

@end
