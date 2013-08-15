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
    [self loadSegmentedControllersSelection];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting-background.png"]];
    [self gameModeCheckAndWriteToEntityFromSegmentIndex];
    [self fontSetUp];
}

-(void)fontSetUp {
    [self.buttonDelete.titleLabel setFont: [UIFont fontWithName:@"RTWS ShangGothic G0v1" size:20]];
    self.labelDisplay.font = [UIFont fontWithName:@"RTWS ShangGothic G0v1" size:16];
    self.labelTitle.font = [UIFont fontWithName:@"RTWS ShangGothic G0v1" size:22];
    self.labelDescription.font = [UIFont fontWithName:@"RTWS ShangGothic G0v1" size:14];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDeleteEntity:(id)sender {
    UIAlertView *alertDialog;
    alertDialog = [[UIAlertView alloc]
                   initWithTitle: @"为什么要放弃治疗??"
                   message:@" (╯°□°）╯︵ ┻━┻"
                   delegate: self
                   cancelButtonTitle: @"取消"
                   otherButtonTitles: @"删除存档", nil];
	[alertDialog show];
}

- (IBAction)gameModeWriteToEntity:(id)sender {
    [self gameModeCheckAndWriteToEntityFromSegmentIndex];
}

-(void)gameModeCheckAndWriteToEntityFromSegmentIndex{
    NSString *segmentSelectedLabel = [self.gameMode titleForSegmentAtIndex:self.gameMode.selectedSegmentIndex];
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"GameMode"];
    for(GameMode *gameMode in self.dataArray){
        if([segmentSelectedLabel isEqualToString:@"RPG"]){
            [gameMode setRpg:@YES];
            self.labelDisplay.text = [NSString stringWithFormat:@"RPG 模式开启"];
            self.labelDescription.text = [NSString stringWithFormat:@"创建新游戏时,玩家属性可以自定义"];
        }else{
            [gameMode setRpg:@NO];
            self.labelDisplay.text = [NSString stringWithFormat:@"Real life 模式开启"];
            self.labelDescription.text = [NSString stringWithFormat:@"创建新游戏时,玩家属性随机,并附送点数"];
        }
        [app.dataManager saveContext];
    }
}

-(void)loadSegmentedControllersSelection{
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"GameMode"];
    for(GameMode *gameMode in self.dataArray){
        if([[gameMode rpg] boolValue]){
            self.gameMode.selectedSegmentIndex = 0;
        }else{
            self.gameMode.selectedSegmentIndex = 1;
        }
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
	if ([buttonTitle isEqualToString:@"删除存档"]) {
        [self deleteEntity];
    }
}
@end
