//
//  ListViewController.m
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

#import "ListViewController.h"
#import "MapPinsMVVM-Swift.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setRowHeight:70];
    
    [self displayPins];
    
    // listen for when the pins download
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayPins)
                                                 name:@"pinsDidDownload"
                                               object:nil];
}

// called when pins download, and on viewDidLoad
- (void)displayPins {
    [self.tableView reloadData];
}

// refresh button on navigation bar
- (IBAction)resetPins:(UIBarButtonItem *)sender {
    [_viewModel resetPins];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel countRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PinCell *cell = (PinCell*) [tableView dequeueReusableCellWithIdentifier:@"PinCell" forIndexPath:indexPath];
    
    [_viewModel configureWithCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // allow deleting rows
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_viewModel deleteRowAtIndexPath:indexPath];
        
        // remove row from tableview
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
