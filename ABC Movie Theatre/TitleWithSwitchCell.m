//
//  TitleWithSwitchCell.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "TitleWithSwitchCell.h"

@implementation TitleWithSwitchCell

- (void)awakeFromNib {
    [self.optionSelectSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
}

/**
 *  The selector to perform after a change is occured of the UISwitch component.
 *
 *  @param sender The UISwitch component.
 */
- (void)setState:(id)sender {
    NSNumber *state = [NSNumber numberWithBool:[sender isOn]];
    [self.delegate addedValue:state forAttributeName:self.cellName];
}

#pragma mark Accessor methods of the properties.

- (void)setSelectedState:(NSNumber *)selectedState {
    _selectedState = selectedState;
    [self.optionSelectSwitch setOn:[selectedState boolValue] animated:NO];
}

@end
