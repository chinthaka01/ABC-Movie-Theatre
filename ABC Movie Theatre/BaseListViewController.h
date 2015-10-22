//
//  BaseListViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "CoreDataConstants.h"
#import "ListViewControllerProtocol.h"
#import "WebServiceDataRetrievalManager.h"

/**
 *  Parent view controller of list view controllers that use FetchedResultViewControllers. This will manage the FetchedResultViewController instance and the fetch performs.
 */
@interface BaseListViewController : UIViewController <NSFetchedResultsControllerDelegate, ListViewControllerProtocol>

/**
 *  Use to access web services.
 */
@property (nonatomic) WebServiceDataRetrievalManager *webServiceDataRetrievalManager;

/**
 *  Use to get ManagedObjectContexts.
 */
@property (nonatomic) CoreDataManager *coreDataManger;

/**
 *  Instance of NSFetchedResultsController to maintain list of results on the UITableView.
 */
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

/**
 *  Instance of UITableView to display the list of results.
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

/**
 *  Configure the FetchedResultController with given attributes.
 *
 *  @param entityName Entity name to fetch the data.
 *  @param sortOrder  Sort order to apply on the fetching data.
 *  @param predicate  Predicate to apply query on the fetching data.
 */
- (void)configureFetchedResultControllerWithEntityName:(NSString *)entityName
                                             sortOrder:(NSSortDescriptor *)sortOrder
                                             predicate:(NSPredicate *)predicate;

/**
 *  Requests fetchedResultsController to fetch from DB.
 */
- (void)performFetch;

@end
