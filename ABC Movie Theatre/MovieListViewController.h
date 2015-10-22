//
//  MovieListViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/19/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "BaseListViewController.h"
#import "MoviesTableViewCell.h"
#import "CreateAlertsHelper.h"

/**
 *  This class is used to populate the list of movies.
 */
@interface MovieListViewController : BaseListViewController <UITableViewDataSource, UITableViewDelegate, MoviesTableViewCellProtocol, CreateAlertsHelperProtocol>

@end
