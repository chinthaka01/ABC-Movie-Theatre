//
//  AddNewMovieViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "AddNewMovieViewController.h"
#import "TitleWithLabelCell.h"
#import "TitleWithTextFieldCell.h"
#import "TitleWithSwitchCell.h"
#import "NewMovieTableCellBase.h"
#import "PickerViewController.h"
#import "GenreListViewController.h"
#import "CastMembersViewController.h"
#import "MovieDataModel.h"
#import "WebServiceDataRetrievalManager.h"
#import "Constants.h"
#import "CoreDataConstants.h"
#import "AFNetworkReachabilityManager.h"

const NSString *TITLE_PROPERTY = @"title";
const NSString *PLACEHOLDER_PROPERTY = @"placeholder";
const NSString *TYPE_PROPERTY = @"type";
const NSString *TEXTFIELD_TYPE = @"textfield";
const NSString *PICKER_TYPE = @"picker";
const NSString *SET_OPTION_TYPE = @"set option";
const NSString *MULTIPLE_INPUTS_TYPE = @"multiple inputs";
const NSString *SET_CHOICE_TYPE = @"set choice";
const NSString *MOVIE_NAME_TITLE = @"MOVIE_NAME";
const NSString *YEAR_TITLE = @"YEAR";
const NSString *FICTION_MOVIE_TITLE = @"FICTION_MOVIE";
const NSString *GENRE_TITLE = @"GENRE";
const NSString *SCORE_TITLE = @"SCORE";
const NSString *CAST_TITLE = @"CAST";

const int CANCEL_CONFIRMATION_ALERT_TAG = 1;

@interface AddNewMovieViewController ()

/**
 *  Table view with user input fields to add the attributes of the new movie.
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

/**
 *  Configuration to apply configure and identify the table view cells.
 */
@property (nonatomic) NSArray *tableCellConfigs;

/**
 *  Data model to use to maintain the user inputs.
 */
@property (nonatomic) MovieDataModel *movieDataModel;

/**
 *  Use to access web services.
 */
@property (nonatomic) WebServiceDataRetrievalManager *webServiceDataRetrievalManager;

/**
 *  The helper class to create an alert.
 */
@property (nonatomic) CreateAlertsHelper *alertHelper;

@end

@implementation AddNewMovieViewController

/**
 *  Initialize AddNewMovieViewController.
 *
 *  @return AddNewMovieViewController instance.
 */
