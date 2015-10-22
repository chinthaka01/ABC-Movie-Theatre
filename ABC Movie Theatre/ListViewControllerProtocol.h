//
//  ListViewControllerProtocol.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "ViewControllerProtocol.h"

/**
 *  Define delegate methods to implement in view controllers which are used to populate list of data through FetchedResultViewControllers.
 */
@protocol ListViewControllerProtocol <ViewControllerProtocol>

/**
 *  Ask to the FetchedResultViewController instance to fetch data.
 */
- (void)performFetch;

@end
