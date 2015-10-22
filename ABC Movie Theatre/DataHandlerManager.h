//
//  DataHandlerManager.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;
@class Genre;
@class NSManagedObjectContext;

/**
 *  This class has exposed methods to access core data entities through the public methods.
 */
@interface DataHandlerManager : NSObject

/**
 *  Perform singleton instantiation of DataHandlerManager.
 *
 *  @return The singleton instance of DataHandlerManager.
 */
+ (DataHandlerManager *)sharedInstance;

/**
 *  Store the attribute values for movie entity objects' in SyncManagedObjectContext.
 *
 *  @param moviesInfo The attribute values for movie entity objects'.
 */
- (void)storeMoviesInfo:(NSArray *)moviesInfo;

/**
 *  Store the attribute values for movie entity that has been added by the user in SyncManagedObjectContext.
 *
 *  @param movieInfo The attribute values for movie entity that has been added by the user.
 *  @param handler   The callback to perform after core data access completion.
 */
- (void)storeAddedMovieInfo:(NSDictionary *)movieInfo
                   callBack:(void (^)())handler;

/**
 *  Store the attribute values for genre entity objects' in SyncManagedObjectContext.
 *
 *  @param genresInfo The attribute values for genre entity objects'.
 */
- (void)storeGenresInfo:(NSArray *)genresInfo;

/**
 *  Retrieve Movie entity from the given ManagedObjectContext which is with the given name attribute value.
 *
 *  @param movieName            Name attribute value to be compared.
 *  @param managedObjectContext The ManagedObjectContext to retrieve a Movie from.
 *
 *  @return The Movie Core Data entity with the given name attribute value.
 */
- (Movie *)retrieveMovie:(NSString *)movieName
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 *  Retrieve Genre entity from the given ManagedObjectContext which is with the given genre attribute value.
 *
 *  @param genre                Genre attribute value to be compared.
 *  @param managedObjectContext The ManagedObjectContext to retrieve a Genre from.
 *
 *  @return The Genre Core Data entity with the given genre attribute value.
 */
- (Genre *)retrieveGenre:(NSString *)genre
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