- (instancetype)init {
    self = [[[self class] alloc] initWithNibName:@"AddNewMovieViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movieDataModel = [[MovieDataModel alloc] init];
    self.webServiceDataRetrievalManager = [[WebServiceDataRetrievalManager alloc] init];
    
    self.alertHelper = [[CreateAlertsHelper alloc] init];
    self.alertHelper.delegate = self;
    
    [self configureViewComponents];
    [self loadTableCellConfigs];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma ViewControllerProtocol methods.

- (void)configureViewComponents {
    
    self.title = NSLocalizedString(@"NEW_MOVIE_TITLE", nil);
    
    /**
     This will remove the extra empty cells from the table view.
     
     - returns: UIView with zero height as the table footer.
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.hidesBackButton = YES;
    [self configureNavigationButtons];
}

#pragma AddNewMovieViewControllerDelegate methods.

- (void)addedValue:(id)value forAttributeName:(NSString *)attributeName {
    
    if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", MOVIE_NAME_TITLE]]) {
        
        [self.movieDataModel setMovieName:(NSString *)value];
    } else if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", YEAR_TITLE]]) {
        
        [self.movieDataModel setYear:(NSString *)value];
    } else if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", GENRE_TITLE]]) {
        
        [self.movieDataModel setGenre:(Genre *)value];
    } else if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", FICTION_MOVIE_TITLE]]) {
        
        [self.movieDataModel setFiction:(NSNumber *)value];
    } else if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", CAST_TITLE]]) {
        
        [self.movieDataModel setCast:(NSArray *)value];
    } else if ([attributeName isEqualToString:[NSString stringWithFormat:@"%@", SCORE_TITLE]]) {
        
        [self.movieDataModel setScore:[NSNumber numberWithInt:[(NSString *)value intValue]]];
    }
    
    [self.tableView reloadData];
}

#pragma mark CreateAlertsHelperProtocol delegate methods.

- (void)tappedButtonAtIndex:(NSInteger)buttonIndex ofAlertView:(UIAlertView *)alertView {
    
    if (alertView.tag == CANCEL_CONFIRMATION_ALERT_TAG) {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark UITableViewDataSource methods.

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (self.tableCellConfigs) {
        return self.tableCellConfigs.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellConfigs = [self.tableCellConfigs objectAtIndex:indexPath.row];
    NSString *cellType = cellConfigs[TYPE_PROPERTY];
    
    NewMovieTableCellBase *cell = (NewMovieTableCellBase *)[tableView dequeueReusableCellWithIdentifier:cellType];
    
    if (cell == nil) {
        
        if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", TEXTFIELD_TYPE]]) {
            
            cell = [self loadTitleWithTextFieldCell];
        } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", PICKER_TYPE]]) {
            
            cell = [self loadTileWithLabelCell];
        } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", SET_OPTION_TYPE]]) {
            
            cell = [self loadTitleWithSwitchCell];
        } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", MULTIPLE_INPUTS_TYPE]]) {
            
            cell = [self loadTileWithLabelCell];
        } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", SET_CHOICE_TYPE]]) {
            
            cell = [self loadTileWithLabelCell];
        }
    }
    
    [self configureCell:cell withCellConfigs:cellConfigs];
    
    return cell;
}

#pragma mark UITableViewDelegate methods.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellConfigs = [self.tableCellConfigs objectAtIndex:indexPath.row];
    NSString *cellType = cellConfigs[TYPE_PROPERTY];
    NSString *cellTitle = cellConfigs[TITLE_PROPERTY];
    
    if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", PICKER_TYPE]]) {
        
        PickerViewController *pickerViewController = [[PickerViewController alloc] init];
        
        NSArray *pickerViewRowTitles;
        NSNumber *selectedRow;
        
        if ([cellTitle isEqualToString:[NSString stringWithFormat:@"%@", YEAR_TITLE]]) {
            
            pickerViewRowTitles = [self loadYearPickerViewRowTitles];
            selectedRow = [self setSelectYearPickerViewRow:pickerViewRowTitles];
            
            self.movieDataModel.year = [pickerViewRowTitles objectAtIndex:[selectedRow intValue]];
            
            pickerViewController.title = NSLocalizedString(@"SELECT_YEAR", nil);
            pickerViewController.name = [NSString stringWithFormat:@"%@", YEAR_TITLE];
        } else if ([cellTitle isEqualToString:[NSString stringWithFormat:@"%@", SCORE_TITLE]]) {
            
            pickerViewRowTitles = [self loadScorePickerViewRowTitles];
            selectedRow = [self setSelectScorePickerViewRow:pickerViewRowTitles];
            
            NSNumber *score = [NSNumber numberWithInt:[[pickerViewRowTitles objectAtIndex:[selectedRow intValue]] intValue]];
            self.movieDataModel.score = score;
            
            pickerViewController.title = NSLocalizedString(@"SELECT_SCORE", nil);
            pickerViewController.name = [NSString stringWithFormat:@"%@", SCORE_TITLE];
        }
        
        pickerViewController.pickerViewRowTitles = pickerViewRowTitles;
        pickerViewController.selectedRow = selectedRow;
        pickerViewController.delegate = self;
        
        [self.navigationController pushViewController:pickerViewController animated:YES];
        
    } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", SET_CHOICE_TYPE]]) {
        
        if ([cellTitle isEqualToString:[NSString stringWithFormat:@"%@", GENRE_TITLE]]) {
            
            GenreListViewController *genreListViewController = [[GenreListViewController alloc] init];
            genreListViewController.delegate = self;
            genreListViewController.name = [NSString stringWithFormat:@"%@", GENRE_TITLE];
            
            if (self.movieDataModel.genre) {
                genreListViewController.selectedGenre = self.movieDataModel.genre;
            }
            
            [self.navigationController pushViewController:genreListViewController animated:YES];
        }
    } else if ([cellType isEqualToString:[NSString stringWithFormat:@"%@", MULTIPLE_INPUTS_TYPE]]) {
        
        if ([cellTitle isEqualToString:[NSString stringWithFormat:@"%@", CAST_TITLE]]) {
            
            CastMembersViewController *castMembersViewController = [[CastMembersViewController alloc] init];
            castMembersViewController.delegate = self;
            castMembersViewController.name = [NSString stringWithFormat:@"%@", CAST_TITLE];
            
            if (self.movieDataModel.cast) {
                castMembersViewController.membersOfCast = [NSMutableArray arrayWithArray:self.movieDataModel.cast];
            }
            
            [self.navigationController pushViewController:castMembersViewController animated:YES];
        }
    }
}

#pragma Private methods

/**
 *  Configure and add the navigation bar buttons to the navigation bar.
 */
- (void)configureNavigationButtons {
    
    NSString *doneButtonTitle = NSLocalizedString(@"DONE", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"CANCEL", nil);
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:doneButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(shareMovie)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancelButtonTitle
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(cancel)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
}

/**
 *  Share the added new movie via web service.
 */
- (void)shareMovie {
    
    if ([self.movieDataModel validateRequeiredDataExistence]) {
        
        if ([self.movieDataModel validateMovieName]) {
            
            if ([AFNetworkReachabilityManager sharedManager].reachable) {
                
                [self storeNewMovie];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                              message:NSLocalizedString(@"NETWORK_NOT_AVAILABLE", nil)
                                                                  tag:DEFAULT_ALERT_VIEW_TAG cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                    otherButtonTitles:nil];
            }
        } else {
            [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                          message:NSLocalizedString(@"MOVIE_ALREADY_EXIST", nil)
                                                              tag:DEFAULT_ALERT_VIEW_TAG cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                otherButtonTitles:nil];
        }
    } else {
        [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                      message:NSLocalizedString(@"SOME_FIELDS_ARE_MISSING", nil)
                                                          tag:DEFAULT_ALERT_VIEW_TAG cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                            otherButtonTitles:nil];
    }
}

/**
 *  Get confirmed whether the user really want to cancel.
 */
- (void)cancel {
    
    [self.alertHelper createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                  message:NSLocalizedString(@"CANCEL_CONFIRMATION", nil)
                                                      tag:CANCEL_CONFIRMATION_ALERT_TAG
                                        cancelButtonTitle:NSLocalizedString(@"NO", nil)
                                        otherButtonTitles:[NSArray arrayWithObjects:NSLocalizedString(@"YES", nil), nil]];
}

/**
 *  Invoke web service to share the new movie info.
 */
- (void)storeNewMovie {
    
    NSMutableDictionary *newMovie = [[NSMutableDictionary alloc] init];
    newMovie[NAME_ATTRIBUTE] = self.movieDataModel.movieName;
    newMovie[YEAR_ATTRIBUTE] = self.movieDataModel.year;
    newMovie[GENRE_ATTRIBUTE] = self.movieDataModel.genre.genre;
    newMovie[FICTION_ATTRIBUTE] = [self.movieDataModel.fiction boolValue] ? @YES : @NO;
    newMovie[CAST_ATTRIBUTE] = self.movieDataModel.cast;
    newMovie[SCORE_ATTRIBUTE] = self.movieDataModel.score;
    
    __weak typeof(CreateAlertsHelper) *weakAlert = _alertHelper;
    
    [self.webServiceDataRetrievalManager addMovie:newMovie callBack:^(NSError *error) {
        
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MOVIE_LIST_NOTIFICATION
                                                                object:nil
                                                              userInfo:nil];
        } else {
            [weakAlert createMultipleButtonsAlertWithTitle:NSLocalizedString(@"ABC_MOVIES", nil)
                                                          message:error.description
                                                              tag:DEFAULT_ALERT_VIEW_TAG cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                otherButtonTitles:nil];
        }
    }];
}

