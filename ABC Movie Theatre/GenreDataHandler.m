//
//  GenreDataHandler.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "GenreDataHandler.h"
#import "CoreDataConstants.h"

@implementation GenreDataHandler

@synthesize coreDataManager;

#pragma mark Initialization of GenreDataHandler.

- (instancetype)init {
    self = [super init];
    return self;
}

#pragma mark Public methods.

- (Genre *)retrieveGenre:(NSString *)genre
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:GENRE_ENTITY];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == [c] %@", GENRE_ATTRIBUTE , genre];
    [request setPredicate:predicate];
    
    return [super retrieveEntityWithRequest:request
                     inManagedObjectContext:managedObjectContext];
}

- (void)storeGenre:(NSString *)genre {
    
    Genre *genreEntity = [self retrieveGenre:genre inManagedObjectContext:self.coreDataManager.syncManagedObjectContext];
    
    if (!genreEntity) {
        genreEntity = [super getNewEntityByType:GENRE_ENTITY];
        genreEntity.genre = genre;
    }
}

@end
