//
//  DataManager.m
//  TwentyFourHoursAsia
//
//  Created by Purbo Mamad on 8/6/12.
//  Copyright (c) 2012 Circos. All rights reserved.
//

#import "DataManager.h"


@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize modelURL = _modelURL;
@synthesize storeURL = _storeURL;

- (id)initWithModel:(NSURL *)modelURL store:(NSURL *)storeURL
{
    self = [super init];
    if (self) {
        self.modelURL = modelURL;
        self.storeURL = storeURL;
    }
    return self;
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

static NSString * const POPerThreadManagedObjectContext = @"POPerThreadManagedObjectContext";

- (NSManagedObjectContext *)managedObjectContext
{
    if ([NSThread isMainThread]) {
        
        //DLog(@"Getting managed object context for main thread")
        
        if (_managedObjectContext != nil) {
            return _managedObjectContext;
        }
        
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
        return _managedObjectContext;
        
    } else {
        
        // adapted from: https://gist.github.com/417195
        
        NSThread *currentThread = [NSThread currentThread];
        NSMutableDictionary *threadDictionary = [currentThread threadDictionary];
        
        //DLog(@"Getting managed object context for current thread: %@", currentThread)
        
        NSManagedObjectContext * result = [threadDictionary objectForKey:POPerThreadManagedObjectContext];
        if ( result != nil )
            return ( result );
        
        NSManagedObjectContext * moc = [[NSManagedObjectContext alloc] init];
        [moc setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [moc setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        [threadDictionary setObject:moc forKey:POPerThreadManagedObjectContext];
        
        
        return moc;
    }
}



- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:_modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:_storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Data manipulation

- (NSManagedObject *)createRecordForEntity:(NSString *)entityName
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entity
                                              insertIntoManagedObjectContext:managedObjectContext];
	return managedObject;
}

#pragma mark - Data access

- (NSFetchedResultsController *)fetchedResultsControllerForEntity:(NSString *)entityName orderBy:(NSString *)columnName
{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    if (columnName != nil) {
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:columnName ascending:YES]]];
    }
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:managedObjectContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:[NSString stringWithFormat:@"all-%@-%@", entityName, columnName]];
    
    return frc;
    
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName predicate:(NSPredicate *)predicate orderBy:(NSArray *)orderByColumns
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    
    if (predicate != nil) {
        [request setPredicate:predicate];
    }
    
    if (orderByColumns != nil) {
        [request setSortDescriptors:orderByColumns];
    }
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    return results;
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName
{
    return [self fetchRecordsForEntity:entityName orderBy:nil];
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName orderBy:(NSString *)column
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    if (column != nil) {
        [request setSortDescriptors:[NSArray arrayWithObjects:
                                     [NSSortDescriptor sortDescriptorWithKey:column ascending:YES],
                                     nil]];
    }
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    return results;
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column
{
    return [self fetchRecordsForEntity:entityName havingValue:value forColumn:column orderBy:nil];
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column orderBy:(NSString *)orderColumn
{
    return [self fetchRecordsForEntity:entityName
                           havingValue:value
                             forColumn:column
                               orderBy:orderColumn
                             ascending:YES];
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName
                       havingValue:(id)value
                         forColumn:(NSString *)column
                           orderBy:(NSString *)orderColumn
                         ascending:(BOOL)ascending
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ == %%@", column];
    [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat, value]];
    if (orderColumn != nil) {
        [request setSortDescriptors:[NSArray arrayWithObjects:
                                     [NSSortDescriptor sortDescriptorWithKey:orderColumn ascending:ascending],
                                     nil]];
    }
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    return results;
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValueIn:(NSArray *)values forColumn:(NSString *)column
{
    return [self fetchRecordsForEntity:entityName havingValueIn:values forColumn:column orderBy:nil];
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValueIn:(NSArray *)values forColumn:(NSString *)column orderBy:(NSString *)orderColumn
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ IN %%@", column];
    [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat, values]];
    if (orderColumn != nil) {
        [request setSortDescriptors:[NSArray arrayWithObjects:
                                     [NSSortDescriptor sortDescriptorWithKey:orderColumn ascending:YES],
                                     nil]];
    }
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    return results;
}

- (NSArray *)fetchRecordsForEntity:(NSString *)entityName havingValuesForKeys:(NSDictionary *)valuesForKeys
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    
    NSMutableArray *subpredicates = [NSMutableArray array];
    [valuesForKeys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *predicateFormat = [NSString stringWithFormat:@"%@ == %%@", key];
        NSPredicate *subpredicate = [NSPredicate predicateWithFormat:predicateFormat, obj];
        [subpredicates addObject:subpredicate];
    }];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:subpredicates]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    return results;
}

- (NSManagedObject *)fetchRecordForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ == %%@", column];
    [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat, value]];
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSManagedObject *)fetchRecordForEntity:(NSString *)entityName havingValuesForKeys:(NSDictionary *)valuesForKeys
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    
    NSMutableArray *subpredicates = [NSMutableArray array];
    [valuesForKeys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *predicateFormat = [NSString stringWithFormat:@"%@ == %%@", key];
        NSPredicate *subpredicate = [NSPredicate predicateWithFormat:predicateFormat, obj];
        [subpredicates addObject:subpredicate];
    }];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:subpredicates]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        NSLog(@"Error fetching data: %@", [error localizedDescription]);
    }
    
    if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSUInteger)countRecordsForEntity:(NSString *)entityName
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
    
    NSError *err;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&err];
    if (count == NSNotFound) {
        count = 0;
    }
    
    
    
    return count;
}

- (NSUInteger)countRecordsForEntity:(NSString *)entityName havingValue:(id)value forColumn:(NSString *)column
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ == %%@", column];
    [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat, value]];
    
    NSError *err;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&err];
    if (count == NSNotFound) {
        count = 0;
    }
    
    
    
    return count;
}

- (void)deleteRecord:(NSManagedObject *)record
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    [managedObjectContext deleteObject:record];
}

#pragma mark - Database initialization

- (void)initDatabase:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        //DLog(@"Database doesn't exist, creating DB")
        // TODO: initialize DB here
    }
}


@end
