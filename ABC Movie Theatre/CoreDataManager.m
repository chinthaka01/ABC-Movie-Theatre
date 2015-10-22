//
//  CoreDataManager.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()

/**
 *  Parent ManagedObjectContext to use for the ManagedObjectContexts that are used for several business purposes.
 */
@property (nonatomic, readonly) NSManagedObjectContext *parentManagedObjectContext;

/**
 *  ManagedObjectModel instance for the application.
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

/**
 *  PersistentStoreCoordinator instance for the application.
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

@synthesize viewManagedObjectContext = _viewManagedObjectContext;
@synthesize syncManagedObjectContext = _syncManagedObjectContext;
@synthesize parentManagedObjectContext = _parentManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

# pragma mark Singleton instantiation of CoreDataManager.

+ (CoreDataManager *)sharedInstance {
    static CoreDataManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CoreDataManager alloc] init];
    });
    
    return _sharedInstance;
}

/**
 *  The directory the application uses to store the Core Data store file. This code uses a directory named "com.abc.ABC_Movie_Theatre" in the application's documents directory.
 *
 *  @return The directory the application uses to store the Core Data store file.
 */
- (NSURL *)applicationDocumentsDirectory {

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 *  The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
 *
 *  @return The managed object model for the application.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ABC_Movie_Theatre" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 *  The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
 *
 *  @return The persistent store coordinator for the application.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ABC_Movie_Theatre.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

/**
 *  Instantiate parentManagedObjectContext.
 *
 *  @return parentManagedObjectContext instance for the application.
 */
- (NSManagedObjectContext *)parentManagedObjectContext {
    if (_parentManagedObjectContext != nil) {
        return _parentManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _parentManagedObjectContext = [[NSManagedObjectContext alloc]
                                       initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_parentManagedObjectContext setPersistentStoreCoordinator:coordinator];
    } else {
        return nil;
    }
    
    return _parentManagedObjectContext;
}

/**
 *  Instantiate viewManagedObjectContext.
 *
 *  @return viewManagedObjectContext instance for the application.
 */
- (NSManagedObjectContext *)viewManagedObjectContext {
    if (_viewManagedObjectContext != nil) {
        return _viewManagedObjectContext;
    } else {
        _viewManagedObjectContext = [[NSManagedObjectContext alloc]
                                     initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        _viewManagedObjectContext.parentContext = [self parentManagedObjectContext];
        
        return _viewManagedObjectContext;
    }
    
}

/**
 *  Instantiate syncManagedObjectContext.
 *
 *  @return syncManagedObjectContext instance for the application.
 */
- (NSManagedObjectContext *)syncManagedObjectContext {
    if (_syncManagedObjectContext != nil) {
        return _syncManagedObjectContext;
    }
    
    _syncManagedObjectContext = [[NSManagedObjectContext alloc]
                                 initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _syncManagedObjectContext.parentContext = [self parentManagedObjectContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeChanges:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:[self parentManagedObjectContext]];
    
    return _syncManagedObjectContext;
}

/**
 *  Merge changes into the default context on the main thread
 *
 *  @param Received notification Notification object.
 */
- (void)mergeChanges:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        
                       @try {
                           [[self viewManagedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
                       } @catch (NSException *exception) {
                       }
                   });
}

#pragma mark - Core Data Saving support

- (void)saveContext:(void (^)(BOOL, NSError *))handler {
    [_syncManagedObjectContext performBlock:^{
        
        // push to parent
        NSError *error;
        if (![_syncManagedObjectContext save:&error]) {
            handler(NO, error);
        } else {
            // save parent to disk asynchronously
            [_parentManagedObjectContext performBlockAndWait:^{
                NSError *error;
                if (![_parentManagedObjectContext save:&error]) {
                    handler(NO, error);
                }
                else {
                    handler(YES, error);
                }
            }];
        }
    }];
}

@end
