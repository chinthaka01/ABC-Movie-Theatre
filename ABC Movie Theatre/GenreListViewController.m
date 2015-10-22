//
//  GenreListViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "GenreListViewController.h"
#import "GenreSelectCell.h"
#import "AFNetworkReachabilityManager.h"
#import "CreateAlertsHelper.h"
#import "Constants.h"

@interface GenreListViewController ()

/**
 *  The previously selected cells' indexpath.
 */
@property (nonatomic) NSIndexPath *previousCheckedIndexPath;

/**
 *  The helper class to create an alert.
 */
@property (nonatomic) CreateAlertsHelper *alertHelper;

@end

@implementation GenreListViewController

/**
 *  Instantiate GenreListViewController.
 *
 *  @return GenreListViewController instance.
 */
- (instancetype)init {
    
    self = [[[self class] alloc] initWithNibName:@"GenreListViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureFetchedResultControllerWithEntityName:GENRE_ENTITY
                                               sortOrder:[[NSSortDescriptor alloc] initWithKey:GENRE_ATTRIBUTE ascending:YES]
                                               predicate:nil];
    
    [self configureViewComponents];
    
    self.alertHelper = [[CreateAlertsHelper alloc] init];
    
    self.webServiceDataRetrievalManager = [[WebServiceDataRetrievalManager alloc] init];
    [self loadGenreList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Public methods.

- (void)performFetch {
    [super performFetch];
    
    [self.tableView reloadData];
}

#pragma ListViewControllerProtocol methods.

- (void)configureViewComponents {
    
    self.title = NSLocalizedString(@"SELECT_GENRE", nil);
    
    /**
     This will remove the extra empty cells from the table view.
     
     - returns: UIView with zero height as the table footer.
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.hidesBackButton = YES;
    [self configureDoneButton];
}

#pragma mark UITableViewDataSource methods.

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = self.fetchedResultsController.sections;
    return [sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GenreSelectCell *cell = (GenreSelectCell *)[tableView dequeueReusableCellWithIdentifier:@"GenreSelectCell"];
    if (cell == nil) {
        cell = [self loadGenreSelectCell];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

#pragma mark UITableViewDelegate methods.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedGenre = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (self.previousCheckedIndexPath) {
        UITableViewCell *previousSelectedCell = [tableView cellForRowAtIndexPath:self.previousCheckedIndexPath];
        previousSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.previousCheckedIndexPath = indexPath;
}

#pragma Private methods.

/**
 *  Adding a button to the navigation  bar to set genre to the movie and navigate back.
 */
- (void)configureDoneButton {
    
    NSString *buttonTitle = NSLocalizedString(@"DONE", nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(addGenre)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

/**
 *  Submit the selected genre to the delegate.
 */
- (void)addGenre {
    
    [self.delegate addedValue:self.selectedGenre forAttributeName:self.name];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  Invoke the web service and load the genres.
 */
- (void)loadGenreList {
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        [self.webServiceDataRetrievalManager retrieveGenreWithCallBack:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(error) {
                    [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                                  message:error.description
                                                                      tag:DEFAULT_ALERT_VIEW_TAG
                                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                        otherButtonTitles:nil];
                }
                
                [self performFetch];
            });
        }];
    } else {
        [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                      message:NSLocalizedString(@"NETWORK_NOT_AVAILABLE", nil)
                                                          tag:DEFAULT_ALERT_VIEW_TAG
                                            cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                            otherButtonTitles:nil];
        
        [self performFetch];
    }
}

#pragma Table view configuration methods.

/**
 * Reuses previous table cell settings for loading.
 */
- (GenreSelectCell *)loadGenreSelectCell {
    GenreSelectCell *genreSelectCell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GenreSelectCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[GenreSelectCell class]]) {
            genreSelectCell = (GenreSelectCell *)currentObject;
            break;
        }
    }
    
    return genreSelectCell;
}

/**
 * Configures the table view cell at given index.
 * @param cell to be configured.
 * @param indexPath The index to the object in fetched result controller.
 */
- (void)configureCell:(GenreSelectCell *)cell
          atIndexPath:(NSIndexPath *)indexPath {
    Genre *genre = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.genre = genre;
    cell.titleLabel.text = genre.genre;
    
    if (self.selectedGenre && [self.selectedGenre.genre isEqualToString:genre.genre]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.previousCheckedIndexPath = indexPath;
    }
}

@end
