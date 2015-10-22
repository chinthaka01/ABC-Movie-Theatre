//
//  MovieListViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/19/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "MovieListViewController.h"
#import "AddNewMovieViewController.h"
#import "MovieDataModel.h"
#import "Constants.h"
#import "ViewCastMembersListViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface MovieListViewController ()

/**
 *  The indexPath of the selected cell.
 */
@property (nonatomic) NSIndexPath *selectedRowIndex;

/**
 *  The helper class to create an alert.
 */
@property (nonatomic) CreateAlertsHelper *alertHelper;

@end

const float DEFAULT_ROW_HEIGHT = 80.F;

@implementation MovieListViewController

/**
 *  Initialize MovieListViewController.
 *
 *  @return MovieListViewController instance.
 */
- (instancetype)init {
    
    self = [[[self class] alloc] initWithNibName:@"BaseListViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performFetch)
                                                 name:[NSString stringWithFormat:@"%@", REFRESH_MOVIE_LIST_NOTIFICATION]
                                               object:nil];
    
    [self configureFetchedResultControllerWithEntityName:MOVIE_ENTITY
                                               sortOrder:[[NSSortDescriptor alloc] initWithKey:NAME_ATTRIBUTE ascending:YES]
                                               predicate:nil];
    
    [self configureViewComponents];
    
    self.alertHelper = [[CreateAlertsHelper alloc] init];
    self.alertHelper.delegate = self;
    
    self.webServiceDataRetrievalManager = [[WebServiceDataRetrievalManager alloc] init];
    [self loadMoviesList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Public methods.

- (void)performFetch {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [super performFetch];
        [self.tableView reloadData];
    });
}

#pragma ViewControllerProtocol methods.

- (void)configureViewComponents {
    
    self.title = NSLocalizedString(@"ABC_MOVIES", nil);
    
    /**
     This will remove the extra empty cells from the table view.
     
     - returns: UIView with zero height as the table footer.
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self configureAddMovieButton];
}

#pragma mark MoviesTableViewCellProtocol delegate methods.

- (void)navigateToViewCastMembers:(NSArray *)castMembers {
    
    ViewCastMembersListViewController *viewCastMembersListViewController = [[ViewCastMembersListViewController alloc] init];
    viewCastMembersListViewController.castMembersList = [NSArray arrayWithArray:castMembers];
    
    [self.navigationController pushViewController:viewCastMembersListViewController animated:YES];
}

#pragma mark CreateAlertsHelperProtocol delegate methods

- (void) tappedButtonAtIndex:(NSInteger)buttonIndex ofAlertView:(UIAlertView *)alertView {
    
}

#pragma mark UITableViewDataSource methods.

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = self.fetchedResultsController.sections;
    return [sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesTableViewCell *cell = (MoviesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MoviesTableViewCell"];
    if (cell == nil) {
        cell = [self loadMovieTableViewCell];
    }
    
    cell.fictionLabel.hidden = YES;
    cell.viewCastMemberList.hidden = YES;
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

#pragma UITableViewDelegate methods.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesTableViewCell *cell = (MoviesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectedRowIndex && indexPath.row == self.selectedRowIndex.row) {
        
        self.selectedRowIndex = nil;
        [self manageVisibilityOfCellViewComponent:cell status:YES];
    } else {
        
        if (self.selectedRowIndex) {
            MoviesTableViewCell *previousSelectedCell = (MoviesTableViewCell *)[tableView cellForRowAtIndexPath:self.selectedRowIndex];
            [self manageVisibilityOfCellViewComponent:previousSelectedCell status:YES];
        }
        
        self.selectedRowIndex = indexPath;
        [self manageVisibilityOfCellViewComponent:cell status:NO];
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float additionalHeight = 40.f;

    if(self.selectedRowIndex && indexPath.row == self.selectedRowIndex.row) {
        return DEFAULT_ROW_HEIGHT + additionalHeight;
    }
    
    return DEFAULT_ROW_HEIGHT;
}

#pragma Private methods.

/**
 *  Adding a button to the navigation  bar to navigate to add new movie controller
 */
- (void)configureAddMovieButton {
    
    NSString *buttonTitle = NSLocalizedString(@"ADD_NEW_MOVIE", nil);
    UIBarButtonItem *addMovieButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(addNewMovie)];
    self.navigationItem.rightBarButtonItem = addMovieButton;
}

/**
 *  The action selector of the add movie button to perform the navigation to the add new movie controller.
 */
- (void)addNewMovie {
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        
        AddNewMovieViewController *addNewMovieViewController = [[AddNewMovieViewController alloc] init];
        [self.navigationController pushViewController:addNewMovieViewController animated:YES];
    } else {
        [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                      message:NSLocalizedString(@"NETWORK_NOT_AVAILABLE", nil)
                                                          tag:DEFAULT_ALERT_VIEW_TAG cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                            otherButtonTitles:nil];
    }
}

/**
 *  Load the movie list into the table.
 */
- (void)loadMoviesList {
    
    [self.webServiceDataRetrievalManager retrieveMoviesWithCallBack:^(NSError *error) {
        if(error) {
            [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                          message:error.description
                                                              tag:DEFAULT_ALERT_VIEW_TAG
                                                cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                otherButtonTitles:nil];
        }
        
        [self performFetch];
    }];
}

#pragma Table view configuration methods.

/**
 * Reuses previous table view cell settings for loading.
 */
- (MoviesTableViewCell *)loadMovieTableViewCell {
    
    MoviesTableViewCell *moviesTableViewCell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MoviesTableViewCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        
        if ([currentObject isKindOfClass:[MoviesTableViewCell class]]) {
            
            moviesTableViewCell = (MoviesTableViewCell *)currentObject;
            break;
        }
    }
    
    return moviesTableViewCell;
}

/**
 * Configures the table view cell at given index.
 * @param cell to be configured.
 * @param indexPath The index to the object in fetched result controller.
 */
- (void)configureCell:(MoviesTableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath {
    
    Movie *movie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.movie = movie;
    cell.delegate = self;
}

/**
 *  Set the visibility of fiction and View Cast Members buttons of the cells.
 *
 *  @param cell   cell to manage visibility of the sub views.
 *  @param status The visibility status of the sub views.
 */
- (void)manageVisibilityOfCellViewComponent:(MoviesTableViewCell *)cell status:(BOOL)status {
    
    cell.fictionLabel.hidden = status;
    cell.viewCastMemberList.hidden = status;
}

@end
