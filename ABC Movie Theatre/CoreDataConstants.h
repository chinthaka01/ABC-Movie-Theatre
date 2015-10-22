//
//  CoreDataConstants.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The constants ralated to access the core data entity.
 */
@interface CoreDataConstants : NSObject

/**
 *  Core Data Managed Object names.
 */
extern NSString *const MOVIE_ENTITY;
extern NSString *const GENRE_ENTITY;

/**
 *  Core Data Managed Object's attribute names.
 */
extern NSString *const NAME_ATTRIBUTE;
extern NSString *const YEAR_ATTRIBUTE;
extern NSString *const FICTION_ATTRIBUTE;
extern NSString *const CAST_ATTRIBUTE;
extern NSString *const SCORE_ATTRIBUTE;

extern NSString *const GENRE_ATTRIBUTE;

@end
