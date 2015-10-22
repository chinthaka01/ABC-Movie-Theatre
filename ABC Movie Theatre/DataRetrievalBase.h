//
//  DataRetrievalBase.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Use as the parent class of the all the web service accessor classes.
 */
@interface DataRetrievalBase : NSObject

/**
 *  The method name of the web service.
 */
@property (nonatomic) NSString *requestPath;

/**
 *  Perform the data retrieval web services. This method is called by the child classes to retrieve their specific objects.
 *
 *  @param handler The callback to perform after the web service call completion.
 */
- (void)retrieveDataWithCallBack:(void (^)(NSArray*, NSError *))handler;

/**
 *  Perform the data upload web services. This method is called by the child classes to upload their specific objects.
 *
 *  @param data    The attribute values of a single object.
 *  @param handler handler The callback to perform after the web service call completion.
 */
- (void)sendData:(NSDictionary *)data callBack:(void (^)(NSArray*, NSError *))handler;

@end
