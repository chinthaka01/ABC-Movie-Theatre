//
//  CoreDataManager.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 *  Manage sqlite DB and its' contents using Core Data framework.
 */
@interface CoreDataManager : NSObject

/**
 *  The ManagedObjectContext to use for view entitites purpose.
 */
@property (nonatomic, readonly) NSManagedObjectContext *viewManagedObjectContext;

/**
 *  The ManagedObjectContext to use for save retrieved data from web services or access the saved entities for web service calls.
 */
@property (nonatomic, readonly) NSManagedObjectContext *syncManagedObjectContext;

/**
 *  Perform singleton instantiation of CoreDataManager.
 *
 *  @return The singleton instance of CoreDataManager.
 */
+ (CoreDataManager *)sharedInstance;

/**
 *  Perform save the cached entities in SyncManagedObjectContext into the sqlite DB.
 *
 *  @param handler The callback to perform after the save completion.
 */
- (void)saveContext:(void (^)(BOOL, NSError *))handler;

@end
