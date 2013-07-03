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
@property (nonatomic, strong) NSArray *dataArray;
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
    self.labelTotalPoints.text = @"15";
    self.labelAppearance.text = @"0";
    self.labelIQ.text = @"0";
    self.labelEQ.text = @"0";
    self.labelEnergy.text = @"0";
    self.labelHealth.text = @"0";
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonCreateEntity:(id)sender {
    //clean database
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    for (User *dataarray in self.dataArray){
        [app.dataManager deleteRecord: dataarray];
        [app.dataManager saveContext];
    }
    //create new Entity
    User *dataArray = (User*)[app.dataManager createRecordForEntity:@"User"];
    dataArray.appearance = @([self.labelAppearance.text  intValue]);//aka [NSNumber numberWithInt:100];
    dataArray.iQ = @([self.labelIQ.text  intValue]);
    dataArray.eQ = @([self.labelEQ.text intValue]);
    dataArray.energy = @([self.labelEnergy.text intValue]);
    dataArray.health = @([self.labelHealth.text intValue]);
    //Default
    dataArray.stage_index = @"Stage1";
    [dataArray setTruthful_friend:@YES];
    [dataArray setTruthful_lover:@YES];
    [dataArray setHas_lover:@NO];
    dataArray.money = @(0);
    dataArray.adorable = @(0);
    [app.dataManager saveContext];
    [self navigateToViewControllerFromLastGameSave];
}

-(void)navigateToViewControllerFromLastGameSave{
    self.dataArray = [app.dataManager fetchRecordsForEntity:@"User"];
    for (User *dataarray in self.dataArray){
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:dataarray.stage_index];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - Stepper
-(int)updateLavelTotalPointsWithstepperValue:(int)stepperValue labelValue:(int)labelValue{
    int labelTotalValue = [self.labelTotalPoints.text intValue];
    if(stepperValue > labelValue){ //increment
        if(labelTotalValue > 0){
            self.labelTotalPoints.text = [NSString stringWithFormat:@"%d", labelTotalValue-1];
        }else{
            stepperValue -= 1;
        }
    }else{ //decrement
        if(labelTotalValue < 15){
            self.labelTotalPoints.text = [NSString stringWithFormat:@"%d", labelTotalValue+1];
        }else{
            stepperValue += 1;
        }
    }
    return stepperValue;
}

- (IBAction)buttonToModefyAppearance:(id)sender {
    int stepperValue = self.stepperAppearance.value;
    int labelValue = [self.labelAppearance.text intValue];
    stepperValue = [self updateLavelTotalPointsWithstepperValue:stepperValue labelValue:labelValue];
    self.labelAppearance.text = [NSString stringWithFormat:@"%d", stepperValue];
    self.stepperAppearance.value = stepperValue;
}

- (IBAction)buttonToModefyIQ:(id)sender {
    int stepperValue = self.stepperIQ.value;
    int labelValue = [self.labelIQ.text intValue];
    stepperValue = [self updateLavelTotalPointsWithstepperValue:stepperValue labelValue:labelValue];
    self.labelIQ.text = [NSString stringWithFormat:@"%d", stepperValue];
    self.stepperIQ.value = stepperValue;
}

- (IBAction)buttonToModefyEQ:(id)sender {
    int stepperValue = self.stepperEQ.value;
    int labelValue = [self.labelEQ.text intValue];
    stepperValue = [self updateLavelTotalPointsWithstepperValue:stepperValue labelValue:labelValue];
    self.labelEQ.text = [NSString stringWithFormat:@"%d", stepperValue];
    self.stepperEQ.value = stepperValue;
}

- (IBAction)buttonToModefyEnergy:(id)sender {
    int stepperValue = self.stepperEnergy.value;
    int labelValue = [self.labelEnergy.text intValue];
    stepperValue = [self updateLavelTotalPointsWithstepperValue:stepperValue labelValue:labelValue];
    self.labelEnergy.text = [NSString stringWithFormat:@"%d", stepperValue];
    self.stepperEnergy.value = stepperValue;
}

- (IBAction)buttonToModefyHealth:(id)sender {
    int stepperValue = self.stepperHealth.value;
    int labelValue = [self.labelHealth.text intValue];
    stepperValue = [self updateLavelTotalPointsWithstepperValue:stepperValue labelValue:labelValue];
    self.labelHealth.text = [NSString stringWithFormat:@"%d", stepperValue];
    self.stepperHealth.value = stepperValue;
}
@end