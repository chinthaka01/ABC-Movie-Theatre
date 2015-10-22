//
//  TitleWithTextFieldCell.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "NewMovieTableCellBase.h"

/**
 *  The custom table view cell to use with Title + TextField.
 */
@interface TitleWithTextFieldCell : NewMovieTableCellBase <UITextFieldDelegate>

/**
 *  The textfield to enter the use inputs.
 */
@property (nonatomic, weak) IBOutlet UITextField *inputField;

@end
