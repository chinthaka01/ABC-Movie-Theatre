//
//  MovieDataHandler.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "DataHandlerBase.h"

@class Movie;

/**
 *  This class is used to interact with the Movie Core Data entity.
 */
@interface MovieDataHandler : DataHandlerBase

/**
 *  Retrieve a Movie core data entity with the given name.
 *
 *  @param movieName            The value of the name attribute of the movie object.
 *  @param managedObjectContext The managed object context which should contain the movie object.
 *
 *  @return The Movie core data entity object if exist with the given name.
 */
- (Movie *)retrieveMovie:(NSString *)movieName
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 *  Create a new entity and set the given attribute values to it. We do not edit and a existing Movie entities here.
 *
 *  @param movieInfo The attribute values of the Movie entity to be stored with new Movie entity.
 */
- (void)storeMovieInfo:(NSDictionary *)movieInfo;

@end
