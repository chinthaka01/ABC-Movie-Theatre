//
//  CastMembersViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/21/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "CastMembersViewController.h"

@interface CastMembersViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CastMembersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.membersOfCast == nil) {
        self.membersOfCast = [[NSMutableArray alloc] init];
    }
    
    [self configureViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma ViewControllerProtocol methods.

- (void)configureViewComponents {
    
    self.title = NSLocalizedString(@"CAST", nil);
    
    /**
     This will remove the extra empty cells from the table view.
     
     - returns: UIView with zero height as the table footer.
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.hidesBackButton = YES;
    [self configureDoneButton];
}

#pragma TextFieldViewCellDelegate methods.

- (void)textFieldDidEndEditingWithValue:(NSString *)value {
    if (value) {
        [self.membersOfCast addObject:value];
        [self.tableView reloadData];
    }
}

#pragma mark UITableViewDataSource methods.

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    int numberOfRows;
    
    if (self.membersOfCast && self.membersOfCast.count > 0) {
        numberOfRows = (int)self.membersOfCast.count + 1;
    } else {
        numberOfRows = 1;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = (TextFieldViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldViewCell"];
        if (cell == nil) {
            cell = [self loadTextFieldTableViewCell];
        }
        
        ((TextFieldViewCell *)cell).inputField.placeholder = NSLocalizedString(@"ENTER_CAST_MEMBER_NAME", nil);
        ((TextFieldViewCell *)cell).delegate = self;
    } else {
        
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CastMemberNameCell"];
        
        if (cell == nil) {
            cell = [self loadCastMemberNameCell];
        }
        
        cell.textLabel.text = [self.membersOfCast objectAtIndex:(indexPath.row - 1)];
    }
    
    return cell;
}

#pragma Private methods.

/**
 *  Adding a button to the navigation bar to navigate back.
 */
- (void)configureDoneButton {
    
    NSString *buttonTitle = NSLocalizedString(@"DONE", nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(submitCastMembers)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

/**
 *  Submit the added cast members to the delegate.
 */
- (void)submitCastMembers {
    
    [self.delegate addedValue:self.membersOfCast forAttributeName:self.name];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Table view configuration methods.

/**
 * Reuses previous table cell for enter a new cast name.
 */
- (TextFieldViewCell *)loadTextFieldTableViewCell {
    TextFieldViewCell *cell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TextFieldViewCell"
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[TextFieldViewCell class]]) {
            cell = (TextFieldViewCell *)currentObject;
            break;
        }
    }
    
    return cell;
}

/**
 * Reuses previous table cell for load a name of member of cast.
 */
- (UITableViewCell *)loadCastMemberNameCell {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CastMemberNameCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
