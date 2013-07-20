//
//  SettingViewController.h
//  dilemma
//
//  Created by TANG YANG on 6/25/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "ViewController.h"

@interface SettingViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDisplay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;


- (IBAction)buttonDeleteEntity:(id)sender;
- (IBAction)gameModeWriteToEntity:(id)sender;
@end
