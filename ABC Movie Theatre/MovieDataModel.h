//
//  MovieDataModel.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genre.h"

/**
 *  This is the model class to track the user entered data for add a new movie.
 */
@interface MovieDataModel : NSObject

/**
 *  Name of the new movie.
 */
@property (nonatomic, strong) NSString *movieName;

/**
 *  Produced year of the new movie.
 */
@property (nonatomic, strong) NSString *year;

/**
 *  The genre of the new movie.
 */
@property (nonatomic, strong) Genre *genre;

/**
 *  The fiction state of the new movie.
 */
@property (nonatomic, strong) NSNumber *fiction;

/**
 *  Member of cast names of the new movie.
 */
@property (nonatomic, strong) NSArray *cast;

/**
 *  The score of the new movie.
 */
@property (nonatomic, strong) NSNumber *score;

/**
 *  Validate whether the all properties have been assigned by a value.
 *
 *  @return Valid status of the movie data.
 */
- (BOOL)validateRequeiredDataExistence;

/**
 *  Validate whether the movie is already exist.
 *
 *  @return Valid status of the movie existence.
 */
- (BOOL)validateMovieName;

@end
