//
//  SettingViewController.m
//  dilemma
//
//  Created by TANG YANG on 6/25/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface SettingViewController (){
    AppDelegate *app;
    ViewController *viewController;
}
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    app = [[UIApplication sharedApplication]delegate];
    //exception
    if(self.dataArray == nil){
        GameMode *gameMode = (GameMode*)[app.dataManager createRecordForEntity:@"GameMode"];
        [gameMode setRpg:@YES];
        [app.dataManager saveContext];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDeleteEntity:(id)sender {
    UIAlertView *alertDialog;
    alertDialog = [[UIAlertView alloc]
                   initWithTitle: @"Do you want to delete game progress??"
                   message:@" (╯°□°）╯︵ ┻━┻"
                   delegate: self
                   cancelButtonTitle: @"Cancel"
                   otherButtonTitles: @"Delete data", nil];
	[alertDialog show];
}

- (IBAction)gameModeWriteToEntity:(id)sender {
    NSString *segmentSelectedLabel = [self.gameMode titleForSegmentAtIndex:self.gameMode.selectedSegmentIndex];
    self.labelDisplay.text = [NSString stringWithFormat:@"%@ Mode has been Selected", segmentSelectedLabel];
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"GameMode"];
    for(GameMode *gameMode in self.dataArray){
        if([segmentSelectedLabel isEqualToString:@"RPG"]){
            [gameMode setRpg:@YES];
        }else{
            [gameMode setRpg:@NO];
        }
        [app.dataManager saveContext];
    }
    
}

-(void)deleteEntity{
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    
    for (User *dataArray in self.dataArray){
        [app.dataManager deleteRecord: dataArray];
        [app.dataManager saveContext];
    }
    //connect to parent UI view controller calls notification turnItOff.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"turnItOff" object:nil];
}

#pragma mark -- alert
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
	if ([buttonTitle isEqualToString:@"Delete data"]) {
        [self deleteEntity];
    }
}
@end
