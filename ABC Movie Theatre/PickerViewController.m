//
//  PickerViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

/**
 *  The picker view to select the value.
 */
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@end

@implementation PickerViewController

/**
 *  Instantiate PickerViewController.
 *
 *  @return PickerViewController instance.
 */
- (instancetype)init {
    self = [[[self class] alloc] initWithNibName:@"PickerViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.pickerView selectRow:[self.selectedRow intValue] inComponent:0 animated:NO];
}

#pragma ViewControllerProtocol methods.

- (void)configureViewComponents {
    
    self.navigationItem.hidesBackButton = YES;
    [self configureDoneButton];
}

#pragma UIPickerViewDataSource methods.

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.pickerViewRowTitles.count;
}

#pragma UIPickerViewDelegate methods.

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.pickerViewRowTitles objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedRow = [NSNumber numberWithInteger:row];
}

#pragma mark Private methods.

/**
 *  Configure and add done button into the navigation bar.
 */
- (void)configureDoneButton {
    
    NSString *buttonTitle = NSLocalizedString(@"DONE", nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(submitSelectedValues)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

/**
 *  Submit the selected value to the delegate.
 */
- (void)submitSelectedValues {
    
    NSString *selectedValue = [self.pickerViewRowTitles objectAtIndex:[self.selectedRow integerValue]];
    
    [self.delegate addedValue:selectedValue forAttributeName:self.name];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
