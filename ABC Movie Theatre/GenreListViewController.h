//
//  GenreListViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "BaseListViewController.h"
#import "Genre.h"
#import "AddNewMovieViewControllerProtocol.h"
#import "CreateAlertsHelper.h"

/**
 *  Populate the list of Genres and let the user to select one of them.
 */
@interface GenreListViewController : BaseListViewController <UITableViewDataSource, UITableViewDelegate>

/**
 *  The selected genre from the list.
 */
@property (nonatomic) Genre *selectedGenre;

/**
 *  Delegate that have implemented methods to receive the selected value.
 */
@property (nonatomic, weak) id<AddNewMovieViewControllerProtocol> delegate;

/**
 *  Name of the view controller for recognize the related attribute of the selected value.
 */
@property (nonatomic) NSString *name;

@end
