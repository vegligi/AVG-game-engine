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
@property (nonatomic, strong) NSArray *user;
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
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDeleteEntity:(id)sender {
    //fetch the column by index _pk
    //self.user = [app.dataManager fetchRecordsForEntity:@"User" havingValue:@"2" forColumn:@"_pk"];
    //delete all the columns
    self.user = [app.dataManager fetchRecordsForEntity:@"User"];
    
    for (User *user in self.user){
        [app.dataManager deleteRecord: user];
        [app.dataManager saveContext];
    }
    //connect to parent UI view controller calls notification turnItOff.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"turnItOff" object:nil];
}
@end
