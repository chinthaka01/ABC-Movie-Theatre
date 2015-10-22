//
//  DataHandlerBase.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "DataHandlerBase.h"
#import "CoreDataManager.h"

@implementation DataHandlerBase

#pragma mark Initialization of DataHandlerBase.

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.coreDataManager = [CoreDataManager sharedInstance];
    }
    
    return self;
}

#pragma mark Public methods.

- (id)getNewEntityByType:(NSString *)type {
    
    return [NSEntityDescription insertNewObjectForEntityForName:type
                                         inManagedObjectContext:self.coreDataManager.syncManagedObjectContext];
}

- (id)retrieveEntityWithRequest:(NSFetchRequest *)request
         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSError *error = nil;
    NSArray *entityLists = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (entityLists.count != 0) {
        return entityLists[0];
    } else {
        return nil;
    }
}

@end
