//
//  Stage1.m
//  dilemma
//
//  Created by TANG YANG on 7/3/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import "Stage1.h"

@interface Stage1 ()

@end

@implementation Stage1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonBack:(id)sender {
    Stage1 *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
