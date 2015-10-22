//
//  TitleWithTextFieldCell.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "TitleWithTextFieldCell.h"

@implementation TitleWithTextFieldCell

#pragma mark Public methods.

- (void)setPlaceholder:(NSString *)placeholder {
    
    if (placeholder) {
        self.inputField.placeholder = NSLocalizedString(placeholder, nil);   
    }
}

#pragma mark UITextFieldDelegate methods.

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.inputField resignFirstResponder];
    return NO;
}

#pragma mark AddNewMovieViewControllerProtocol methods.

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate addedValue:textField.text forAttributeName:self.cellName];
}

@end
