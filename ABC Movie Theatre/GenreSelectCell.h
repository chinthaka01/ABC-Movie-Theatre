//
//  GenreSelectCell.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Genre;

/**
 *  The custom table view cell to populate a genre value.
 */
@interface GenreSelectCell : UITableViewCell

/**
 *  Label view component to populate the genre value.
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

/**
 *  The Genre core data entity to populate.
 */
@property (nonatomic) Genre *genre;

@end
