//
//  NewMovieTableCellBase.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewMovieViewControllerProtocol.h"

/**
 *  This is the base classs for the custom table view cells that has been added into the add new movie table view.
 */
@interface NewMovieTableCellBase : UITableViewCell

/**
 *  The label to show the title of the cell.
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

/**
 *  The name of the cell to recognize its' content.
 */
@property (nonatomic, strong) NSString *cellName;

/**
 *  The delegate that has been defined the delegate methods to be called after user completed the user inputs.
 */
@property (nonatomic, weak) id<AddNewMovieViewControllerProtocol>
delegate;

/**
 *  Selector to set the place holder text on place holder available UI components.
 *
 *  @param placeholder text of the place holder
 */
- (void)setPlaceholder:(NSString *)placeholder;

@end
