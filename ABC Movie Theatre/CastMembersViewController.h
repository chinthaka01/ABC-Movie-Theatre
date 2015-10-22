//
//  CastMembersViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"
#import "TextFieldViewCell.h"
#import "AddNewMovieViewControllerProtocol.h"

/**
 *  Contains a table view with one text field and rows to populate the enterd values through text fields.
 */
@interface CastMembersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ViewControllerProtocol, TextFieldViewCellDelegate>

/**
 *  The values to populate on the table view cell. When the user add values via text field then those values will be added to this array.
 */
@property (nonatomic) NSMutableArray *membersOfCast;

/**
 *  Delegate that have implemented methods to receive the selected value.
 */
@property (nonatomic, weak) id<AddNewMovieViewControllerProtocol> delegate;

/**
 *  Name of the view controller for recognize the related attribute of the selected value.
 */
@property (nonatomic) NSString *name;

@end
