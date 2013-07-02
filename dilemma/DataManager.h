//
//  DataManager.h
//
//  Created by TANG YANG on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "GameMode.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSURL *modelURL;
@property (strong, nonatomic) NSURL *storeURL;



- (id)initWithModel:(NSURL *)modelURL store:(NSURL *)storeURL;
- (void)saveContext;

- (NSManagedObject *)createRecordForEntity:(NSString *)entityName;

- (NSFetchedResultsController *)fetchedResultsControllerForEntity:(NSString *)entityName orderBy:(NSString *)columnName;

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName orderBy:(NSString *)column;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column orderBy:(NSString *)orderColumn;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName
                       havingValue:(id)value
                         forColumn:(NSString *)column
                           orderBy:(NSString *)orderColumn
                         ascending:(BOOL)ascending;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValuesForKeys:(NSDictionary *)valuesForKeys;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValueIn:(NSArray *)values forColumn:(NSString *)column;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValueIn:(NSArray *)values forColumn:(NSString *)column orderBy:(NSString *)orderColumn;
- (NSArray *)fetchRecordsForEntity:(NSString *)entityName predicate:(NSPredicate *)predicate orderBy:(NSArray *)orderByColumns;

- (NSManagedObject *)fetchRecordForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column;
- (NSManagedObject *)fetchRecordForEntity:(NSString *)entityName havingValuesForKeys:(NSDictionary *)valuesForKeys;
- (NSUInteger)countRecordsForEntity:(NSString *)entityName;
- (NSUInteger)countRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column;
- (void)deleteRecord:(NSManagedObject *)record;

- (void)initDatabase:(NSString *)filePath;






@end




