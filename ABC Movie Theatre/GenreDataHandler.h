//
//  GenreDataHandler.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "DataHandlerBase.h"
#import "Genre.h"

/**
 *  This class is used to interact with the Genre Core Data entity.
 */
@interface GenreDataHandler : DataHandlerBase

/**
 *  Retrieve a Genre core data entity with the given name.
 *
 *  @param genre                The value of the genre attribute of the genre object.
 *  @param managedObjectContext The managed object context which should contain the genre object.
 *
 *  @return The Genre core data entity object if exist with the given genre value.
 */
- (Genre *)retrieveGenre:(NSString *)genre
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 *  Create a new entity and set the given attribute values to it. We do not edit and a existing Genre entities here.
 *
 *  @param genre The attribute value of the Genre entity to be stored with new Genre entity.
 */
- (void)storeGenre:(NSString *)genre;

@end
