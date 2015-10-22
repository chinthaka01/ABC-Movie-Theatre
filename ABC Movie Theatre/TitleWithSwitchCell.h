//
//  TitleWithSwitchCell.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "NewMovieTableCellBase.h"

/**
 *  The custom table view cell to use with Title + Switch.
 */
@interface TitleWithSwitchCell : NewMovieTableCellBase

/**
 *  Use this to set a option.
 */
@property (nonatomic, weak) IBOutlet UISwitch *optionSelectSwitch;

/**
 *  The selected option the switch component.
 */
@property (nonatomic) NSNumber *selectedState;

@end
