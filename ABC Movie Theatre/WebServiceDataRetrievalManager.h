//
//  WebServiceDataRetrievalManager.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class has exposed methods to access the web services through the public methods.
 */
@interface WebServiceDataRetrievalManager : NSObject

/**
 *  Perform singleton instantiation of WebServiceDataRetrievalManager.
 *
 *  @return The singleton instance of WebServiceDataRetrievalManager.
 */
+ (WebServiceDataRetrievalManager *)sharedInstance;

/**
 *  Retrieve all the Movie objects using the http://mobiletest.mazarin.lk/movieservice/rest/movies web service.
 *
 *  @param handler The callback to perform after the web service call completion.
 */
- (void)retrieveMoviesWithCallBack:(void (^)(NSError *))handler;

/**
 *  Retrieve all the Genre objects using the http://mobiletest.mazarin.lk/movieservice/rest/movies/genres web service.
 *
 *  @param handler The callback to perform after the web service call completion.
 */
- (void)retrieveGenreWithCallBack:(void (^)(NSError *))handler;

/**
 *  Upload the attribute values of a new movie object added by the user by using http://mobiletest.mazarin.lk/movieservice/rest/movies web service.
 *
 *  @param movieInfo The attribute values of the movie object.
 *  @param handler   The callback to perform after the web service call completion.
 */
- (void)addMovie:(NSDictionary *)movieInfo callBack:(void (^)(NSError *))handler;

@end
