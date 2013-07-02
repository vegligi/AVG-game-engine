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

@property (nonatomic) NSNumber *iQ;
@property (nonatomic) NSNumber *eQ;
@property (nonatomic) NSNumber *family;
@property (nonatomic) NSNumber *appearance;
@property (nonatomic) NSNumber *energy;
@property (nonatomic) NSNumber *money;
@property (nonatomic) NSNumber *health;
//-------hidden value for user
@property (nonatomic) NSNumber *adorable;
@property (nonatomic) NSNumber *has_lover;          //bool
@property (nonatomic) NSNumber *truthful_lover;     //bool
@property (nonatomic) NSNumber *truthful_friend;    //bool

@end
