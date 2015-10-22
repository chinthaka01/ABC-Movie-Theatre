//
//  CreateAlertsHelper.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The protocol to define the delegate methods to be called after user actions on the alert view.
 */
@protocol CreateAlertsHelperProtocol <NSObject>

/**
 *  The delegate method to be called after the user tap on a button of the alert view.
 *
 *  @param buttonIndex Index of the tapped button.
 *  @param alertView   The alert view object.
 */
- (void)tappedButtonAtIndex:(NSInteger)buttonIndex ofAlertView:(UIAlertView *)alertView;

@end

/**
 *  Use this class to create an alert view. The delegate of this class will be called after the user tap on a button.
 */
@interface CreateAlertsHelper : NSObject <UIAlertViewDelegate>

@property (weak,nonatomic) id<CreateAlertsHelperProtocol> delegate;

@property (nonatomic) UIAlertView *alert;

/**
 *  Create one or more Button(s) Alert with Given Button Titles
 *
 *  @param title             Title of the message
 *  @param message           Desciption of the message
 *  @param tag               tag of message view
 *  @param cancelButtonTitle Cancel Button Title
 *  @param otherButtonTitles Other Button Titles Array
 */
- (void)createMultipleButtonsAlertWithTitle:(NSString*)title
                                    message:(NSString *)message
                                        tag:(int)tag
                          cancelButtonTitle:(NSString *)cancelButtonTitle
                          otherButtonTitles:(NSArray *)otherButtonTitles;

@end
