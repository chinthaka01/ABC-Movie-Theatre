//
//  CreateAlertsHelper.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "CreateAlertsHelper.h"

@implementation CreateAlertsHelper

- (void)createMultipleButtonsAlertWithTitle:(NSString*)title
                                    message:(NSString *)message
                                        tag:(int)tag
                          cancelButtonTitle:(NSString *)cancelButtonTitle
                          otherButtonTitles:(NSArray *)otherButtonTitles {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.alert = [[UIAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:self
                                 cancelButtonTitle:cancelButtonTitle
                                 otherButtonTitles:nil];
        
        self.alert.tag = tag;
        
        for (NSString *title in otherButtonTitles) {
            [self.alert addButtonWithTitle:title];
        }
        
        [self.alert show];
    });
}

#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.delegate && alertView && [self.delegate respondsToSelector:@selector(tappedButtonAtIndex:ofAlertView:)]){
        [self.delegate tappedButtonAtIndex:buttonIndex ofAlertView:alertView];
    }
}

@end
