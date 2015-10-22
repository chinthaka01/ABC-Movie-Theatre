//
//  ViewControllerProtocol.h
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

/**
 *  Define delegate methods to implement in view controllers.
 */
@protocol ViewControllerProtocol <NSObject>

/**
 *  Configure the sub views of the controllers' view before appearing.
 */
- (void)configureViewComponents;

@end
