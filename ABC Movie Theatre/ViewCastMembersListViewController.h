//
//  ViewCastMembersListViewController.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"

/**
 *  View controller to populate the cast memebers list.
 */
@interface ViewCastMembersListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ViewControllerProtocol>

/**
 *  List of cast members to be shown.
 */
@property (nonatomic) NSArray *castMembersList;

@end
