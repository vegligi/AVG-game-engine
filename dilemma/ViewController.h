//
//  ViewController.h
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *buttonContinue;
@property (weak, nonatomic) IBOutlet UIButton *buttonNewGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetting;
- (IBAction)buttonNewGame:(id)sender;
- (IBAction)buttonCountinue:(id)sender;

@end
