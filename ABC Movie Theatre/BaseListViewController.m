//
//  BaseListViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "BaseListViewController.h"

@interface BaseListViewController ()

/**
 *  Instance to query the relevant data for the view.
 */
@property (nonatomic) NSPredicate *predicate;

/**
 *  Instance to sort the data for the view.
 */
@property (nonatomic) NSSortDescriptor *sortOrder;

/**
 *  Instance of request to fetch the relevant data for the view.
 */
@property (nonatomic) NSFetchRequest *fetchRequest;

@end

@implementation BaseListViewController

/**
 *  The size of the fetched result batch that fetch per a fetch perform.
 */
const int FETCH_REQUEST_BATCH_SIZE = 10;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.coreDataManger = [CoreDataManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Public methods.

/**
 *  Sets up the fetched results controller with relavant criteria.
 *
 *  @param entityName Name of the entity to fetch
 *  @param sortOrder  sort order to sort the fetched data
 *  @param query to manage the fetch result
 */
- (void)configureFetchedResultControllerWithEntityName:(NSString *)entityName
                                             sortOrder:(NSSortDescriptor *)sortOrder
                                             predicate:(NSPredicate *)predicate {
    
    self.fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    self.sortOrder = sortOrder;
    self.predicate = predicate;
    
    if (self.sortOrder) {
        [self.fetchRequest setSortDescriptors: @[_sortOrder]];
    }
    
    if (self.predicate) {
        [self.fetchRequest setPredicate:self.predicate];
    }
    
    [self.fetchRequest setFetchBatchSize:FETCH_REQUEST_BATCH_SIZE];
    
    NSManagedObjectContext *context = self.coreDataManger.viewManagedObjectContext;
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    self.fetchedResultsController.delegate = self;
}

#pragma mark ViewControllerProtocol delegate methods.

- (void)configureViewComponents {
   // This method should be implemented in inherited classes.
}

#pragma mark ListViewControllerProtocol delegate methods.

- (void)performFetch {
    NSError *error;
    [_fetchedResultsController performFetch:&error];
}

@end
