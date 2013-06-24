//
//  User.h
//  dilemma
//
//  Created by TANG YANG on 6/24/13.
//  Copyright (c) 2013 TANG YANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class User;

@interface User : NSManagedObject

@property (nonatomic) NSDecimal *iQ;
@property (nonatomic) NSDecimal *eQ;
@property (nonatomic) NSDecimal *family;
@property (nonatomic) NSDecimal *appearance;
@property (nonatomic) NSDecimal *energy;
@property (nonatomic) NSDecimal *money;
@property (nonatomic) NSDecimal *health;
//-------hidden value for user
@property (nonatomic) NSDecimal *adorable;
@property (nonatomic) BOOL *has_lover;
@property (nonatomic) BOOL *truthful_lover;
@property (nonatomic) BOOL *truthful_friend;

@end
