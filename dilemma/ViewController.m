//
//  ViewController.m
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "ViewController.h"
//Connect to DataManager
#import "AppDelegate.h"
@interface ViewController (){
    //alloc DataManager (not exactly)
    AppDelegate *app;
}
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController
#pragma mark - lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //since child view controller calls turnItOff, notification center calls function "turnButtonCountinuesOff"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnButtonCountinuesOff) name:@"turnItOff" object:nil];
    
    //init DataManager (not exaclty)
    app = [[UIApplication sharedApplication]delegate];
    [self shouldButtonCountinueAppear];
    [self welcomeAnimation];
    [self updateGameMode];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Implementation
- (IBAction)buttonNewGame:(id)sender {
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"GameMode"];
    for (GameMode *dataarray in self.dataArray){
        if(![[dataarray rpg] boolValue]){ //real Life Mode
            [self createRandomUserData];
            //navigate through Segue
            //[self performSegueWithIdentifier:@"segueToStage1" sender:self];
            ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Stage1"];
            [self presentViewController:vc animated:YES completion:nil];
       }
    }
}

- (IBAction)buttonCountinue:(id)sender {
    [self navigateToViewControllerFromLastGameSave];
}

-(void)navigateToViewControllerFromLastGameSave{
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    for (User *dataarray in self.dataArray){
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:dataarray.stage_index];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)createRandomUserData{
    //clean database
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    for (User *dataarray in self.dataArray){
        [app.dataManager deleteRecord: dataarray];
        [app.dataManager saveContext];
    }
    //create new Entity
    User *dataArray = (User*)[app.dataManager createRecordForEntity:@"User"];
    int appearance = arc4random() % 10;
    int iq = arc4random() % 10;
    int eq = arc4random() % 10;
    int energy = arc4random() % 10;
    int sum = energy + eq + iq + appearance;
    appearance = appearance*14/sum;
    iq = iq*14/sum;
    eq = eq*14/sum;
    energy = energy*14/sum;
    int health = 16 - appearance - iq - eq - energy;
    //generate
    dataArray.appearance = @(appearance);
    dataArray.iQ = @(iq);
    dataArray.eQ = @(eq);
    dataArray.energy = @(energy);
    dataArray.health = @(health);
    //Default
    dataArray.stage_index = @"Stage1";
    [dataArray setTruthful_friend:@YES];
    [dataArray setTruthful_lover:@YES];
    [dataArray setHas_lover:@NO];
    dataArray.money = @(0);
    dataArray.adorable = @(0);
    [app.dataManager saveContext];
}

-(void)turnButtonCountinuesOff{
    self.buttonContinue.hidden = YES;
}

-(void)shouldButtonCountinueAppear{
    //Datamanager
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    if([self.dataArray count] <= 0){
        self.buttonContinue.hidden = YES;
    }else{
        self.buttonContinue.hidden = NO;
    }
}

-(void)updateGameMode{
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"GameMode"];
    if([self.dataArray count] == 0){
        GameMode *gameMode = (GameMode*)[app.dataManager createRecordForEntity:@"GameMode"];
        [gameMode setRpg:@YES];
        [app.dataManager saveContext];
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
