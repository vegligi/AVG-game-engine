//
//  ViewController.m
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "User.h"
@interface ViewController (){
    AppDelegate *app;
}
@property (nonatomic, strong) NSArray *user;
@end

@implementation ViewController
#pragma mark - lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    app = [[UIApplication sharedApplication]delegate];
    [self shouldButtonCountinueAppear];
    [self welcomeAnimation];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Implementation
- (IBAction)buttonNewGame:(id)sender {
}

-(void)shouldButtonCountinueAppear{
    //Datamanager
    self.user = [app.dataManager fetchRecordsForEntity:@"User"];
    if([self.user count] <= 0){
        self.buttonContinue.hidden = YES;
    }else{
        self.buttonSetting.hidden = NO;
    }
    
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

#pragma mark - Button Functions
@end
