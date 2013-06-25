//
//  StartNewGameViewController.m
//  dilemma
//
//  Created by TANG YANG on 6/25/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "StartNewGameViewController.h"
#import "AppDelegate.h"
@interface StartNewGameViewController (){
    AppDelegate *app;
}
@property (nonatomic, strong) NSArray *user;
@end

@implementation StartNewGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonCreateEntity:(id)sender {
    User *user = (User*)[app.dataManager createRecordForEntity:@"User"];
    user.iQ = @(123);//aka [NSNumber numberWithInt:100];
    [app.dataManager saveContext];
}
@end