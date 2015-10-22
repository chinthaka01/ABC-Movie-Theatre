//
//  DataHandlerBase.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

@class CoreDataManager;

/**
 *  Use as the parent class of the all the Core Data entitties accessor classes.
 */
@interface DataHandlerBase : NSObject

/**
 *  Singleton instance to get the managed object contexts which have defined for view data, store or retrieve data ralated to web services.
 */
@property (nonatomic) CoreDataManager *coreDataManager;

/**
 *  Creates a new Core Data entity in SyncManagedObjectContext.
 *
 *  @param type The type of the Core Data entity to be created.
 *
 *  @return Created new Core Data entity with given type.
 */
- (id)getNewEntityByType:(NSString *)type;

/**
 *  Retrieves the Core Data entities with the given query with the fetch request.
 *
 *  @param request              The request to fetch the entities from the given ManagedObjectContext.
 *  @param managedObjectContext The ManagedObjectContext to use to fetch the entitites.
 *
 *  @return Retrived entites by the fetch request.
 */
- (id)retrieveEntityWithRequest:(NSFetchRequest *)request
         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
