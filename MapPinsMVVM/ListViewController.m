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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayPins)
                                                 name:@"pinsDidDownload"
                                               object:nil];
}

- (void)displayPins {
    [self.tableView reloadData];
}

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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_viewModel deleteRowAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
