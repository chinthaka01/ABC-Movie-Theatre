//
//  ViewCastMembersListViewController.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "ViewCastMembersListViewController.h"

@interface ViewCastMembersListViewController ()

/**
 *  Table view to populate the cast members.
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ViewCastMembersListViewController

/**
 *  Initialize ViewCastMembersListViewController
 *
 *  @return ViewCastMembersListViewController instance
 */
- (instancetype)init {
    self = [[[self class] alloc] initWithNibName:@"ViewCastMembersListViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureViewComponents];
}

#pragma mark ViewControllerProtocol delegate methods.

- (void)configureViewComponents {
    
    self.title = NSLocalizedString(@"CAST_MEMBERS", nil);
    
    /**
     This will remove the extra empty cells from the table view.
     
     - returns: UIView with zero height as the table footer.
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark UITableViewDataSource methods.

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.castMembersList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
        
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [self.castMembersList objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = [NSString stringWithFormat:@"(%lu) %@", (unsigned long)self.castMembersList.count, NSLocalizedString(@"CAST_MEMBERS", nil)];
    
    return title;
}

@end
