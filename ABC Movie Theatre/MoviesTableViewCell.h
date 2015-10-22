//
//  MoviesTableViewCell.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

/**
 *  Protocol to declaire a method to inform user actions on the cell.
 */
@protocol MoviesTableViewCellProtocol <NSObject>

/**
 *  Call when the user tap on view member of cast.
 *
 *  @param castMembers List of cast members of the selected movie.
 */
- (void)navigateToViewCastMembers:(NSArray *)castMembers;

@end

/**
 *  The custom table cell of the movie list table view.
 */
@interface MoviesTableViewCell : UITableViewCell

/**
 *  The Movie core data entity object that contain the movie details to show.
 */
@property (nonatomic) Movie *movie;

@property (nonatomic, weak) id<MoviesTableViewCellProtocol> delegate;

/**
 *  Populate the name of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UILabel *movieNameLabel;

/**
 *  Populate the year of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;

/**
 *  Populate the genre of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;

/**
 *  Populate the score of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

/**
 *  Populate the fiction of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UILabel *fictionLabel;

/**
 *  Populate the cast members of the movie attribute value.
 */
@property (nonatomic, weak) IBOutlet UIButton *viewCastMemberList;

/**
 *  The method to perform after the View Cast Members button tap.
 *
 *  @param sender The button
 */
- (IBAction)viewCastMembers:(id)sender;

@end
