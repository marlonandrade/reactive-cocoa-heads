//
//  ViewController.h
//  ReactiveCocoaHeads
//
//  Created by Marlon Andrade on 9/30/15.
//  Copyright © 2015 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