/**
 *  Get the table cell configuration from the property list.
 */
- (void)loadTableCellConfigs {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"NewMovieProperties" ofType:@"plist"];
    self.tableCellConfigs = [[NSArray alloc] initWithContentsOfFile:path];
}

/**
 *  Get TitleWithLabelCell cell instance.
 *
 *  @return TitleWithLabelCell cell instance.
 */
- (TitleWithLabelCell *)loadTileWithLabelCell {
    
    TitleWithLabelCell *tableViewCell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TitleWithLabelCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[TitleWithLabelCell class]]) {
            tableViewCell = (TitleWithLabelCell *)currentObject;
            break;
        }
    }
    
    return tableViewCell;
}

/**
 *  Get TitleWithTextFieldCell cell instance.
 *
 *  @return TitleWithTextFieldCell cell instance.
 */
- (TitleWithTextFieldCell *)loadTitleWithTextFieldCell {
    
    TitleWithTextFieldCell *tableViewCell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TitleWithTextFieldCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[TitleWithTextFieldCell class]]) {
            tableViewCell = (TitleWithTextFieldCell *)currentObject;
            break;
        }
    }
    
    return tableViewCell;
}

/**
 *  Get TitleWithSwitchCell cell instance.
 *
 *  @return TitleWithSwitchCell cell instance.
 */
- (TitleWithSwitchCell *)loadTitleWithSwitchCell {
    
    TitleWithSwitchCell *tableViewCell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TitleWithSwitchCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[TitleWithSwitchCell class]]) {
            tableViewCell = (TitleWithSwitchCell *)currentObject;
            break;
        }
    }
    
    return tableViewCell;
}

/**
 *  Configure the cell.
 *
 *  @param cell        The cell to be configured
 *  @param cellConfigs The configurations to apply to the cell.
 */
