//
//  TextFieldViewCell.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The protocol that has defined the delegate methods to implement to hand over the textfield input value to a relevant object.
 */
@protocol TextFieldViewCellDelegate <NSObject>

/**
 *  The delegate method that is called after the textfield was ended editing.
 *
 *  @param value The input value of the textfield.
 */
- (void)textFieldDidEndEditingWithValue:(NSString *)value;

@end

/**
 *  The custom cell which contains only a textfield.
 */
@interface TextFieldViewCell : UITableViewCell <UITextFieldDelegate>

/**
 *  The textfield component of the custom cell.
 */
@property (nonatomic, weak) IBOutlet UITextField *inputField;

/**
 *  The delegate instance that implemented the delegate methods to get the textfield input values.
 */
@property (nonatomic, weak) id<TextFieldViewCellDelegate> delegate;

@end
