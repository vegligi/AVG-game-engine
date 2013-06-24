//
//  ViewController.m
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController
#pragma mark - lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self shouldButtonCountinueAppear];
    [self welcomeAnimation];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - implementation
- (IBAction)buttonNewGame:(id)sender {
}

-(void)shouldButtonCountinueAppear{
    //read database then decide.
    self.buttonContinue.hidden = YES;
}

-(void)welcomeAnimation{
    self.buttonContinue.alpha = 0;
    self.buttonNewGame.alpha = 0;
    self.buttonSetting.alpha = 0;
    [UIView animateWithDuration:1.2 animations:^(void){
        self.buttonContinue.alpha = 100;
        self.buttonNewGame.alpha = 100;
        self.buttonSetting.alpha = 100;
    }];
}
@end