- (void)configureCell:(NewMovieTableCellBase *)cell withCellConfigs:(NSDictionary *)cellConfigs {
    
    cell.titleLabel.text = NSLocalizedString(cellConfigs[TITLE_PROPERTY], nil);
    cell.delegate = self;
    cell.cellName = cellConfigs[TITLE_PROPERTY];
    
    if ([cell respondsToSelector:@selector(setPlaceholder:)]) {
        
        NSString *placeholder = cellConfigs[PLACEHOLDER_PROPERTY];
        if (placeholder) {
            [cell setPlaceholder:NSLocalizedString(placeholder, nil)];
        }
    }
    
    if ([cell isKindOfClass:[TitleWithTextFieldCell class]]) {
        ((TitleWithTextFieldCell *)cell).inputField.delegate = (TitleWithTextFieldCell *)cell;
    }
    
    if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", MOVIE_NAME_TITLE]]) {
        
        if (self.movieDataModel.movieName) {
            ((TitleWithTextFieldCell *)cell).inputField.text = self.movieDataModel.movieName;
        }
    } else if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", YEAR_TITLE]]) {
        
        if (self.movieDataModel.year) {
            ((TitleWithLabelCell *)cell).valueLabel.text = self.movieDataModel.year;
        }
    } else if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", GENRE_TITLE]]) {
        
        if (self.movieDataModel.genre) {
            ((TitleWithLabelCell *)cell).valueLabel.text = self.movieDataModel.genre.genre;
        }
    } else if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", FICTION_MOVIE_TITLE]]) {
        
        if (self.movieDataModel.fiction) {
            [((TitleWithSwitchCell *)cell).optionSelectSwitch setOn:[self.movieDataModel.fiction boolValue] animated:NO];
        } else {
            self.movieDataModel.fiction = [NSNumber numberWithBool:YES];
        }
    } else if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", CAST_TITLE]]) {
        
        if (self.movieDataModel.cast) {
            ((TitleWithLabelCell *)cell).valueLabel.text = [self convertCastMemberArrayToString:self.movieDataModel.cast];
        }
    } else if ([cellConfigs[TITLE_PROPERTY] isEqualToString:[NSString stringWithFormat:@"%@", SCORE_TITLE]]) {
        
        if (self.movieDataModel.score) {
            ((TitleWithLabelCell *)cell).valueLabel.text = [self.movieDataModel.score stringValue];
        }
    }
}

/**
 *  Convert the array of cast member names to a comma seperated string.
 *
 *  @param castMembers The array of cast member names.
 *
 *  @return Comma seperated string of the array of cast member names.
 */
- (NSString *)convertCastMemberArrayToString:(NSArray *)castMembers {
    
    NSMutableString *strCastMemberList;
    
    for (NSString *memberName in castMembers) {
        if (strCastMemberList == nil) {
            strCastMemberList = [[NSMutableString alloc] initWithString:memberName];
        } else {
            [strCastMemberList appendFormat:@", %@", memberName];
        }
    }
    
    return [NSString stringWithFormat:@"%@", strCastMemberList];
}

/**
 *  Load the row title values of the score select picker view
 *
 *  @return The values of the row titles of the picker view.
 */
- (NSArray *)loadScorePickerViewRowTitles {
    
    NSMutableArray *rowTitles = [[NSMutableArray alloc] init];
    
    int maxValue = 10;
    
    for (int i = 0; i < maxValue; i++) {
        int value = maxValue - i;
        [rowTitles addObject:[NSString stringWithFormat:@"%d", value]];
    }
    
    return rowTitles;
}

/**
 *  Load the row title values of the year select picker view
 *
 *  @return The values of the row titles of the picker view.
 */
- (NSArray *)loadYearPickerViewRowTitles {
    
    NSMutableArray *rowTitles = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *strCurrentYear = [formatter stringFromDate:[NSDate date]];
    int currentYear = [strCurrentYear intValue];
    
    int rowCount = 100;
    
    for (int i = 0; i < rowCount; i++) {
        int value = currentYear - i;
        [rowTitles addObject:[NSString stringWithFormat:@"%d", value]];
    }
    
    return rowTitles;
}

/**
 *  Set the selected row index of the year select picker view.
 *
 *  @param rowTitles The row titles of the picker view.
 *
 *  @return The selected row index of the picker view.
 */
- (NSNumber *)setSelectYearPickerViewRow:(NSArray *)rowTitles {
    
    int selectedRow = 0;
    if (self.movieDataModel.year) {
        
        int row = (int)[rowTitles indexOfObject:self.movieDataModel.year];
        
        if (row != -1) {
            selectedRow = row;
        }
    }
    
    return [NSNumber numberWithInt:selectedRow];
}

/**
 *  Set the selected row index of the score select picker view.
 *
 *  @param rowTitles The row titles of the picker view.
 *
 *  @return The selected row index of the picker view.
 */
- (NSNumber *)setSelectScorePickerViewRow:(NSArray *)rowTitles {
    
    int selectedRow = 5;
    if (self.movieDataModel.score) {
        
        int row = (int)[rowTitles indexOfObject:[self.movieDataModel.score stringValue]];
        
        if (row != -1) {
            selectedRow = row;
        }
    }
    
    return [NSNumber numberWithInt:selectedRow];
}

@end
