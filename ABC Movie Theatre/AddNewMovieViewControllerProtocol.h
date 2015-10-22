//
//  AddNewMovieViewControllerProtocol.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

@class MovieDataModel;

/**
 *  Private protocol to define delegate methods to get the user entered values.
 */
@protocol AddNewMovieViewControllerProtocol <NSObject>

/**
 *  Get called after user completed entering values.
 *
 *  @param value         The value entered by the user
 *  @param attributeName Relavant attribute name of the add new movie details form.
 */
- (void)addedValue:(id)value forAttributeName:(NSString *)attributeName;

@end
