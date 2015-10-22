//
//  PickerViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"
#import "AddNewMovieViewControllerProtocol.h"

/**
 *  This controller contains a UIPickerView to select a predefined value.
 */
@interface PickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, ViewControllerProtocol>

/**
 *  The title values to popultale on picker view rows.
 */
@property (nonatomic) NSArray *pickerViewRowTitles;

/**
 *  The index of the selected row of the picker view.
 */
@property (nonatomic) NSNumber *selectedRow;

/**
 *  Delegate that have implemented methods to receive the selected value.
 */
@property (nonatomic, weak) id<AddNewMovieViewControllerProtocol> delegate;

/**
 *  Name of the view controller for recognize the related attribute of the selected value.
 */
@property (nonatomic) NSString *name;

@end
