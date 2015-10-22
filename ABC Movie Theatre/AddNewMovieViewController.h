//
//  AddNewMovieViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"
#import "AddNewMovieViewControllerProtocol.h"
#import "CreateAlertsHelper.h"

/**
 *  The view controller that uses to add a new movie details.
 */
@interface AddNewMovieViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ViewControllerProtocol, AddNewMovieViewControllerProtocol, CreateAlertsHelperProtocol>

@end
