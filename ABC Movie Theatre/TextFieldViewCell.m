//
//  TextFieldViewCell.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "TextFieldViewCell.h"

@implementation TextFieldViewCell

#pragma mark UITextFieldDelegate methods.

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.inputField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate textFieldDidEndEditingWithValue:textField.text];
    self.inputField.text = nil;
}

@end
