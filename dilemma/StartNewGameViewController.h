//
//  StartNewGameViewController.h
//  dilemma
//
//  Created by TANG YANG on 6/25/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "ViewController.h"

@interface StartNewGameViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTotalPoints;
@property (weak, nonatomic) IBOutlet UILabel *labelAppearance;
@property (weak, nonatomic) IBOutlet UILabel *labelIQ;
@property (weak, nonatomic) IBOutlet UILabel *labelEQ;
@property (weak, nonatomic) IBOutlet UILabel *labelEnergy;
@property (weak, nonatomic) IBOutlet UILabel *labelHealth;
@property (weak, nonatomic) IBOutlet UIStepper *stepperAppearance;
@property (weak, nonatomic) IBOutlet UIStepper *stepperIQ;
@property (weak, nonatomic) IBOutlet UIStepper *stepperEQ;
@property (weak, nonatomic) IBOutlet UIStepper *stepperEnergy;
@property (weak, nonatomic) IBOutlet UIStepper *stepperHealth;

- (IBAction)buttonCreateEntity:(id)sender;
- (IBAction)buttonToModefyAppearance:(id)sender;
- (IBAction)buttonToModefyIQ:(id)sender;
- (IBAction)buttonToModefyEQ:(id)sender;
- (IBAction)buttonToModefyEnergy:(id)sender;
- (IBAction)buttonToModefyHealth:(id)sender;
@end
