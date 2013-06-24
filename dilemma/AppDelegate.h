//
//  AppDelegate.h
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#define TFHA_MOMDFILENAME @"Model"
#define TFHA_DBFILENAME @"Model"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//DataManager
@property (strong, nonatomic) DataManager *dataManager;
- (NSURL *)applicationDocumentsDirectory;
- (NSString *)applicationDocumentsDirectoryAsString;
- (NSURL *)applicationCachesDirectory;
- (NSString *)applicationCachesDirectoryAsString;
@end
