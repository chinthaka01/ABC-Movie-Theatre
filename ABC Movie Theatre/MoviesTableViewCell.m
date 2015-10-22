//
//  MoviesTableViewCell.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "MoviesTableViewCell.h"
#import "Movie.h"

@implementation MoviesTableViewCell

/**
 *  Accessor method of the property named mavie.
 *
 *  @param movie The Movie core data entity to populate using the cell view components.
 */
- (void)setMovie:(Movie *)movie {
    
    _movie = movie;
    [self configureViewComponents];
}

/**
 *  Configurte the UI components of the cell.
 */
- (void)configureViewComponents {
    NSString *fictionLabelText = @"";
    
    if ([self.movie.fiction boolValue]) {
        fictionLabelText = NSLocalizedString(@"A_FICTION_MOVIE", nil);
    }
    
    NSString *viewCastMembersButtonTitle =
    [NSString stringWithFormat:@"%lu %@ >", (unsigned long)[(NSArray *)self.movie.cast count], NSLocalizedString(@"CAST_MEMBERS", nil)];
    NSString *scoreLabelText = [NSString stringWithFormat:@"%d/ 10", [self.movie.score intValue]];
    NSString *yearLabelText = [NSString stringWithFormat:@"(%d)", [self.movie.year intValue]];
    
    self.movieNameLabel.text = self.movie.name;
    self.yearLabel.text = yearLabelText;
    self.genreLabel.text = self.movie.genre;
    self.scoreLabel.text = scoreLabelText;
    self.fictionLabel.text = fictionLabelText;
    [self.viewCastMemberList setTitle: viewCastMembersButtonTitle forState: UIControlStateNormal];
    
    if ([self.movie.cast count] == 0) {
        [self.viewCastMemberList setUserInteractionEnabled:NO];
    }
}

- (IBAction)viewCastMembers:(id)sender {
    [self.delegate navigateToViewCastMembers:(NSArray *)self.movie.cast];
}

@end
