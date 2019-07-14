//
//  ListViewController.h
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ListViewModel;

@interface ListViewController : UITableViewController

@property ListViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
